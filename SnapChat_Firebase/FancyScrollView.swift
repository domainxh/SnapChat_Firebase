//
//  FancyScrollView.swift
//  SnapChat_Firebase
//
//  Created by Xiaoheng Pan on 1/26/17.
//  Copyright © 2017 Xiaoheng Pan. All rights reserved.
//

import UIKit

class FancyScrollView: UIScrollView {
    
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        
//        
//        
//        layer.shadowColor = UIColor(red: 120.0 / 255.0, green: 120.0 / 255.0, blue: 120.0 / 255.0, alpha: 0.6).cgColor
//        layer.shadowOpacity = 0.8
//        layer.shadowRadius = 5.0
//        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
//        
//    }

}
