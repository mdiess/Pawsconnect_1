//
//  Login.swift
//  pawsconnect_demo
//
//  Created by Max Diess on 7/20/23.
//

import SwiftUI
import CoreData

struct Login: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var shouldNavigate: Bool = false
    @Environment(\.managedObjectContext) private var viewContext
    var body: some View {
        NavigationView {
            ZStack {
                Color("primary")
                    .ignoresSafeArea()
                VStack(spacing:30) {
                    Text("PawsConnect")
                        .font(.custom("Optima-ExtraBlack", size:45))
                        .offset(y:-130)
                        .shadow(color: Color.gray, radius: 3, x: 0, y: 0)
                    VStack(spacing:30) {
                        TextField("Username", text: $username)
                            .padding()
                            .frame(maxWidth:300, maxHeight:50)
                            .background(
                                Capsule()
                                    .strokeBorder(Color.white,lineWidth: 1)
                                    .background(Color.white)
                                    .clipped()
                            )
                            .clipShape(Capsule())
                            .offset(y:-80)
                        SecureField("Password", text: $password)
                            .padding()
                            .frame(maxWidth:300, maxHeight:50)
                            .background(
                                Capsule()
                                    .strokeBorder(Color.white,lineWidth: 1)
                                    .background(Color.white)
                                    .clipped()
                            )
                            .clipShape(Capsule())
                            .offset(y:-80)
                        Button(action: loginButtonTapped) {
                            Text("Login")
                                .font(.headline)
                                .foregroundColor(.black)
                                .padding()
                                .frame(maxWidth: 300, maxHeight: 50)
                                .background(
                                    Capsule()
                                        .strokeBorder(Color("secondary"), lineWidth: 1)
                                        .background(Color("secondary"))
                                        .shadow(color: Color.black, radius: 5, x: 0, y: 0)
                                        .clipped()
                                )
                                .clipShape(Capsule())
                        }
                    }
                    .shadow(color: Color.black, radius: 3, x: 0, y: 0)
                }
                .offset(y:-50)
            }
            
        }
        .onChange(of: shouldNavigate) { newValue in
            if newValue {
                username = ""
                password = ""
            }
        }
        .background(NavigationLink(destination: BottomTab(), isActive: $shouldNavigate) { EmptyView() })
    }

    private func loginButtonTapped() {
        if doesUserProfileExist(username: username, password: password, in: viewContext) {
            shouldNavigate = true
        } else {
            print("Invalid credentials. Please try again.")
        }
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}
