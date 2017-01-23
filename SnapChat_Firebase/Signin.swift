//
//  Signin.swift
//  SlapChat_Firebase
//
//  Created by Xiaoheng Pan on 1/22/17.
//  Copyright © 2017 Xiaoheng Pan. All rights reserved.
//

import UIKit

class Signin: UIViewController {

    @IBOutlet weak var emailTextField: FancyTextField!
    @IBOutlet weak var passwordTextField: FancyTextField!
    
//    override func viewDidLoad() {
//        <#code#>
//    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    
    @IBAction func loginButtonTapped(_ sender: Any) {
    }
    
    @IBAction func fingerprintButtonTapped(_ sender: Any) {
    }
    
}
