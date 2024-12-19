//
//  UserModelCTO.swift
//  MatrimonialApp
//
//  Created by Nishtha Verma on 19/12/24.
//

import Foundation

struct UserDTO: Equatable {
    let gender: Gender
    let name: NameDTO
    let location: LocationDTO
    let email: String
    let phoneNumber: String
    let cell: String
    let picture: String
    let city: String
    let dateOfBirth: String
    let age: Int
    let isFavroite: Bool
    var isAccepted: Bool?
    var isRejected: Bool?
    static func == (lhs: UserDTO, rhs: UserDTO) -> Bool {
        return lhs.email == rhs.email
    }
}

// MARK: - NameDTO
struct NameDTO {
    let title: String
    let first: String
    let last: String
}

// MARK: - LocationDTO
struct LocationDTO {
    let city: String
    let coordinates: CoordinatesDTO
}

// MARK: - CoordinatesDTO
struct CoordinatesDTO {
    let latitude: String
    let longitude: String
}
