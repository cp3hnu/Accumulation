//
//  ControlProperty.swift
//  Accumulation
//
//  Created by cp3hnu on 2021/6/20.
//  Copyright © 2021 CP3. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

extension ControlPropertyType where Element == Bool {
    public var toggle: Observable<Bool> {
        return self.map { result in
            return !result
        }
    }
}

extension ControlPropertyType where Element == String {
    public var isEmpty: Observable<Bool> {
        return self.map { result in
            return result.isEmpty
        }
    }
    
    public var isNotEmpty: Observable<Bool> {
        return self.map { result in
            return !result.isEmpty
        }
    }
}

extension Reactive where Base: UIView {
    public var gestureTap: ControlEvent<()> {
        self.base.isUserInteractionEnabled = true
        let tapGR = UITapGestureRecognizer()
        self.base.addGestureRecognizer(tapGR)
        let source = tapGR.rx.event.map { _ in
            return ()
        }
        return ControlEvent(events: source)
    }
}



