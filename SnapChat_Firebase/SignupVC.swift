//
//  signupVC.swift
//  SnapChat_Firebase
//
//  Created by Xiaoheng Pan on 1/23/17.
//  Copyright © 2017 Xiaoheng Pan. All rights reserved.
//

import UIKit
import Firebase

class SignupVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailTextField: FancyTextField!
    @IBOutlet weak var passwordTextField: FancyTextField!
    @IBOutlet weak var fullnameTextField: FancyTextField!
    @IBOutlet weak var userImage: ProfileImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
        
        if !UIAccessibilityIsReduceTransparencyEnabled() {
            self.view.backgroundColor = UIColor.clear
            
            let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.frame = self.view.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

            self.view.insertSubview(blurEffectView, at: 0)
            
        } else {
            self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        }
        
        showAnimate()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }

    @IBAction func cancelButtonPressed(_ sender: Any) {
        removeAnimate()
    }
    
    @IBAction func signupButtonTapped(_ sender: Any) {
        
        if let email = emailTextField.text, let password = passwordTextField.text, (email.characters.count > 0 && password.characters.count > 0) {
            
            AuthService.instance.createAccout(email: email, password: password) { (errorMessage, data) in
                
                if errorMessage == nil {
                    let alert = UIAlertController(title: "Welcome to slapchat", message: "Your account was successfully created", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default) { (random) in
                        self.removeAnimate()
                    })
                    
                    self.present(alert, animated: true)
                    
                } else {
                    let alert = UIAlertController(title: "Account can't be created", message: errorMessage, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                    self.present(alert, animated: true)
                    return
                }
            }
            
        } else {
            let alert = UIAlertController(title: "Email and password required", message: "You must enter a valid email and password", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
            present(alert, animated: true)
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
