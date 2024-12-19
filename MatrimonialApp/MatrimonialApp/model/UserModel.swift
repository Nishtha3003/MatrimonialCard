//
//  UserModel.swift
//  MatrimonialApp
//
//  Created by Nishtha Verma on 19/12/24.
//

import Foundation

// MARK: - User Response Model
struct UserResponse: Codable {
    let results: [User]
    let info: Info
}

// MARK: - User
struct User: Codable {
    let gender: String
    let name: Name
    let location: Location
    let email: String
    let login: Login
    let dob: DateOfBirth
    let registered: Registered
    let phone: String
    let cell: String
    let id: Identifier
    let picture: Picture
    let nat: String
}

// MARK: - Name
struct Name: Codable {
    let title: String
    let first: String
    let last: String
}

// MARK: - Location
struct Location: Codable {
    let street: Street
    let city: String
    let state: String
    let country: String
    let postcode: Postcode
    let coordinates: Coordinates
    let timezone: Timezone
}

enum Postcode: Codable {
    case int(Int)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let intValue = try? container.decode(Int.self) {
            self = .int(intValue)
        } else if let stringValue = try? container.decode(String.self) {
            self = .string(stringValue)
        } else {
            throw DecodingError.typeMismatch(Postcode.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Invalid type for Postcode"))
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .int(let value):
            try container.encode(value)
        case .string(let value):
            try container.encode(value)
        }
    }
}

// MARK: - Street
struct Street: Codable {
    let number: Int
    let name: String
}

// MARK: - Coordinates
struct Coordinates: Codable {
    let latitude: String
    let longitude: String
}

// MARK: - Timezone
struct Timezone: Codable {
    let offset: String
    let description: String
}

// MARK: - Login
struct Login: Codable {
    let uuid: String
    let username: String
    let password: String
    let salt: String
    let md5: String
    let sha1: String
    let sha256: String
}

// MARK: - DateOfBirth
struct DateOfBirth: Codable {
    let date: String
    let age: Int
}

// MARK: - Registered
struct Registered: Codable {
    let date: String
    let age: Int
}

// MARK: - Identifier
struct Identifier: Codable {
    let name: String
    let value: String?
}

// MARK: - Picture
struct Picture: Codable {
    let large: String
    let medium: String
    let thumbnail: String
}

// MARK: - Info
struct Info: Codable {
    let seed: String
    let results: Int
    let page: Int
    let version: String
}

extension User {
    func toDTO() -> UserDTO {
        return UserDTO(
            gender: self.gender == "female" ? .female : self.gender == "male" ? .male : .other,
            name: NameDTO(
                title: self.name.title,
                first: self.name.first,
                last: self.name.last
            ),
            location: LocationDTO(
                city: self.location.city,
                coordinates: CoordinatesDTO(
                    latitude: self.location.coordinates.latitude,
                    longitude: self.location.coordinates.longitude
                )
            ),
            email: self.email,
            phoneNumber: self.phone,
            cell: self.cell,
            picture: self.picture.large,
            city: self.location.city,
            dateOfBirth: self.dob.date,
            age: self.dob.age,
            isFavroite: false
        )
    }
}

enum Gender : String, Codable{
    case male
    case female
    case other
    
    var symbol: String {
            switch self {
            case .female:
                return "F"
            case .male:
                return "M"
            case .other:
                return "O"
            }
        }
}
