//
//  UsersVC.swift
//  SnapChat_Firebase
//
//  Created by Xiaoheng Pan on 1/24/17.
//  Copyright © 2017 Xiaoheng Pan. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage
import FirebaseAuth

class UsersVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    private var users = [User]()
    private var selectedUsers = Dictionary<String, User>()
    private var _snapData: Data?
    private var _videoURL: URL?
    
    var snapData: Data? {
        set {
            _snapData = newValue
        } get {
            return _snapData
        }
    }
    
    var videoURL: URL? {
        set {
            _videoURL = newValue
        } get {
            return _videoURL
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsMultipleSelection = true
        
        navigationItem.rightBarButtonItem?.isEnabled = false //Make sure at least one user is selected to send anything.
        
        DataService.instance.usersRef.observeSingleEvent(of: .value) { (snapshot: FIRDataSnapshot) in
            print("Snap: \(snapshot.debugDescription)")
            
            if let users = snapshot.value as? Dictionary<String, AnyObject> {
                for (key, value) in users {
                    if let dict = value as? Dictionary<String, AnyObject> {
                        if let profile = dict["profile"] as? Dictionary<String, AnyObject> {
                            if let firstname = profile["firstname"] as? String {
                                let uid = key
                                let user = User(uid: uid, firstname: firstname)
                                self.users.append(user)
                            }
                        }
                    }
                }
            }
            
            self.tableView.reloadData()
            
        }
        // .value is when it receives data for the first time.
        
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationItem.rightBarButtonItem?.isEnabled = true
        let cell = tableView.cellForRow(at: indexPath) as! UserCell
        cell.setCheckmark(selected: true)
        let user = users[indexPath.row]
        selectedUsers[user.uid] = user
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! UserCell
        cell.setCheckmark(selected: false)
        let user = users[indexPath.row]
        selectedUsers[user.uid] = nil
        
        if selectedUsers.count == 1 {
            navigationItem.rightBarButtonItem?.isEnabled = false
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell") as! UserCell
        let user = users[indexPath.row]
        cell.updateUI(user: user)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    @IBAction func sendPullReqPressed(_ sender: Any) {
        if let url = _videoURL {
            let videoName = "\(NSUUID().uuidString)\(url)" // this will guarantee unique videonames
            let ref = DataService.instance.videoStorageRef.child(videoName)
            
            _ = ref.putFile(url, metadata: nil, completion: { (meta, error) in
                if error != nil {
                    //do some error handling
                    print("Error uploading video: \(error?.localizedDescription)")
                } else {
                    // Once the data is successfully uploaded to FB, it will create a downloadable URL for you so you can give it to other users.
                    let downloadURL = meta?.downloadURL() // Save this somewhere, work on it on my freetime
                    DataService.instance.sendMediaPullRequest(senderUID: FIRAuth.auth()!.currentUser!.uid, sendingTo: self.selectedUsers, mediaURL: downloadURL!, textSnippet: "Coding today was legit!")
                    // self.dismiss(animated: true, completion: nil)
                }
            })
            self.dismiss(animated: true, completion: nil) // we're leaving it here because if you leave it in the if statement, it's asyncronous so it will take a while to get to it. By leaving it here... we will dismiss the screen right after hitting the button, therefore making it look like it was instant.
        } else if let snap = _snapData {
            let imageName = "\(NSUUID().uuidString).jpg"
            let ref = DataService.instance.imageStorageRef.child(imageName)
            
            _ = ref.put(snap, metadata: nil, completion: { (meta:FIRStorageMetadata?, error:Error?) in
                if error != nil {
                    print("Error uploading snapshot: \(error?.localizedDescription)")
                } else {
                    _ = meta!.downloadURL()
                }
            })
            self.dismiss(animated: true, completion: nil)
            
        }
        
    }
    
    
}
