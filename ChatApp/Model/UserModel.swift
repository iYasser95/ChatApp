//
//  UserModel.swift
//  ChatApp
//
//  Created by Apple on 07/03/2022.
//

import Foundation
struct UserModel: Identifiable {
    var id: String { return uid }
    var uid, email, profileImageUrl: String
    var username: String?
    init(data: [String: Any]) {
        self.uid = data["uid"] as? String ?? ""
        self.email = data["email"] as? String ?? ""
        self.profileImageUrl = data["profileImage"] as? String ?? ""
        self.username = data["username"] as? String
    }
    
    static func createDic(from model: UserModel) -> [String: Any] {
        return ["uid": model.uid,
                "email": model.email,
                "username": model.username as Any,
                "profileImage": model.profileImageUrl]
    }
}
