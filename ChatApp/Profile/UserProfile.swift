//
//  UserProfile.swift
//  ChatApp
//
//  Created by Apple on 09/03/2022.
//

import SwiftUI
import SDWebImageSwiftUI
struct UserProfile: View {
    @State var username: String = ""
    @State var email: String = ""
    @State var userImage: UIImage?
    @State private var shouldShowImagePicker: Bool = false
    @State var errorMessageLabel: String = ""
    @EnvironmentObject var model: MessageViewModel
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        NavigationView {
            ScrollView {
                Group {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("Cancel")
                            .foregroundColor(.black)
                    })
                }.padding(.leading, -200)
                
                VStack {
                    Button(action: {
                        shouldShowImagePicker.toggle()
                    }, label: {
                        WebImage(url: URL(string: model.user?.profileImageUrl ?? ""))
                        Image(systemName: "person.fill")
                            .scaledToFill()
                            .frame(width: 150, height: 150)
                            .clipped()
                            .cornerRadius(100)
                            .overlay(RoundedRectangle(cornerRadius: 100)
                                        .stroke(Color(.label), lineWidth: 1))
                    })
                }
                VStack(spacing: 20) {
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
                }.padding()
                Text("If you update the email you will need to sign in with the new one")
                    .padding()
                    .multilineTextAlignment(.center)
                    .foregroundColor(.red)
                    .font(.system(size: 18))
                Button(action: {
                    updateUserProfile()
                }, label: {
                    HStack {
                        Spacer()
                        Text("Update Profile")
                            .foregroundColor(Color.white)
                            .padding(.vertical, 10)
                            .font(.system(size: 14, weight: .bold))
                        Spacer()
                    }.background(Color.blue)
                    .cornerRadius(17)
                    .padding()
                })
                Text(errorMessageLabel)
                    .foregroundColor(.red)
            }
            .background(Color.init(white: 0, opacity: 0.05).ignoresSafeArea())
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationBarHidden(true)
            .fullScreenCover(isPresented: $shouldShowImagePicker, onDismiss: nil, content: {
                ImagePicker(image: $userImage)
            })
            .onAppear(perform: {
                fillUserData()
            })
        }
    }
    
    func fillUserData() {
        self.email = model.user?.email ?? ""
        self.username = model.user?.username ?? ""
    }
    private func updateUserProfile() {
        guard var userData = model.user else { return }
        userData.username = self.username
        userData.email = self.email
        guard userImage != nil else {
            let dataModel = UserModel.createDic(from: userData)
            FirebaseManager.shared.storeUserData(with: dataModel) { (error) in
                self.errorMessageLabel = error?.localizedDescription ?? ""
                guard error == nil else { return }
                print("Update user data with :\(dataModel)")
                presentationMode.wrappedValue.dismiss()
            }
            return
        }
        if let image = userImage {
            FirebaseManager.shared.uploadImageToStorage(image: image) { (error, url) in
                self.errorMessageLabel = error?.localizedDescription ?? ""
                guard error == nil else { return }
                print("Updated User Image", self)
                userData.profileImageUrl = url?.absoluteString ?? ""
                let dataModel = UserModel.createDic(from: userData)
                FirebaseManager.shared.storeUserData(with: dataModel) { (error) in
                    self.errorMessageLabel = error?.localizedDescription ?? ""
                    guard error == nil else { return }
                    print("Update user data with :\(dataModel)")
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile()
    }
}
