//
//  ProfileImage.swift
//  SnapChat_Firebase
//
//  Created by Xiaoheng Pan on 1/26/17.
//  Copyright © 2017 Xiaoheng Pan. All rights reserved.
//

import UIKit

@IBDesignable
class ProfileImage: UIImageView {

    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = self.frame.width / 2
        layer.borderColor = UIColor.white.cgColor
        clipsToBounds = true
    }

}
