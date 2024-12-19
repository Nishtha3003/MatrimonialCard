//
//  ViewModel.swift
//  MatrimonialApp
//
//  Created by Nishtha Verma on 19/12/24.
//

import Foundation

class UserViewModel : ObservableObject {
    private let userRepository: UserRepositoryProtocol
    @Published var userDTOs: [UserDTO] = []
    var didFetchUsers: (([UserDTO]) -> Void)?
    var didFailWithError: ((ServiceError) -> Void)?
    
    init(userRepository: UserRepositoryProtocol = UserRepository()) {
        self.userRepository = userRepository
    }
    
    func fetchUserProfiles(resultQuery: Int) {
        userRepository.fetchUserProfiles(resultQuery: resultQuery) { result in
            switch result {
            case .success(let users):
                self.userDTOs = users
                
            case .failure(_):
                print("failed")
            }
        }
    }
    
    func updateUserDTOList(_ updatedUserDTO: UserDTO) {
        if let index = userDTOs.firstIndex(where: { $0.email == updatedUserDTO.email }) {
            userDTOs[index] = updatedUserDTO
            saveUsersToCoreData(userDTOs)
        }
    }
    
    func saveUsersToCoreData(_ userDTOs: [UserDTO]) {
        userRepository.saveUsersToCoreData(userDTOs: userDTOs)
    }
}
