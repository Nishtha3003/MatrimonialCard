//
//  ContentView.swift
//  MatrimonialApp
//
//  Created by Nishtha Verma on 19/12/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = UserViewModel()
    @State private var errorMessage: String?

    var body: some View {
        VStack(alignment: .leading) {
            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }
            Text("Profile Matches")
                .font(Font.bold24Font)
                .foregroundColor(Color.black)
                .padding()
                .padding(.top, 100)
                
            if viewModel.userDTOs.isEmpty {
                ProgressView("Loading...")
                    .progressViewStyle(CircularProgressViewStyle())
                    .padding()
            } else {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(viewModel.userDTOs, id: \.email) { user in
                            ProfileView(
                                userData: user,
                                onAccept: {
                                    var data = user
                                    data.isAccepted = true
                                    data.isRejected = false
                                    viewModel.updateUserDTOList(data)
                                },
                                onReject: {
                                    var data = user
                                    data.isAccepted = false
                                    data.isRejected = true
                                    viewModel.updateUserDTOList(data)
                                },
                                onMoreInfo: {
                                    
                                },
                                openLocation: {
                                    openGoogleMaps(
                                        latitude: Double(user.location.coordinates.latitude) ?? 0.0,
                                        longitude: Double(user.location.coordinates.longitude) ?? 0.0)
                                }
                            )
                            .padding(20)
                        }
                    }
                    .padding()
                }
                .frame(height: 800)
            }
        }
        .onAppear {
            viewModel.fetchUserProfiles(resultQuery: 20)
        }
    }
    
    private func acceptUser(_ user: UserDTO) {
        // Update userDTO to mark it as accepted
        var updatedUser = user
        updatedUser.isAccepted = true
        updatedUser.isRejected = false
        viewModel.updateUserDTOList(updatedUser)
    }

    private func rejectUser(_ user: UserDTO) {
        var updatedUser = user
        updatedUser.isAccepted = false
        updatedUser.isRejected = true
        viewModel.updateUserDTOList(updatedUser)
    }
    
    private func openGoogleMaps(latitude: Double, longitude: Double) {
        let url = URL(string: "https://www.google.com/maps?q=\(latitude),\(longitude)")!
        UIApplication.shared.open(url)
    }
}


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(
            userData: UserDTO(
                gender: .male,
                name: NameDTO(title: "Mr", first: "Ajay", last: "Sherawat"),
                location: LocationDTO(city: "Bangalore", coordinates: CoordinatesDTO(latitude: "84.54", longitude: "43.5")),
                email: "ajay@newgmail.com",
                phoneNumber: "85390539",
                cell: "836r47834",
                picture: "https://randomuser.me/api/portraits/men/72.jpg",
                city: "Banglore",
                dateOfBirth: "30/03",
                age: 34,
                isFavroite: false
            ),
            onAccept: {
                print("Accepted")
            },
            onReject: {
                print("Rejected")
            },
            onMoreInfo: {
                print("More Info tapped")
            },
            openLocation:  {
                
            }
        )
    }
}
