//
//  MessageViewModel.swift
//  ChatApp
//
//  Created by Apple on 07/03/2022.
//

import SwiftUI
class MessageViewModel: ObservableObject {
    @Published var user: UserModel?
    @Published var isUserLoggedOut: Bool = false
    @Published var shouldUpdateUserData: Bool = false
    init() {
        DispatchQueue.main.async {
            self.isUserLoggedOut = FirebaseManager.shared.auth.currentUser?.uid == nil
        }
        fetchCurrentUser()
    }
    
     func fetchCurrentUser() {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {
            isUserLoggedOut = true
            return
        }
        FirebaseManager.shared.fireStore.collection("users")
            .document(uid).getDocument { (snapshot, error) in
                guard error == nil else {
                    NSLog("Failed to get user data", error?.localizedDescription ?? "")
                    return
                }
                
                guard let data = snapshot?.data() else { return }
                
                self.user = .init(data: data)
            }
    }
    
    func signOut() {
        isUserLoggedOut.toggle()
        try? FirebaseManager.shared.auth.signOut()
    }
}
