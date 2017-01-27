//
//  signupVC.swift
//  SnapChat_Firebase
//
//  Created by Xiaoheng Pan on 1/23/17.
//  Copyright © 2017 Xiaoheng Pan. All rights reserved.
//

import UIKit
import Firebase

class SignupVC: UIViewController, UITextFieldDelegate, UIScrollViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet weak var emailTextField: FancyTextField!
    @IBOutlet weak var passwordTextField: FancyTextField!
    @IBOutlet weak var userNameTextField: FancyTextField!
    @IBOutlet weak var userImage: ProfileImage!
    @IBOutlet weak var scrollView: FancyScrollView!
    
    var activeField: UITextField?
    var imagePicker: UIImagePickerController!
    var imageSelected = false
    
    // Need to add/remove keyboardObserver upon initiation/deinitiation of the view.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.registerForKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.deregisterFromKeyboardNotifications()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        userNameTextField.delegate = self
        scrollView.delegate = self
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
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
        
        // Adds TapGestureRecognizer to scrollView, allows keyboard to hide upon tapping the view.
        let singleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MyTapMethod))
        singleTapGestureRecognizer.numberOfTapsRequired = 1
        singleTapGestureRecognizer.isEnabled = true
        singleTapGestureRecognizer.cancelsTouchesInView = false
        scrollView.addGestureRecognizer(singleTapGestureRecognizer)
    }

    func MyTapMethod(sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            userImage.image = image
            imageSelected = true
        } else {
            print("A valid image wasn't selected")
        }
        imagePicker.dismiss(animated: true)
    }
    
    @IBAction func profileImageTapped(_ sender: Any) {
        present(imagePicker, animated: true)
    }

    @IBAction func cancelButtonPressed(_ sender: Any) {
        removeAnimate()
    }
    
    @IBAction func signupButtonTapped(_ sender: Any) {
        
        if let email = emailTextField.text, let password = passwordTextField.text, let userName = userNameTextField.text, (userName.characters.count > 0 && email.characters.count > 0 && password.characters.count > 0) {
                        
            AuthService.instance.createUser(userName: userName, email: email, password: password) { (errorMessage, data) in
                
                if errorMessage == nil {
                    
                    if let image = self.userImage.image, self.imageSelected == true {
                        let imageData = UIImageJPEGRepresentation(image, 0.2)
                        let imageUID = NSUUID().uuidString // This creates unique UID
                        let metadata = FIRStorageMetadata()
                        metadata.contentType = "image/jpeg"
                        
                        DataService.instance.storageRef.child("profilePicture").child(imageUID).put(imageData!, metadata: metadata) { (metadata, error) in
                            if error != nil {
                                print("Unable to upload image to firebase storage: \(error)")
                            } else {
                                print("\(imageUID) successfully uploaded to firebase storage")
                                self.imageSelected = false
                                let downloadURL = metadata?.downloadURL()?.absoluteString
                                if let url = downloadURL {
                                    DataService.instance.usersRef.child("\(data!)").child("profilePictureURL").setValue(url)
                                }
                            }
                        }
                    }
                    
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
            let alert = UIAlertController(title: "Error", message: "Empty field detected, please fill out completely", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
            present(alert, animated: true)
        }
    }
    
    // These two funcs perform screen pop animation upon entering and exiting SignupView.
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
    
    // This func hides the keyboard when "return" is pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
    
    // The following funcs shifts the scrollView as necessary when keyboard is prompted
    func registerForKeyboardNotifications(){
        //Adding notifies on keyboard appearing
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func deregisterFromKeyboardNotifications(){
        //Removing notifies on keyboard appearing
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func keyboardWasShown(notification: NSNotification){
        //Need to calculate keyboard exact size due to Apple suggestions
        self.scrollView.isScrollEnabled = true
        var info = notification.userInfo!
        let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
        let contentInsets : UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize!.height, 0.0)
        
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
        
        var aRect : CGRect = self.view.frame
        aRect.size.height -= keyboardSize!.height
        if let activeField = self.activeField {
            if (!aRect.contains(activeField.frame.origin)){
                self.scrollView.scrollRectToVisible(activeField.frame, animated: true)
            }
        }
    }
    
    func keyboardWillBeHidden(notification: NSNotification){
        //Once keyboard disappears, restore original positions
        var info = notification.userInfo!
        let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
        let contentInsets : UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, -keyboardSize!.height, 0.0)
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
        self.view.endEditing(true)
        self.scrollView.isScrollEnabled = false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField){
        activeField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField){
        activeField = nil
    }

}
