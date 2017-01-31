//
//  UserCell.swift
//  SnapChat_Firebase
//
//  Created by Xiaoheng Pan on 1/24/17.
//  Copyright © 2017 Xiaoheng Pan. All rights reserved.
//

import UIKit
import Firebase

class UserCell: UITableViewCell {

    @IBOutlet weak var usernameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setCheckmark(selected: false)
    }

    func setCheckmark(selected: Bool) {
        let imgStr = selected ? "messageindicatorchecked1" : "messageindicator1"
        self.accessoryView = UIImageView(image: UIImage(named: imgStr))
        
    }

    func updateUI(user: User) {
        usernameLabel.text = user.username
    }
}
