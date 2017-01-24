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
        
        if let email = emailText.text, let password = passwordText.text, (email.characters.count > 0 && password.characters.count > 0) {
        
            AuthService.instance.createAccout(email: email, password: password) { (errorMessage, data) in
                print("SignupVC errorMessage: \(errorMessage)")
                if errorMessage == nil {
                    let alert = UIAlertController(title: "Welcome to slapchat", message: "Your account was successfully created", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true) {
                        self.removeAnimate()
                    }
                } else {
                    let alert = UIAlertController(title: "Account can't be created", message: errorMessage, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    return
                }
            }
        } else {
            let alert = UIAlertController(title: "Email and password required", message: "You must enter a valid email and password", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: nil))
            present(alert, animated: true, completion: nil)
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
