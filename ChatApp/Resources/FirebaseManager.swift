//
//  FirebaseManager.swift
//  ChatApp
//
//  Created by Apple on 05/03/2022.
//

import SwiftUI
import Firebase
class FirebaseManager: NSObject {
    let auth: Auth
    let storage: Storage
    static let shared = FirebaseManager()
    
    override init() {
        FirebaseApp.configure()
        auth = Auth.auth()
        storage = Storage.storage()
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
    
    func uploadImageToStorage(image: UIImage, completion: @escaping (Error?) -> Void) {
        // Upload user image and save in storage
        guard let fileName = auth.currentUser?.uid else { return }
        let reference = storage.reference(withPath: fileName)
        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
        reference.putData(imageData, metadata: nil) { (data, error) in
            guard error == nil else {
                NSLog("Failed to upload image", error?.localizedDescription ?? "")
                completion(error)
                return
            }
            NSLog("Uploaded Image", self)
            reference.downloadURL { (url, error) in
                guard error == nil else {
                    NSLog("Failed to download image", error?.localizedDescription ?? "")
                    completion(error)
                    return
                }
                NSLog("Downloaded image", url?.absoluteString ?? "")
                completion(nil)
            }
        }
    }
}
