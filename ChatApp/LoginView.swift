//
//  ContentView.swift
//  ChatApp
//
//  Created by Apple on 04/03/2022.
//

import SwiftUI
import Firebase

struct LoginView: View {
    @State private var isLoginState: Bool = false
    @State private var email = ""
    @State private var password = ""
    @State private var isButtonDisabled: Bool = true
    @State private var loginStatusMessage: String = ""
    @State private var shouldShowImagePicker: Bool = false
    @State private var userImage: UIImage?
    @Environment(\.presentationMode) var presentationMode
    let didUserLogIn: () -> ()
    var firebaseManager = FirebaseManager.shared
    var isEmailValid: Bool {
        return validateEmail(email)
    }
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    Picker(selection: $isLoginState, label: Text("picker here"), content: {
                        // The selection is determined by 'isLoginState'
                        // false = Create Account, true = Login
                        Text("Log In")
                            .tag(true)
                        Text("Create Account")
                            .tag(false)
                    }).pickerStyle(SegmentedPickerStyle())
                    if !isLoginState {
                        Button(action: {
                            shouldShowImagePicker.toggle()
                        }, label: {
                            VStack {
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
                                
                            }
                            .overlay(RoundedRectangle(cornerRadius: 64)
                                        .stroke(Color.black, lineWidth: 3)
                            
                            )
                           
                        })
                    }
                    // applying modifiers on 'Group' will apply them to all the elements in the group
                    Group {
                        TextField("Email", text: $email)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                            .onChange(of: email, perform: { _ in
                                validateCerdentials()
                            })
                        SecureField("Password", text: $password)
                            .onChange(of: password, perform: { _ in
                                validateCerdentials()
                            })
                    }
                    .padding(12)
                    .background(Color.white)
                    .cornerRadius(17)
                    Button(action: {
                        handleLoginCreateAction()
                    }, label: {
                        HStack {
                            Spacer()
                            Text(isLoginState ? "Log In" : "Create Account")
                                .foregroundColor(Color.white)
                                .padding(.vertical, 10)
                                .font(.system(size: 14, weight: .bold))
                            Spacer()
                        }.background(Color.blue)
                        .cornerRadius(17)
                        .padding()
                    })
                    .disabled(isButtonDisabled)
                    .opacity(isButtonDisabled ? 0.5 : 1)
                    Text(loginStatusMessage)
                        .foregroundColor(.red)
                }.padding()
            }
            .navigationTitle(isLoginState ? "Log In" : "Create Account")
            .background(Color.init(white: 0, opacity: 0.05)
                            .ignoresSafeArea())
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .fullScreenCover(isPresented: $shouldShowImagePicker, onDismiss: nil, content: {
            ImagePicker(image: $userImage)
        })
    }
    // MARK: - Handle Authentication
    // Handle the functionality for the login & create
    // if Login state .. user should login with Firebase
    // if Not, create new in Firebase
    private func handleLoginCreateAction() {
        if isLoginState {
            loginUser()
        } else {
           createNewAccount()
        }
    }
    
    private func createNewAccount() {
        // Create new user account in Firebase
        guard self.userImage != nil else {
            // Show an error message for empty image
            self.loginStatusMessage = "Please select a profile Image"
            return
        }
        firebaseManager.createNewAccount(email: email, password: password) { (error) in
            self.loginStatusMessage = error?.localizedDescription ?? ""
            guard error == nil else { return }
            if let userImage = self.userImage {
                self.firebaseManager.uploadImageToStorage(image: userImage) { (error, url) in
                    self.loginStatusMessage = error?.localizedDescription ?? ""
                    let auth = firebaseManager.auth
                    let uid = auth.currentUser?.uid ?? ""
                    let userData = ["uid": uid, "email": self.email, "profileImage": url?.absoluteString ?? ""]
                    self.firebaseManager.storeUserData(with: userData) { (error) in
                        self.loginStatusMessage = error?.localizedDescription ?? ""
                        guard error == nil else { return }
                        self.didUserLogIn()
                    }
                }
            }
        }
    }

    private func loginUser() {
        // Login user with Firebase
        firebaseManager.loginUser(email: email, password: password) { (error) in
            self.loginStatusMessage = error?.localizedDescription ?? ""
            guard error == nil else { return }
            self.didUserLogIn()
            self.presentationMode.wrappedValue.dismiss()
        }
    }
    
    // MARK: - Validate credentials
    func validateCerdentials() {
        isButtonDisabled = email.isEmpty || password.isEmpty || !isEmailValid
    }
    
    func validateEmail(_ string: String) -> Bool {
        guard string.count <= 64 else { return false }
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: string)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(didUserLogIn: {
            // No Implementation needed here.
        })
    }
}
