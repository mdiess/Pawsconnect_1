//
//  UserProfileManager.swift
//  pawsconnect_demo
//
//  Created by Max Diess on 7/20/23.
//

import Foundation
import CoreData

class UserProfileManager {
    static func saveUserProfile(firstName: String, lastName: String, id: UUID, username: String, password: String, followers: Int, following: Int, birthday: Date, email: String, in context: NSManagedObjectContext) {
        let newUserProfile = UserProfile(context: context)
        newUserProfile.firstName = firstName
        newUserProfile.lastName = lastName
        newUserProfile.id = id
        newUserProfile.username = username
        newUserProfile.password = password
        newUserProfile.followers = Int16(followers)
        newUserProfile.following = Int16(following)
        newUserProfile.birthday = birthday
        newUserProfile.email = email

        do {
            try context.save()
        } catch {
            print("Error saving UserProfile: \(error)")
        }
    }
}

