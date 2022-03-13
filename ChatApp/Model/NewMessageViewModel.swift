//
//  NewMessageViewModel.swift
//  ChatApp
//
//  Created by Apple on 13/03/2022.
//

import Foundation
class NewMessageViewModel: ObservableObject {
    @Published var users = [UserModel]()
    @Published var errorMessage = ""
    init() {
        fetchAllUsers()
    }
    private func fetchAllUsers() {
        let currentUserId = FirebaseManager.shared.auth.currentUser?.uid ?? ""
        FirebaseManager.shared.fireStore.collection("users")
            // .whereField will filter the retrieved users, to not include the current one
            .whereField("uid", isNotEqualTo: currentUserId)
            .getDocuments { (query, error) in
                guard error == nil else {
                    NSLog("Failed to load users", error?.localizedDescription ?? "")
                    self.errorMessage = error?.localizedDescription ?? ""
                    return
                }
                query?.documents.forEach({ (snapshot) in
                    let data = snapshot.data()
                    self.users.append(.init(data: data))
                })
            }
    }
}
