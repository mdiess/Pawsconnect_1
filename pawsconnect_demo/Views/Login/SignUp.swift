//
//  SignUp.swift
//  pawsconnect_demo
//
//  Created by Max Diess on 7/20/23.
//

import SwiftUI
import CoreData

struct SignUp: View {
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var email: String = ""
    @State private var birthday: Date = Date()
    @State private var shouldNavigateToBottomTab = false
    @Environment(\.managedObjectContext) private var viewContext
    var body: some View {
        NavigationView {
            ZStack {
                Color("primary")
                    .ignoresSafeArea()
                VStack {
                    Text("Create Account")
                        .font(.custom("Optima-ExtraBlack", size:40))
                        .offset(y:-75)
                        .shadow(color: Color.gray, radius: 3, x: 0, y: 0)
                    TextField("First Name", text: $firstName)
                        .padding()
                        .frame(maxWidth: 300, maxHeight: 50)
                        .background(
                            Capsule()
                                .strokeBorder(Color.white, lineWidth: 1)
                                .background(Color.white)
                                .clipped()
                        )
                        .clipShape(Capsule())
                    TextField("Last Name", text: $lastName)
                        .padding()
                        .frame(maxWidth: 300, maxHeight: 50)
                        .background(
                            Capsule()
                                .strokeBorder(Color.white, lineWidth: 1)
                                .background(Color.white)
                                .clipped()
                        )
                        .clipShape(Capsule())

                    TextField("Username", text: $username)
                        .padding()
                        .frame(maxWidth: 300, maxHeight: 50)
                        .background(
                            Capsule()
                                .strokeBorder(Color.white, lineWidth: 1)
                                .background(Color.white)
                                .clipped()
                        )
                        .clipShape(Capsule())

                    SecureField("Password", text: $password)
                        .padding()
                        .frame(maxWidth: 300, maxHeight: 50)
                        .background(
                            Capsule()
                                .strokeBorder(Color.white, lineWidth: 1)
                                .background(Color.white)
                                .clipped()
                        )
                        .clipShape(Capsule())
                    TextField("Email", text: $email)
                        .padding()
                        .frame(maxWidth: 300, maxHeight: 50)
                        .background(
                            Capsule()
                                .strokeBorder(Color.white, lineWidth: 1)
                                .background(Color.white)
                                .clipped()
                        )
                        .clipShape(Capsule())

                    DatePicker("Birthday", selection: $birthday, displayedComponents: .date)
                        .padding()
                        .frame(maxWidth: 300, maxHeight: 50)

                    Button("Sign Up") {
                        signUpButtonTapped()
                    }
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
                NavigationLink(destination: BottomTab(), isActive: $shouldNavigateToBottomTab) { EmptyView() }
            }
        }
    }
    
    private func doesUserProfileExistWithEmail(email: String, in context: NSManagedObjectContext) -> Bool {
        let fetchRequest: NSFetchRequest<UserProfile> = UserProfile.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "email == %@", email)
        do {
            let matchingUserProfiles = try context.fetch(fetchRequest)
            return !matchingUserProfiles.isEmpty
        } catch {
            print("Error fetching UserProfile: \(error)")
            return false
        }
    }

    private func signUpButtonTapped() {
        if doesUserProfileExistWithEmail(email: email, in: viewContext) {
            print("An account with this email already exists. Please use a different email.")
        } else {
            let id = UUID()
            UserProfileManager.saveUserProfile(
                firstName: firstName,
                lastName: lastName,
                id: id,
                username: username,
                password: password,
                followers: 0,
                following: 0,
                birthday: birthday,
                email: email,
                in: viewContext
            )
            shouldNavigateToBottomTab = true
        }
    }
}


struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        SignUp()
    }
}
