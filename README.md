# MatrimonialCard

## Overview

**MatrimonialCard** is an iOS application that displays user profiles in a card-like interface, allowing users to accept or reject profile cards. The app integrates with Core Data for local storage and network functionality to fetch user profiles from a remote API. This application supports various features such as viewing profile details, managing favorite status, and locating user locations using Google Maps.

## Features

- **Profile Card View**: Displays user profiles with relevant information, including their picture, name, city, age, and gender.
- **Accept/Reject Profile**: Users can either accept or reject profiles. The status is saved locally using Core Data.
- **Favorite Functionality**: Users can mark profiles as favorites.
- **Location Tracking**: Users can view the location of the profile on Google Maps.
- **Offline Support**: Profiles are fetched from Core Data when there is no internet connection.

## Project Structure

The project is structured into several key components:

### 1. **User Models**
- **UserDTO**: The data transfer object used to represent user information.
- **Gender**: Enum to represent the gender of a user.
- **LocationDTO**: Contains user location details (city and coordinates).
- **CoordinatesDTO**: Holds latitude and longitude coordinates.

### 2. **Core Data Integration**
- **UserEntity**: Core Data entity that stores user profile data locally.
- **CoreDataManager**: A singleton responsible for managing Core Data operations, including fetching, saving, and deleting data.

### 3. **Network Layer**
- **UserService**: Handles API calls to fetch user profiles from the backend server.
- **NetworkMonitor**: Monitors network connectivity status.

### 4. **View Models**
- **UserViewModel**: Manages user data, including fetching profiles and updating their status (accept/reject).
- **UserRepository**: Fetches and saves user profiles to Core Data or from the network.

### 5. **UI Components**
- **ProfileView**: Displays user information and provides action buttons for accepting, rejecting, or viewing more details about the profile.
- **ContentView**: The main view of the app that presents the list of user profiles in a horizontally scrollable view.

## Installation

1. Clone this repository:

   ```bash
   git clone https://github.com/Nishtha3003/MatrimonialCard.git

