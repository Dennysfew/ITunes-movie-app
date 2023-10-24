# ITunes Movie Catalog App

This repository contains the source code for a Movie Catalog iOS app that offers a user-friendly interface for movie enthusiasts. The app provides a range of features, including user registration, movie search, favorites management, user profiles, and more. It adheres to the following requirements:

## Features

### User Authentication

1. **Login Page**: Users can log in with their email and password.

### Main Interface

2. **Tabbed Interface**: Upon successful login, users are directed to an interface with three tabs: "Home," "Selected," and "Profile."

### Home Tab

3. **Movie Search**:
   - Users can search for movies using the iTunes Search API.
   - Each movie result displays its cover image, title, release year, and genre.
   - Users can add movies to their favorites list.

4. **Movie Details**:
   - Users can view detailed information about a movie in Safari.

### Selected Tab

5. **Selected List**:
   - This tab displays a list of movies that users have marked as their favorites.

### Profile Tab

6. **User Profile**:
   - Users can view their profile, including their image, name, and other relevant information.
   - Users can log out of their account.

### Local Data Storage (Core Data)

7. **Local Data Storage (Core Data)**:
   - The app utilizes Core Data for local data storage, allowing efficient management of the list of favorite movies selected by user.

### Sharing

8. **Sharing Feature**:
   - A sharing feature is included, allowing users to share movie content (links to specific movies) with others.

## Platform and Requirements

- **Platform**: iPhone
- **UI Framework**: UIKit
- **Orientation**: Portrait
- **iOS Version Support**: iOS 15 and above

Feel free to fork this repository, contribute, or use the code as a reference for your own movie catalog app development.
