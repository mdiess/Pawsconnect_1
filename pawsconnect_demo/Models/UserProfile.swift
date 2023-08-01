//
//  UserProfile.swift
//  pawsconnect_demo
//
//  Created by Max Diess on 7/20/23.
//

import Foundation
import CoreData


//class UserProfile: NSManagedObject {
//    @NSManaged var firstName: String
//    @NSManaged var lastName: String
//    @NSManaged var id: String
//    @NSManaged var username: String
//    @NSManaged var password: String
//    @NSManaged var followers: Int32
//    @NSManaged var following: Int32
//    @NSManaged var birthday: Date
//    @NSManaged var email: String
//
//
//    init(firstName: String, lastName: String, id: String, username: String, password: String, followers: Int, following: Int, birthday: Date, email: String) {
//        self.firstName = firstName
//        self.lastName = lastName
//        self.id = id
//        self.username = username
//        self.password = password
//        self.followers = Int32(followers)
//        self.following = Int32(following)
//        self.birthday = birthday
//        self.email = email
//    }
//}

func doesUserProfileExist(username: String, password: String, in context: NSManagedObjectContext) -> Bool {
    let fetchRequest: NSFetchRequest<UserProfile> = UserProfile.fetchRequest()
    fetchRequest.predicate = NSPredicate(format: "username == %@ AND password == %@", username, password)

    do {
        let matchingUserProfiles = try context.fetch(fetchRequest)
        return !matchingUserProfiles.isEmpty
    } catch {
        // Handle the error appropriately.
        print("Error fetching UserProfile: \(error)")
        return false
    }
}
