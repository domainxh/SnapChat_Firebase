//
//  Signin.swift
//  SlapChat_Firebase
//
//  Created by Xiaoheng Pan on 1/22/17.
//  Copyright © 2017 Xiaoheng Pan. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class Signin: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var emailTextField: FancyTextField!
    @IBOutlet weak var passwordTextField: FancyTextField!

    override func viewDidAppear(_ animated: Bool) {
        if let _ = KeychainWrapper.standard.string(forKey: "\(FIRAuth.auth()?.currentUser?.uid)") {
            self.performSegue(withIdentifier: "toProfileVC", sender: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let destination = segue.destination as? ProfileVC {
//            
//            if let userUID = sender as? String {
//                destination.userUID = userUID
//            }
//        }
//    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        if let email = emailTextField.text, let password = passwordTextField.text, (email.characters.count > 0 && password.characters.count > 0) {
            
            AuthService.instance.login(email: email, password: password, onComplete: { (errorMessage, data) in
                
                if errorMessage != nil {
                    let alert = UIAlertController(title: "Error Authentication", message: errorMessage, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(alert, animated: true)
                    
                } else {
                    _ = KeychainWrapper.standard.set(data as! String, forKey: "\(FIRAuth.auth()?.currentUser?.uid)")
                    self.performSegue(withIdentifier: "toProfileVC", sender: data)
                }
            })
            
        } else {
            let alert = UIAlertController(title: "Username and password required", message: "You must enter a valid email and password", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
            present(alert, animated: true)
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
