//
//  UserRepository.swift
//  MatrimonialApp
//
//  Created by Nishtha Verma on 19/12/24.
//

import Foundation
import CoreData

protocol UserRepositoryProtocol {
    func fetchUserProfiles(resultQuery: Int, completion: @escaping (Result<[UserDTO], ServiceError>) -> Void)
    func saveUsersToCoreData(userDTOs: [UserDTO]) 
}

class UserRepository: UserRepositoryProtocol {
    private let userService: UserService
    private let coreDataManager = CoreDataManager.shared
    
    init(userService: UserService = UserService.shared) {
        self.userService = userService
    }
    
    func fetchUserProfiles(resultQuery: Int, completion: @escaping (Result<[UserDTO], ServiceError>) -> Void) {
        if NetworkMonitor.shared.isConnected {
            userService.getProfileList(completion: { [weak self] userResponse, error in
                guard let self = self else { return }
                
                if let error = error {
                    completion(.failure(error))
                } else if let userResponse = userResponse {
                    let userDTOs = userResponse.results.map { $0.toDTO() }
                    self.saveUsersToCoreData(userDTOs: userDTOs)
                    
                    completion(.success(userDTOs))
                } else {
                    completion(.failure(.invalidResponse))
                }
            }, resultQuery: resultQuery)
        } else {
            let userDTOs = fetchUsersFromCoreData()
            completion(.success(userDTOs))
        }
    }
    
    func updateUserStatus(userDTO: UserDTO, completion: @escaping (Result<Void, ServiceError>) -> Void) {
        let context = coreDataManager.context
        let fetchRequest: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "email == %@", userDTO.email)
        
        do {
            let userEntities = try context.fetch(fetchRequest)
            if let userEntity = userEntities.first {
                userEntity.isAccepted = userDTO.isAccepted ?? false
                userEntity.isRejected = userDTO.isRejected ?? false
                try context.save()
                print("Successfully updated user status.")
                completion(.success(()))
            } else {
               // completion(.failure(.userNotFound))
            }
        } catch {
            print("Failed to update user status: \(error)")
            //completion(.failure(.coreDataError))
        }
    }
    
    internal func saveUsersToCoreData(userDTOs: [UserDTO]) {
        let context = coreDataManager.context

        // Clear existing data
        clearExistingUsers()

        // Insert new data
        userDTOs.forEach { dto in
            let userEntity = UserEntity(context: context)
            userEntity.gender = dto.gender.rawValue
            userEntity.firstName = dto.name.first
            userEntity.lastName = dto.name.last
            userEntity.email = dto.email
            userEntity.phone = dto.phoneNumber
            userEntity.thumbnail = dto.picture
            userEntity.city = dto.city
            userEntity.latitude = dto.location.coordinates.latitude
            userEntity.longitude = dto.location.coordinates.longitude
            userEntity.dob = dto.dateOfBirth
            userEntity.age = Int16(dto.age)
            userEntity.isAccepted = dto.isAccepted ?? false
            userEntity.isRejected = dto.isRejected ?? false
        }
        do {
            try context.save()
            print("Successfully saved all users.")
        } catch {
            print("Failed to save users to Core Data: \(error)")
        }
    }
    
    private func fetchUsersFromCoreData() -> [UserDTO] {
        let context = coreDataManager.context
        let fetchRequest: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()

        do {
            let userEntities = try context.fetch(fetchRequest)
            return userEntities.map { entity in
                UserDTO(
                    gender: Gender(rawValue: entity.gender ?? "male") ?? .female,
                    name: NameDTO(
                        title: "",
                        first: entity.firstName ?? "",
                        last: entity.lastName ?? ""
                    ),
                    location: LocationDTO(
                        city: entity.city ?? "",
                        coordinates: CoordinatesDTO(
                            latitude: entity.latitude ?? "",
                            longitude: entity.longitude ?? ""
                        )
                    ),
                    email: entity.email ?? "",
                    phoneNumber: entity.phone ?? "",
                    cell: "",
                    picture: entity.thumbnail ?? "",
                    city: entity.city ?? "",
                    dateOfBirth: entity.dob ?? "",
                    age: Int(entity.age),
                    isFavroite: false, // Default value, can be updated later
                    isAccepted: entity.isAccepted,
                    isRejected: entity.isRejected
                )
            }
        } catch {
            print("Failed to fetch users from Core Data: \(error)")
            return []
        }
    }
    
    private func clearExistingUsers() {
        let context = coreDataManager.context
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = UserEntity.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(deleteRequest)
            print("Cleared existing users.")
        } catch {
            print("Failed to clear existing users: \(error)")
        }
    }
}


import Network

class NetworkMonitor {
    static let shared = NetworkMonitor()
    
    private let monitor: NWPathMonitor
    private let queue = DispatchQueue.global(qos: .background)
    private(set) var isConnected: Bool = false
    
    private init() {
        monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { path in
            self.isConnected = path.status == .satisfied
        }
        monitor.start(queue: queue)
    }
    
    func startMonitoring() {
        monitor.start(queue: queue)
    }
    
    func stopMonitoring() {
        monitor.cancel()
    }
}
