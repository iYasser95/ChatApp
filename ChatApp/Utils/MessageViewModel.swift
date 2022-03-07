//
//  MessageViewModel.swift
//  ChatApp
//
//  Created by Apple on 07/03/2022.
//

import Foundation
class MessageViewModel: ObservableObject {
    @Published var user: UserModel?
    init() {
        fetchCurrentUser()
    }
    
    private func fetchCurrentUser() {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        FirebaseManager.shared.fireStore.collection("users")
            .document(uid).getDocument { (snapshot, error) in
                guard error == nil else {
                    NSLog("Failed to get user data", error?.localizedDescription ?? "")
                    return
                }
                
                guard let data = snapshot?.data() else { return }
                let uid = data["uid"] as? String ?? ""
                let email = data["email"] as? String ?? ""
                let profileImageUrl = data["profileImage"] as? String ?? ""
                self.user = UserModel(uid: uid, email: email, profileImageUrl: profileImageUrl)
            }
    }
}
