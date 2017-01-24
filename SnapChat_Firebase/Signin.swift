//
//  Signin.swift
//  SlapChat_Firebase
//
//  Created by Xiaoheng Pan on 1/22/17.
//  Copyright © 2017 Xiaoheng Pan. All rights reserved.
//

import UIKit
import Firebase

class Signin: UIViewController {

    @IBOutlet weak var emailTextField: FancyTextField!
    @IBOutlet weak var passwordTextField: FancyTextField!

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        
        if let email = emailTextField.text, let password = passwordTextField.text, (email.characters.count > 0 && password.characters.count > 0) {
        
            // Call the Firebase login service
            AuthService.instance.login(email: email, password: password, onComplete: { (errorMessage, data) in
                guard errorMessage == nil else {
                    let alert = UIAlertController(title: "Error Authentication", message: errorMessage, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    return
                }
            })
            
        } else {
            let alert = UIAlertController(title: "Username and password required", message: "You must enter a valid email and password", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        }

    }
    
    @IBAction func fingerprintButtonTapped(_ sender: Any) {}
    
    @IBAction func signupButtonTapped(_ sender: UIButton) {
        let signupVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SignupVC_SB_ID") as! SignupVC
        
        self.addChildViewController(signupVC)
        signupVC.view.frame = self.view.frame
        self.view.addSubview(signupVC.view)
        signupVC.didMove(toParentViewController: self)
    }
    
}
