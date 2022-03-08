//
//  MessageView.swift
//  ChatApp
//
//  Created by Apple on 07/03/2022.
//

import SwiftUI
import SDWebImageSwiftUI
struct MessageView: View {

    @State var showLogoutOption = false
    @ObservedObject private var model = MessageViewModel()
    private var customNavBar: some View {
        HStack(spacing: 16) {
            WebImage(url: URL(string: model.user?.profileImageUrl ?? ""))
                .scaledToFill()
                .frame(width: 50, height: 50)
                .clipped()
                .cornerRadius(50)
                .overlay(RoundedRectangle(cornerRadius: 50)
                            .stroke(Color(.label), lineWidth: 1))
            VStack(alignment: .leading, spacing: 4) {
                let email = model.user?.email.removeEmailSuffix.capitalized ?? "USERNAME"
                Text(email)
                    .font(.system(size: 24, weight: .bold))

                HStack {
                    Circle()
                        .foregroundColor(.green)
                        .frame(width: 14, height: 14)
                    Text("online")
                        .font(.system(size: 12))
                        .foregroundColor(Color(.lightGray))
                }

            }

            Spacer()
            Button {
                showLogoutOption.toggle()
            } label: {
                Image(systemName: "gear")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(Color(.label))
            }
        }
        .padding()
        .actionSheet(isPresented: $showLogoutOption) {
            .init(title: Text("Settings"), message: Text("What do you want to do?"), buttons: [
                .destructive(Text("Sign Out 💣"), action: {
                    model.signOut()
                    print("handle sign out")
                }),
                .cancel()
            ])
        }
        .fullScreenCover(isPresented: $model.isUserLoggedOut, content: {
            LoginView(didUserLogIn: {
                self.model.isUserLoggedOut = false
                self.model.fetchCurrentUser()
            })
        })
    }

    var body: some View {
        NavigationView {

            VStack {
                customNavBar
                messagesView
            }
            .overlay(
                newMessageButton, alignment: .bottom)
            .navigationBarHidden(true)
        }
    }

    private var messagesView: some View {
        ScrollView {
            ForEach(0..<10, id: \.self) { num in
                VStack {
                    HStack(spacing: 16) {
                        Image(systemName: "person.fill")
                            .font(.system(size: 32))
                            .padding(8)
                            .overlay(RoundedRectangle(cornerRadius: 44)
                                        .stroke(Color(.label), lineWidth: 1)
                            )


                        VStack(alignment: .leading) {
                            Text("Username")
                                .font(.system(size: 16, weight: .bold))
                            Text("Message sent to user")
                                .font(.system(size: 14))
                                .foregroundColor(Color(.lightGray))
                        }
                        Spacer()

                        Text("22d")
                            .font(.system(size: 14, weight: .semibold))
                    }
                    Divider()
                        .padding(.vertical, 8)
                }.padding(.horizontal)

            }.padding(.bottom, 50)
        }
    }

    private var newMessageButton: some View {
        Button {

        } label: {
            HStack {
                Spacer()
                Text("+ New Message")
                    .font(.system(size: 16, weight: .bold))
                Spacer()
            }
            .foregroundColor(.white)
            .padding(.vertical)
                .background(Color.blue)
                .cornerRadius(32)
                .padding(.horizontal)
                .shadow(radius: 15)
        }
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView()
    }
}