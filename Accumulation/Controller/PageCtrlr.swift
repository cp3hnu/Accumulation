//
//  PageCtrlr.swift
//  Cards
//
//  Created by CP3 on 2018/6/6.
//  Copyright © 2018年 CP3. All rights reserved.
//

import Foundation
import Bricking
import RxSwift
import UIKit

final public class PageCtrlr: UIViewController {
    
    public let pageSubject = PublishSubject<Int>()
    public private(set) var curPage: Int = 0 {
        didSet {
            pageSubject.onNext(curPage)
        }
    }
    
    private let controllers: [UIViewController]
    private let scrollView = CPScrollView()
    
    public init(controllers: [UIViewController]) {
        self.controllers = controllers
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    public func goToPage(page: Int) {
        guard page != curPage else { return }
        
        if page > curPage &&  page - curPage > 1 {
            scrollView.setContentOffset(CGPoint(x: CGFloat(page - 1) * view.bounds.width, y: 0), animated: false)
        } else if curPage - page > 1 {
            scrollView.setContentOffset(CGPoint(x: CGFloat(page + 1) * view.bounds.width, y: 0), animated: false)
        }
        
        scrollView.setContentOffset(CGPoint(x: CGFloat(page) * view.bounds.width, y: 0), animated: true)
        curPage = page
    }
}

// MARK: - Setup
private extension PageCtrlr {
    func setupView() {
        scrollView.isHeightEqual = true
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        view.asv(scrollView)
        scrollView.fillContainer()
        
        for ctrlr in controllers {
            self.addChild(ctrlr)
            scrollView.asv(ctrlr.view)
            ctrlr.didMove(toParent: self)
        }
        
        let subViews = controllers.map{ $0.view! }
        subViews.linearFixedSpace(space: 0, left: 0, right: 0)
        subViews.equalWidths()
        subViews.forEach{ $0.fillVertically() }
        if let first = subViews.first {
            [first, scrollView].equalWidths()
        }
    }
}

// MARK: - UIScrollViewDelegate
extension PageCtrlr: UIScrollViewDelegate {
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x + 10
        let page = Int(offsetX / scrollView.bounds.width)
        if curPage != page {
            curPage = page
        }
    }
}
