//
//  UIViewController+Ext.swift
//  Accumulation
//
//  Created by CP3 on 7/8/20.
//  Copyright © 2020 CP3. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    public func popupAlert(title: String?, message: String?, isDestructive: Bool = false, cancelTitle: String? = nil, cancelAction: ((UIAlertAction) -> Void)? = nil, preferredTitle: String? = nil, preferredAction: ((UIAlertAction) -> Void)? = nil) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        if let title = cancelTitle {
            let cancelAction = UIAlertAction(title: title, style: .cancel, handler: cancelAction)
            alert.addAction(cancelAction)
        }
        
        if let title = preferredTitle {
            let preferredAction = UIAlertAction(title: title, style: isDestructive ? .destructive : .default, handler: preferredAction)
            alert.addAction(preferredAction)
            alert.preferredAction = preferredAction
        }
        
        present(alert, animated: true, completion: nil)
    }
}

