//
//  UserCell.swift
//  SnapChat_Firebase
//
//  Created by Xiaoheng Pan on 1/24/17.
//  Copyright © 2017 Xiaoheng Pan. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {

    @IBOutlet weak var firstnameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setCheckmark(selected: false)
    }

    func setCheckmark(selected: Bool) {
        let imgStr = selected ? "messageindicatorchecked1" : "messageindicator1"
        self.accessoryView = UIImageView(image: UIImage(named: imgStr))
        
    }

    func updateUI(user: User) {
        firstnameLabel.text = user.firstname
    }
}
