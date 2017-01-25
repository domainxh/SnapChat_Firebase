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
    
    var DataBaseRef: FIRDatabaseReference { return FIRDatabase.database().reference() }
    var UsersRef: FIRDatabaseReference { return DataBaseRef.child("users")}
    var StorageRef: FIRStorageReference {
        return FIRStorage.storage().reference(forURL: "gs://snapchat-dd9fd.appspot.com")
    }
    
    var imageStorageRef: FIRStorageReference {
        return StorageRef.child("images")
    }
    
    var videoStorageRef: FIRStorageReference {
        return StorageRef.child("videos")
    }
    
    func createFirebaseDBUser(uid: String) {
        // everytime you create a new user, firebase automatically create a uid which you could use.
        
        let profile: Dictionary<String, AnyObject> = ["firstname" : "" as AnyObject, "lastname" : "" as AnyObject]
        DataBaseRef.child("users").child(uid).child("profile").setValue(profile)
    }
}
