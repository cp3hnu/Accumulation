//
//  BannerView.swift
//  Cards
//
//  Created by CP3 on 2018/4/21.
//  Copyright © 2018年 CP3. All rights reserved.
//

import Foundation
import UIKit
import Bricking
import RxSwift

protocol BannerResource {}
extension String: BannerResource {}
extension URL: BannerResource {}
extension UIImage: BannerResource {}

final class BannerView: UIView {
    
    private var timerDisposeBag = DisposeBag()
    private var resources: [BannerResource]
    private let size: CGSize
    private let multiple = 20000
    private let interval = 10
    private var collectionView: UICollectionView!
    private var pageCtrl: UIPageControl!
    var tapAt: ((Int) -> Void)?
    
    init(resources: [BannerResource], size: CGSize) {
        self.resources = resources
        self.size = size
        super.init(frame: CGRect.zero)
        backgroundColor = UIColor.clear
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reload(resources: [BannerResource]) {
        self.resources = resources
        collectionView.reloadData()
        pageCtrl.numberOfPages = resources.count
        pageCtrl.currentPage = 0
        pageCtrl.isHidden = resources.count <= 1
        
        if resources.count > 1 {
            DispatchQueue.main.async {
                let centerIndex = self.multiple / 2 * self.resources.count
                self.collectionView.scrollToItem(at: IndexPath(item: centerIndex, section: 0), at: .left, animated: false)
                self.stopTimer()
                self.startTimer()
            }
        }
    }
}

private extension BannerView {
    func setupView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.itemSize = size
        
        collectionView = UICollectionView(frame: CGRect(origin: CGPoint.zero, size: size), collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.register(BannerImageCell.self, forCellWithReuseIdentifier: BannerImageCell.reuseIdentifier)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
        collectionView.delegate = self
        asv(collectionView)
        collectionView.fillContainer()
        
        pageCtrl = UIPageControl()
        pageCtrl.numberOfPages = resources.count
        pageCtrl.currentPage = 0
        pageCtrl.pageIndicatorTintColor = UIColor.lightGray
        pageCtrl.currentPageIndicatorTintColor = UIColor.System.tint
        asv(pageCtrl)
        pageCtrl.bottom(0).height(20).centerHorizontally()
        
        if resources.count > 1 {
            DispatchQueue.main.async {
                let centerIndex = self.multiple / 2 * self.resources.count
                self.collectionView.scrollToItem(at: IndexPath(item: centerIndex, section: 0), at: .left, animated: false)
                self.startTimer()
            }
        } else {
            pageCtrl.isHidden = true
        }
    }
    
    func startTimer() {
        Observable<Int>.interval(RxTimeInterval.seconds(interval), scheduler: MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] _ in
                    self?.fired()
                }
            ).disposed(by: timerDisposeBag)
    }
    
    func fired() {
        var offset = collectionView.contentOffset
        offset.x += size.width
        collectionView.setContentOffset(offset, animated: true)
    }
    
    func stopTimer() {
        timerDisposeBag = DisposeBag()
    }
}

extension BannerView: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if resources.count == 1 {
            return 1
        }
        
        return resources.count * multiple
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerImageCell.reuseIdentifier, for: indexPath) as! BannerImageCell
        let resource = resources[indexPath.item % resources.count]
        if let url = resource as? URL {
            cell.imageView.kf.setImage(with: url)
            cell.imageView.kf.indicatorType = .activity
        } else if let string = resource as? String {
            cell.imageView.kf.setImage(with: string.url)
            cell.imageView.kf.indicatorType = .activity
        } else if let image = resource as? UIImage {
            cell.imageView.image = image
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = indexPath.item % resources.count
        tapAt?(index)
    }
}

extension BannerView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.x + size.width / 2
        let page = Int(offset / size.width) % resources.count
        pageCtrl.currentPage = page
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        stopTimer()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        startTimer()
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        var offset = scrollView.contentOffset
        let page = Int(offset.x / size.width)
        if offset.x - page.cf * size.width > 1.0 {
            offset.x = (page + 1).cf * size.width
            scrollView.contentOffset = offset
        }
    }
}

final class BannerImageCell: UICollectionViewCell {
    
    static let reuseIdentifier = "\(BannerImageCell.self)"
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        asv(imageView)
        imageView.fillContainer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
