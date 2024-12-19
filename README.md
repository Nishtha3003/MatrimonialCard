#MatrimonialCard
Overview
MatrimonialCard is an iOS application that displays user profiles in a card-like interface, allowing users to accept or reject profile cards. The app integrates with Core Data for local storage and network functionality to fetch user profiles from a remote API. This application supports various features such as viewing profile details, managing favorite status, and locating user locations using Google Maps.

Features
Profile Card View: Displays user profiles with relevant information, including their picture, name, city, age, and gender.
Accept/Reject Profile: Users can either accept or reject profiles. The status is saved locally using Core Data.
Favorite Functionality: Users can mark profiles as favorites.
Location Tracking: Users can view the location of the profile on Google Maps.
Offline Support: Profiles are fetched from Core Data when there is no internet connection.
Project Structure
The project is structured into several key components:

1. User Models
UserDTO: The data transfer object used to represent user information.
Gender: Enum to represent the gender of a user.
LocationDTO: Contains user location details (city and coordinates).
CoordinatesDTO: Holds latitude and longitude coordinates.
2. Core Data Integration
UserEntity: Core Data entity that stores user profile data locally.
CoreDataManager: A singleton responsible for managing Core Data operations, including fetching, saving, and deleting data.
3. Network Layer
UserService: Handles API calls to fetch user profiles from the backend server.
NetworkMonitor: Monitors network connectivity status.
4. View Models
UserViewModel: Manages user data, including fetching profiles and updating their status (accept/reject).
UserRepository: Fetches and saves user profiles to Core Data or from the network.
5. UI Components
ProfileView: Displays user information and provides action buttons for accepting, rejecting, or viewing more details about the profile.
ContentView: The main view of the app that presents the list of user profiles in a horizontally scrollable view.
Installation
Clone this repository:

bash
Copy code
git clone https://github.com/yourusername/MatrimonialCard.git
Open the project in Xcode:

bash
Copy code
open MatrimonialCard.xcodeproj
Install dependencies (if any) and build the app using Xcode.

Run the app on a simulator or physical device.

Requirements
iOS 14.0+
Xcode 12.0+
Swift 5.0+
Usage
View User Profiles: When the app launches, a list of user profiles is displayed in a horizontally scrollable list.
Accept/Reject Profiles: For each profile, you can either accept or reject it. The status is saved locally in Core Data.
View Location: You can tap on the location icon to view the user's location in Google Maps.
Favorite: You can tap the heart icon to mark a user profile as a favorite.
Offline Support
The app supports offline mode. If no internet connection is available, the app will fetch the user profiles from Core Data.

Code Structure
UserDTO and UserEntity models define the structure of user data.
UserRepository handles both network and Core Data logic for fetching and saving user profiles.
UserViewModel interacts with the repository to fetch and modify the list of profiles.
ProfileView is the main UI component displaying each profile and managing user interactions (accept, reject, view more info).
Contributing
Feel free to fork the repository and submit pull requests. Make sure to follow the coding conventions and write tests for any new features or changes.

Fork the repository.
Create a new branch (git checkout -b feature/your-feature).
Commit your changes (git commit -am 'Add your feature').
Push to the branch (git push origin feature/your-feature).
Create a new Pull Request.
License
This project is licensed under the MIT License - see the LICENSE file for details.
