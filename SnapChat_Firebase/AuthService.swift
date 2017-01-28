//
//  DataService.swift
//  SlapChat_Firebase
//
//  Created by Xiaoheng Pan on 1/22/17.
//  Copyright © 2017 Xiaoheng Pan. All rights reserved.
//

import Foundation
import Firebase

typealias Completion = (_ errorMessage: String?, _ data: AnyObject?) -> ()
    // When declaring a function or method, you don’t need to specify a return type if no value will be returned. However, the type of a function, method, or closure always includes a return type, which is Void if otherwise unspecified.

class AuthService {
    
    private static var _instance = AuthService() // "static" makes it a singleton: an object which is instantiated exactly once. Only one copy of this object exists and the state is shared and reachable by any other object
    
    static var instance: AuthService { return _instance }
    
    func login(email: String, password: String, onComplete: Completion?) {
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            if error != nil {
                self.errorHandling(error: error! as NSError, onComplete: onComplete)
            } else {
                print("User \(user?.uid) successfully logged in")
                onComplete?(nil, user?.uid as String? as AnyObject?)
            }
        })
    }
    
    func createUser(userName: String, email: String, password: String, onComplete: Completion?) {
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
            if error != nil {
                self.errorHandling(error: error! as NSError, onComplete: onComplete)
            } else {
                print("User \(user!.uid) successfully created")
                if user?.uid != nil {
                    DataService.instance.createDataBaseUserProfile(uid: user!.uid, userName: userName)
                }
                onComplete?(nil, user?.uid as AnyObject?)
            }
        })
    }
    
    func signout() {
        let firebaseAuth = FIRAuth.auth()
        do {
            try firebaseAuth?.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    func errorHandling(error: NSError, onComplete: Completion?) {
        
        if let errorCode = FIRAuthErrorCode(rawValue: error._code) {
            
            switch errorCode {
                case .errorCodeInvalidEmail:
                    onComplete?("The email address is badly formatted.", nil)
                case .errorCodeWrongPassword:
                    onComplete?("Invalid password", nil)
                case .errorCodeEmailAlreadyInUse, .errorCodeAccountExistsWithDifferentCredential:
                    onComplete?("Email already in use, a new account cannot be created", nil)
                case .errorCodeUserNotFound:
                    onComplete?("User not found", nil)
                case .errorCodeWeakPassword:
                    onComplete?("The password must be 6 characters long or more", nil)
                default:
                    onComplete?("There was a problem, error: \(error)", nil)
            }
        }
    }

}
