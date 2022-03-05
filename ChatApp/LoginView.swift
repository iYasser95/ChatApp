//
//  ContentView.swift
//  ChatApp
//
//  Created by Apple on 04/03/2022.
//

import SwiftUI
import Firebase

struct LoginView: View {
    @State var isLoginState: Bool = false
    @State var email = ""
    @State var password = ""
    @State var isButtonDisabled: Bool = true
    init() {
        FirebaseApp.configure()
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
                            
                        }, label: {
                            Image(systemName: "person.fill")
                                .font(.system(size: 64))
                                .accentColor(.black)
                                .padding()
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
                }.padding()
            }
            .navigationTitle(isLoginState ? "Log In" : "Create Account")
            .background(Color.init(white: 0, opacity: 0.05)
                            .ignoresSafeArea())
        }
        .navigationViewStyle(StackNavigationViewStyle())
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
//        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
//            guard error == nil else {
//                print("failed to create user", error?.localizedDescription ?? "")
//                return
//            }
//
//            print("Create account with ID: \(result?.user.uid ?? "")")
//        }
    }
    
    private func loginUser() {
        // Login user with Firebase
    }
    
    // MARK: - Validate credentials
    func validateCerdentials() {
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
