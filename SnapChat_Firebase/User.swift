//
//  User.swift
//  SnapChat_Firebase
//
//  Created by Xiaoheng Pan on 1/24/17.
//  Copyright © 2017 Xiaoheng Pan. All rights reserved.
//

import UIKit



struct User {
    private var _firstname: String
    private var _uid: String
    
    var firstname: String { return _firstname }
    var uid: String { return _uid }
    
    init(uid: String, firstname: String) {
        _firstname = firstname
        _uid = uid
    }
}
