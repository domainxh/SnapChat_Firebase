//
//  FancyButton.swift
//  SlapChat_Firebase
//
//  Created by Xiaoheng Pan on 1/22/17.
//  Copyright © 2017 Xiaoheng Pan. All rights reserved.
//

import UIKit

@IBDesignable

class FancyButton: UIButton {
    
    override func awakeFromNib() {
        layer.masksToBounds = true
    }
    
    @IBInspectable var bgColor: UIColor? {
        didSet {
            layer.backgroundColor = bgColor?.cgColor
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }


}
