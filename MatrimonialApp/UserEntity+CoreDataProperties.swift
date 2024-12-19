//
//  UserEntity+CoreDataProperties.swift
//  MatrimonialApp
//
//  Created by Nishtha Verma on 19/12/24.
//
//

import Foundation
import CoreData


extension UserEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserEntity> {
        return NSFetchRequest<UserEntity>(entityName: "UserEntity")
    }

    @NSManaged public var gender: String?
    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var email: String?
    @NSManaged public var phone: String?
    @NSManaged public var thumbnail: String?
    @NSManaged public var city: String?
    @NSManaged public var latitude: String?
    @NSManaged public var longitude: String?
    @NSManaged public var age: Int16
    @NSManaged public var dob: String?
    @NSManaged public var fav: Bool
    @NSManaged public var isAccepted: Bool
    @NSManaged public var isRejected: Bool

}

extension UserEntity : Identifiable {

}
