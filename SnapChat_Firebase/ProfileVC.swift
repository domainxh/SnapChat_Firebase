//
//  ProfileVC.swift
//  SnapChat_Firebase
//
//  Created by Xiaoheng Pan on 1/27/17.
//  Copyright © 2017 Xiaoheng Pan. All rights reserved.
//

import UIKit
import Firebase

class ProfileVC: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var followerNumber: UILabel!
    @IBOutlet weak var followingNumber: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var profileImage: ProfileImage!
    @IBOutlet weak var backgroundImage: UIImageView!
    
//    static var imageCache: NSCache<NSString, UIImage> = NSCache()
    var imagePicker: UIImagePickerController!
    
    private var _userUID: String!
    var userUID: String {
        get {
            return _userUID
        } set {
            _userUID = newValue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        let firebaseUser = DataService.instance.usersRef.child(userUID)
        // user1@aol.com, 123456
    
        firebaseUser.observeSingleEvent(of: .value, with: { (snapshot) in
            if let user = snapshot.value as? Dictionary<String, AnyObject> {
                if let username = user["username"] as? String {
                    self.userName.text = username
                }
                if let followers = user["followers"] as? Dictionary<String, AnyObject> {
                    print(followers)
                    self.followerNumber.text = "\(followers.count)"
                }
                if let following = user["following"] as? Dictionary<String, AnyObject> {
                    self.followingNumber.text = "\(following.count)"
                }
                
                if let profileImageURL = user["profilePictureURL"] as? String {
                    DispatchQueue.global().async {
                        let imageData = try? Data(contentsOf: URL(string: profileImageURL)!)
                        DispatchQueue.main.async {
                            self.profileImage.image = UIImage(data: imageData!)
                            self.backgroundImage.image = UIImage(data: imageData!)
                        }
                    }
                }
            }
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }

    @IBAction func signoutTapped(_ sender: Any) {
        AuthService.instance.signout()
        performSegue(withIdentifier: "toSigninVC", sender: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            profileImage.image = image
        } else {
            print("A valid image wasn't selected")
        }
        imagePicker.dismiss(animated: true)
    }
    
    @IBAction func profileImageTapped(_ sender: Any) {
        present(imagePicker, animated: true)
        
        if let image = self.profileImage.image {
            let imageData = UIImageJPEGRepresentation(image, 0.2)
            let imageUID = NSUUID().uuidString // This creates unique UID
            let metadata = FIRStorageMetadata()
            metadata.contentType = "image/jpeg"
            
            DataService.instance.storageRef.child("profilePicture").child(imageUID).put(imageData!, metadata: metadata) { (metadata, error) in
                if error != nil {
                    print("Unable to upload image to firebase storage: \(error)")
                } else {
                    print("\(imageUID) successfully uploaded to firebase storage")
                    let downloadURL = metadata?.downloadURL()?.absoluteString
                    if let url = downloadURL {
                        DataService.instance.usersRef.child(self.userUID).child("profilePictureURL").setValue(url)
                    }
                }
            }
        }
        
    }
    
}
