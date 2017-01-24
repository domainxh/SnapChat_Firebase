//
//  DataService.swift
//  SlapChat_Firebase
//
//  Created by Xiaoheng Pan on 1/22/17.
//  Copyright © 2017 Xiaoheng Pan. All rights reserved.
//

import Foundation
import Firebase

typealias Completion = (_ errorMessage: String?, _ data: AnyObject?) -> Void
    // When declaring a function or method, you don’t need to specify a return type if no value will be returned. However, the type of a function, method, or closure always includes a return type, which is Void if otherwise unspecified.

class AuthService {
    
    private static var _instance = AuthService() // A singleton: an object which is instantiated exactly once. Only one copy of this object exists and the state is shared and reachable by any other object
    
    static var instance: AuthService { return _instance }
    
    func login(email: String, password: String, onComplete: Completion?) {
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            if error != nil {
                self.errorHandling(error: error! as NSError, onComplete: onComplete)
            } else {
                onComplete?(nil, user)
            }
        })
    }
    
    func createAccout(email: String, password: String, onComplete: Completion?) {
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
            if error != nil {
                self.errorHandling(error: error! as NSError, onComplete: onComplete)
            } else {
                print("user created")
                
                if user?.uid != nil {
                    
                }
            }
        })
        
    }
    
    func errorHandling(error: NSError, onComplete: Completion?) {
        print(error.debugDescription)
        
        if let errorCode = FIRAuthErrorCode(rawValue: error._code) {
            
            switch errorCode {
            case .errorCodeInvalidEmail:
                onComplete?("Invalid email address", nil)
                break
            case .errorCodeWrongPassword:
                onComplete?("Invalid password", nil)
                break
            case .errorCodeEmailAlreadyInUse, .errorCodeAccountExistsWithDifferentCredential:
                onComplete?("Email already in use, a new account cannot be created", nil)
                break
            case .errorCodeUserNotFound:
                onComplete?("User not found", nil)
                break
            default:
                onComplete?("There was a problem, error: \(error)", nil)
            }
        
        }
    }

}
