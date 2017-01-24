//
//  signupVC.swift
//  SnapChat_Firebase
//
//  Created by Xiaoheng Pan on 1/23/17.
//  Copyright © 2017 Xiaoheng Pan. All rights reserved.
//

import UIKit
import Firebase

class SignupVC: UIViewController {

    @IBOutlet weak var emailText: FancyTextField!
    @IBOutlet weak var passwordText: FancyTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8) // alternatively use blur
        showAnimate()
    }

    @IBAction func cancelButtonPressed(_ sender: Any) {
        removeAnimate()
    }
    
    @IBAction func signupButtonTapped(_ sender: Any) {
        
        //Ensure email & password textfield is not empty
        guard let email = emailText.text, !email.isEmpty else {
            print("The email field needs to be populated")
            return
        }
        guard let password = passwordText.text, !password.isEmpty else {
            print("The password field needs to be populated")
            return
        }
        
//        createAccout(email: emailText.text!, password: passwordText.text!)
        
        let alert = UIAlertController(title: "Welcome to slapchat", message: "Your account was successfully created", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        present(alert, animated: true) {
            
            self.removeAnimate()
        }
        
    }

    

    
    func showAnimate() {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        })
    }
    
    func removeAnimate() {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished) {
                self.view.removeFromSuperview()
            }
        })
    }

}
