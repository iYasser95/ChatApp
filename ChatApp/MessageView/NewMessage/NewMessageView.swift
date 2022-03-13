//
//  NewMessageView.swift
//  ChatApp
//
//  Created by Apple on 12/03/2022.
//

import SwiftUI
import SDWebImageSwiftUI
struct NewMessageView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var model = NewMessageViewModel()
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(model.users) { user in
                    Button(action: {}, label: {
                        HStack(spacing: 16) {
                            WebImage(url: URL(string: user.profileImageUrl))
                                .resizable()
                                .frame(width: 50, height: 50)
                                .cornerRadius(50)
                                .scaledToFill()
                                .overlay(RoundedRectangle(cornerRadius: 100)
                                            .stroke(Color(.label), lineWidth: 2))
                            let username = user.username
                            let email = user.email.removeEmailSuffix.capitalized
                            Text(username ?? email)
                                .foregroundColor(Color(.label))
                            Spacer()
                        }.padding(.horizontal)
                    })
                    Divider()
                        .padding(.vertical, 8)
                }
            }.navigationTitle("New Message")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("Cancel")
                    })
                }
            }
        }
    }
}

struct NewMessageView_Previews: PreviewProvider {
    static var previews: some View {
        NewMessageView()
    }
}
