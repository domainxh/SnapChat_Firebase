//
//  DataService.swift
//  SnapChat_Firebase
//
//  Created by Xiaoheng Pan on 1/23/17.
//  Copyright © 2017 Xiaoheng Pan. All rights reserved.
//

import Foundation
import Firebase

class DataService {
    
    private static var _instance = DataService()
    static var instance: DataService { return _instance }
    
    var dataBaseRef: FIRDatabaseReference { return FIRDatabase.database().reference() }
    var usersRef: FIRDatabaseReference { return dataBaseRef.child("users")}
    var storageRef: FIRStorageReference {
        return FIRStorage.storage().reference(forURL: "gs://snapchat-dd9fd.appspot.com")
    }
    
    var imageStorageRef: FIRStorageReference {
        return storageRef.child("images")
    }
    
    var videoStorageRef: FIRStorageReference {
        return storageRef.child("videos")
    }
    
    func createDataBaseUserProfile(uid: String, userName: String) {
        // everytime you create a new user, firebase automatically create a uid which you could use.
        
        let userInfo: Dictionary<String, AnyObject> = ["username" : userName as AnyObject]
        
        usersRef.child(uid).setValue(userInfo)
    }
    
    func sendMediaPullRequest(senderUID: String, sendingTo: Dictionary<String, User>, mediaURL: URL, videoComment: String? = nil) {
        // Two types: one for chat messages, the other one for media(video/photo)
        
        var uids = [String]()
        for uid in sendingTo.keys {
            uids.append(uid)
        }
        
        let pullRequest: Dictionary<String, AnyObject> = ["mediaURL": mediaURL.absoluteString as AnyObject, "senderUID": senderUID as AnyObject, "openCount": 0 as AnyObject, "recipients": uids as AnyObject, "videoComment": videoComment as AnyObject]
        
        dataBaseRef.child("pullRequests").childByAutoId().setValue(pullRequest)
    }
    
}
