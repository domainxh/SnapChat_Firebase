//
//  User.swift
//  SnapChat_Firebase
//
//  Created by Xiaoheng Pan on 1/24/17.
//  Copyright © 2017 Xiaoheng Pan. All rights reserved.
//

import UIKit

struct User {
    private var _username: String
    private var _uid: String
    
    var username: String { return _username }
    var uid: String { return _uid }
    
    init(uid: String, username: String) {
        _username = username
        _uid = uid

    }
}
