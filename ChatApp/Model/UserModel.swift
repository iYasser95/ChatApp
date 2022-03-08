//
//  UserModel.swift
//  ChatApp
//
//  Created by Apple on 07/03/2022.
//

import Foundation
struct UserModel {
    let uid, email, profileImageUrl: String
    
    init(data: [String: Any]) {
        self.uid = data["uid"] as? String ?? ""
        self.email = data["email"] as? String ?? ""
        self.profileImageUrl = data["profileImage"] as? String ?? ""
    }
}
