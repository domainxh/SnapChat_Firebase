//
//  ProfileImage.swift
//  SnapChat_Firebase
//
//  Created by Xiaoheng Pan on 1/26/17.
//  Copyright © 2017 Xiaoheng Pan. All rights reserved.
//

import UIKit

class ProfileImage: UIImageView {

    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = self.frame.width / 2
        layer.borderWidth = 1
        layer.borderColor = UIColor.white.cgColor
        clipsToBounds = true
    }

}
