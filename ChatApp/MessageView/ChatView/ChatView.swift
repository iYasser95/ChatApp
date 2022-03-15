//
//  ChatView.swift
//  ChatApp
//
//  Created by Apple on 15/03/2022.
//

import SwiftUI

struct ChatView: View {
    let user: UserModel?
    var body: some View {
        ScrollView {
            Text("Fake message")
        }.navigationTitle(user?.email ?? "")
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(user: nil)
    }
}
