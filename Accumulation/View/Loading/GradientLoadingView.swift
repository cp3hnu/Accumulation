//
//  GradientLoadingView.swift
//  Accumulation
//
//  Created by cp3hnu on 2021/6/10.
//  Copyright © 2021 CP3. All rights reserved.
//

import Foundation
import UIKit

public final class GradientLoadingView: LoadingView {
   
    public private(set) var isLoading = false
    public var duration: TimeInterval = 0.15
    
    private let imageView = UIImageView()
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        let bundle = Bundle(for: GradientLoadingView.self)
        imageView.image = UIImage.bundleImage("circle")
        asv(imageView)
        imageView.fillContainer()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func startLoading() {
        guard !isLoading else { return }

        isLoading = true
        
        let from = CATransform3DIdentity
        let to = CATransform3DRotate(CATransform3DIdentity, 0.5 * .pi, 0, 0, 1)
        let anim = CABasicAnimation(keyPath: "transform")
        anim.fromValue = from
        anim.toValue = to
        anim.repeatCount = Float.infinity
        anim.duration = duration
        anim.isCumulative = true
        
        imageView.layer.add(anim, forKey: "animation.rotate")
    }

    public override func stopLoading() {
        guard isLoading else { return }

        isLoading = false
        imageView.layer.removeAnimation(forKey: "animation.rotate")
    }
    
    public override func restartLoading() {
        guard isLoading else { return }

        isLoading = false
        startLoading()
    }
}
