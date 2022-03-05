//
//  ContentView.swift
//  ChatApp
//
//  Created by Apple on 04/03/2022.
//

import SwiftUI

struct LoginView: View {
    @State var isLoginState: Bool = false
    @State var email = ""
    @State var password = ""
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
                        SecureField("Password", text: $password)
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
                }.padding()
            }
            .navigationTitle(isLoginState ? "Log In" : "Create Account")
            .background(Color.init(white: 0, opacity: 0.05)
                            .ignoresSafeArea())
        }
    }
    // MARK: - Handle Buttons Action
    // Handle the functionality for the login & create
    // if Login state .. user should login with Firebase
    // if Not, create new in Firebase
    private func handleLoginCreateAction() {
        if isLoginState {
            print("Login...")
        } else {
            print("Register...")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
