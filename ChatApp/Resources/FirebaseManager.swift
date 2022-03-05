//
//  FirebaseManager.swift
//  ChatApp
//
//  Created by Apple on 05/03/2022.
//

import Firebase
class FirebaseManager: NSObject {
    let auth: Auth
    static let shared = FirebaseManager()
    
    override init() {
        FirebaseApp.configure()
        auth = Auth.auth()
        super.init()
    }
    
    func createNewAccount(email: String, password: String, completion: @escaping (Error?) -> Void) {
        // Create new user account in Firebase
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            guard error == nil else {
                NSLog("failed to create user", error?.localizedDescription ?? "")
                completion(error)
                return
            }

            NSLog("Create account with ID: \(result?.user.uid ?? "")")
            completion(nil)
//            self.loginStatusMessage = ""
        }
    }
    
     func loginUser(email: String, password: String, completion: @escaping (Error?) -> Void) {
        // Login user with Firebase
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            guard error == nil else {
                NSLog("failed to sign in user", error?.localizedDescription ?? "")
                completion(error)
                return
            }
            NSLog("Loged in with user ID: \(result?.user.uid ?? "")")
            completion(nil)
        }
    }
}
