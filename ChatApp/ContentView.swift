//
//  ContentView.swift
//  ChatApp
//
//  Created by Apple on 04/03/2022.
//

import SwiftUI

struct ContentView: View {
    @State var isLoginState: Bool = false
    @State var email = ""
    @State var password = ""
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Text("my login page")
                    Picker(selection: $isLoginState, label: Text("picker here"), content: {
                        // The selection is determined by 'isLoginState'
                        // false = Create Account, true = Login
                        Text("Login")
                            .tag(true)
                        Text("Create Account")
                            .tag(false)
                    }).pickerStyle(SegmentedPickerStyle())
                    Button(action: {
                        
                    }, label: {
                        Image(systemName: "person.fill")
                            .font(.system(size: 64))
                            .accentColor(.black)
                            .padding()
                    })
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .padding()
                    SecureField("Password", text: $password)
                        .padding()
                    Button(action: {
                        
                    }, label: {
                        HStack {
                            Spacer()
                            Text("Create Account")
                                .foregroundColor(Color.white)
                                .padding(.vertical, 10)
                            Spacer()
                        }.background(Color.blue)
                        .padding()
                    })
                }.padding()
            }
            .navigationTitle("Create Account")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
