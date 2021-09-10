//
//  SegmentPageCtrlr.swift
//  Cards
//
//  Created by CP3 on 2018/6/7.
//  Copyright © 2018年 CP3. All rights reserved.
//

import UIKit
import Bricking
import RxSwift

public final class SegmentPageCtrlr: UIViewController {

    public var segmented: CPSegmentedControl!
    public var pageCtrlr: PageCtrlr!
    public var pageSubject: PublishSubject<Int> {
        return pageCtrlr.pageSubject
    }
    public var curPage: Int {
        return pageCtrlr.curPage
    }
    
    private let disposeBag = DisposeBag()
    private let segments: [String]
    private let controllers: [UIViewController]
    private let segmentedType: CPSegmentedControl.SegmentedType
    
    public init(segments: [String], controllers: [UIViewController], segmentedType: CPSegmentedControl.SegmentedType = .fill) {
        self.segments = segments
        self.controllers = controllers
        self.segmentedType = segmentedType
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        setupView()
    }
}

// MARK: - Setup
private extension SegmentPageCtrlr {
    func setupView() {
        segmented = CPSegmentedControl(items: segments, segmentedType: segmentedType)
        segmented.backgroundColor = UIColor.white
        segmented.highlightedTextColor = 68.grayColor
        segmented.textColor = 138.grayColor
        segmented.textFont = 16.font
        segmented.lineColor = 68.grayColor
        segmented.lineWidth = 25
        segmented.segmentSelected = { [unowned self] index in
            self.pageCtrlr.goToPage(page: index)
        }
        view.asv(segmented)
        
        pageCtrlr = PageCtrlr(controllers: controllers)
        self.addChild(pageCtrlr)
        view.asv(pageCtrlr.view)
        pageCtrlr.didMove(toParent: self)
        pageCtrlr.pageSubject
            .subscribe(
                onNext: { [weak self] page in
                    self?.segmented.selectedSegmentIndex = page
                }
            ).disposed(by: disposeBag)
        
        view.layout(
            0,
            |segmented| ~ 44,
            10,
            |pageCtrlr.view|,
            0
        )
    }
}
