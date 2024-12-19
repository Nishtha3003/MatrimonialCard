//
//  MatrimonialAppApp.swift
//  MatrimonialApp
//
//  Created by Nishtha Verma on 19/12/24.
//

import SwiftUI

struct ProfileView: View {
    var userData: UserDTO
    var onAccept: () -> Void
    var onReject: () -> Void
    var onMoreInfo: () -> Void
    var openLocation: () -> Void

    var body: some View {
        VStack {
            ZStack {
                ProfileImage(userData: userData)
                UserInfo(userData: userData, openLocation: openLocation, onMoreInfo: onMoreInfo)
            }
            .frame(width: 280, height: 300)
            UserActions(userData: userData, onAccept: onAccept, onReject: onReject)
        }
    }
}

// MARK: - Profile Image Section
struct ProfileImage: View {
    var userData: UserDTO
    
    var body: some View {
        ZStack {
            Color.red
                .clipShape(RoundedRectangle(cornerRadius: 16))
            AsyncImage(url: URL(string: userData.picture)) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .clipShape(RoundedRectangle(cornerRadius: 16))
            } placeholder: {
                ProgressView()
            }
            .frame(width: 280, height: 300)
        }
    }
}

// MARK: - User Info Section
struct UserInfo: View {
    var userData: UserDTO
    var openLocation: () -> Void
    var onMoreInfo: () -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "mappin.and.ellipse")
                    .foregroundColor(Color.white)
                    .padding()
                    .background(Color.blue.opacity(0.6))
                    .clipShape(Circle())
                    .frame(width: 40)
                
                Spacer()
                Image(systemName: userData.isFavroite ? "heart.fill" : "heart")
                    .foregroundColor(Color.red)
                    .frame(width: 30, height: 30)
                Button(action: onMoreInfo) {
                    Image(systemName: "info.circle.fill")
                        .resizable()
                        .foregroundColor(Color.white)
                        .frame(width: 30, height: 30)
                        .clipShape(Circle())
                        .shadow(color: Color.purple.opacity(0.4), radius: 6, x: 0, y: 3)
                        .onTapGesture {
                            openLocation()
                        }
                }
            }
            Spacer()
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    Text(userData.name.first)
                        .font(Font.bold24Font)
                        .foregroundColor(Color.white)
                    Text(userData.location.city)
                        .font(Font.regular16Font)
                        .foregroundColor(Color.white)
                }
                Spacer()
                Text("\(userData.age)\(userData.gender.symbol)")
                    .font(Font.bold24Font)
                    .foregroundColor(Color.white)
                    .padding()
                    .background(LinearGradient(gradient: Gradient(colors: [Color.purple, Color.pink]), startPoint: .topLeading, endPoint: .bottomTrailing))
                    .clipShape(Circle())
                    .shadow(color: Color.blue.opacity(0.4), radius: 6, x: 0, y: 3)
            }
        }
        .padding(12)
        LinearGradient(colors: [Color.clear, Color.clear, Color.black.opacity(0.4)], startPoint: .top, endPoint: .bottom)
            .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

// MARK: - User Actions Section
struct UserActions: View {
    var userData: UserDTO
    var onAccept: () -> Void
    var onReject: () -> Void
    
    var body: some View {
        if (userData.isAccepted ?? false) {
            AcceptedButton()
        } else if (userData.isRejected ?? false) {
            RejectedButton(onReject: onReject)
        } else {
            DefaultActionButtons(onAccept: onAccept, onReject: onReject)
        }
    }
}

// MARK: - Accepted Button
struct AcceptedButton: View {
    var body: some View {
        Button(action: {}) {
            HStack {
                Image(systemName: "checkmark.circle.fill")
                    .font(.title)
                Text("Already Accepted")
                    .fontWeight(.semibold)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .foregroundColor(.white)
            .background(Color.green)
            .cornerRadius(10)
            .shadow(color: Color.green.opacity(0.4), radius: 8, x: 0, y: 4)
        }
    }
}

// MARK: - Rejected Button
struct RejectedButton: View {
    var onReject: () -> Void
    
    var body: some View {
        Button(action: onReject) {
            HStack {
                Image(systemName: "xmark.circle.fill")
                    .font(.title)
                Text("Rejected")
                    .fontWeight(.semibold)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .foregroundColor(.white)
            .background(Color.red)
            .cornerRadius(10)
            .shadow(color: Color.red.opacity(0.4), radius: 8, x: 0, y: 4)
        }
    }
}

// MARK: - Default Action Buttons (Accept/Reject)
struct DefaultActionButtons: View {
    var onAccept: () -> Void
    var onReject: () -> Void
    
    var body: some View {
        HStack(spacing: 12) {
            Button(action: onAccept) {
                HStack {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.title)
                    Text("Accept")
                        .fontWeight(.semibold)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .foregroundColor(.white)
                .background(Color.green)
                .cornerRadius(10)
                .shadow(color: Color.green.opacity(0.4), radius: 8, x: 0, y: 4)
            }
            
            Button(action: onReject) {
                HStack {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title)
                    Text("Reject")
                        .fontWeight(.semibold)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .foregroundColor(.white)
                .background(Color.red)
                .cornerRadius(10)
                .shadow(color: Color.red.opacity(0.4), radius: 8, x: 0, y: 4)
            }
        }
        .frame(maxHeight: 60)
        .cornerRadius(12)
    }
}
