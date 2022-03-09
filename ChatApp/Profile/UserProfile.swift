//
//  UserProfile.swift
//  ChatApp
//
//  Created by Apple on 09/03/2022.
//

import SwiftUI

struct UserProfile: View {
    @State var username: String = ""
    @State var email: String = ""
    @State var userImage: UIImage?
    @State private var shouldShowImagePicker: Bool = false
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Button(action: {
                        shouldShowImagePicker.toggle()
                    }, label: {
                        Group {
                            if let image = userImage {
                                Image(uiImage: image)
                                    .resizable()
                            } else {
                                Image(systemName: "person.fill")
                                    .font(.system(size: 64))
                                    .foregroundColor(Color(.label))
                                    .padding()
                            }
                        }
                        .scaledToFill()
                        .frame(width: 128, height: 128)
                        .cornerRadius(64)
                    })
                }
                VStack {
                    Group {
                        TextField("Username", text: $username)
                            .keyboardType(.default)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                        TextField("Email", text: $email)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                    }
                    .padding(12)
                    .background(Color.white)
                    .cornerRadius(17)
                    .padding()
                }
            }
            .background(Color.init(white: 0, opacity: 0.05).ignoresSafeArea())
            .navigationViewStyle(StackNavigationViewStyle())
            .fullScreenCover(isPresented: $shouldShowImagePicker, onDismiss: nil, content: {
                ImagePicker(image: $userImage)
            })
        }
    }
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile()
    }
}
