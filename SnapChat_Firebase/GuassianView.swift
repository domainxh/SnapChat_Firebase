//
//  GuassianView.swift
//  SnapChat_Firebase
//
//  Created by Xiaoheng Pan on 1/27/17.
//  Copyright © 2017 Xiaoheng Pan. All rights reserved.
//

import UIKit

class GuassianView: UIView {

    override func awakeFromNib() {
        if !UIAccessibilityIsReduceTransparencyEnabled() {
            self.layer.backgroundColor = UIColor.clear.cgColor
            
            let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.frame = self.layer.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
            blurEffectView.inputView
//            self.layer.insertSubview(blurEffectView, at: 0)
            
        } else {
            self.layer.backgroundColor = UIColor.black.withAlphaComponent(0.8).cgColor
        }
    }
}
