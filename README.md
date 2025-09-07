# MovieRatingsApp
**MovieRatingsApp** is an iOS application that allows users to browse movie reviews, view ratings, and post their own ratings and comments for movies. The app connects to a Firebase backend for user authentication and storing/retrieving reviews.

## Features
- **User Authentication:** Secure sign-up and login functionality to protect user accounts.
- **Browse Reviews & Ratings:** View community-submitted reviews and ratings for each movie.
- **Submit & Edit Reviews:** Share your own rating and comment for a movie. Each user can only have one review per movie, which can be edited to prevent duplicate entries and reduce bias.
- **Modern UI Design:** Gradient red–blue background, interactive buttons, rounded input fields, and toggleable password visibility for a clean, intuitive experience.
- **Real-Time Sync with Firebase:** Reviews update instantly across all users’ devices—whether viewing your own reviews, browsing all reviews, or checking saved ratings.

## Main Screens
- **LoginView:** Provides login and sign-up functionality using email and password authentication.
- **MovieRatingsView:** Displays the list of movies in the database, including the title, poster, description, release year, average rating (out of 5), and reviews. This view also includes navigation to your personal ratings, all app-wide ratings, the option to submit or update your rating, and the ability to log out.
- **ReviewsScreen:** Shows detailed reviews and ratings from all users for a specific movie.
- **MyRatingsListView:** Lists all the reviews and ratings you’ve submitted. Selecting a movie from this view redirects you back to the corresponding MovieRatingsView for that movie.

## Usage
- **Sign Up / Log In:** Create a new account or log in with an existing account.
- **Browse Movies:** Select a movie to view its reviews and average rating.
- **Add a Review:** Enter your rating and a comment to share with other users.
- **View Updates:** Reviews update in real time for all users.

## Technologies
- **Swift & SwiftUI:** Frontend and Backend development for iOS.
- **Firebase Authentication:** Secure login/sign-up functionality.
- **Firebase Firestore:** Real-time database for storing and retrieving reviews.
- **Git:** Version control and collaborative development.

## Project Structure
MovieReviews/
├─ Preview Content/            # SwiftUI preview assets
├─ Assets/                     # App images, icons, and other assets (Movie Posters and images)
├─ AuthViewModel.swift         # Handles authentication logic (login/signup)
├─ ContentView.swift           # Entry point for the app UI
├─ FirestoreManager.swift      # Handles Firebase Firestore operations
├─ LoginView.swift             # Login and SignUp UI
├─ Movie.swift                 # Movie and Review model structure
├─ MovieRatingsView.swift      # Main Screen that displays the list of movies in the database, including the title, poster, description, release year, average rating (out of 5), and reviews, and contains the buttons for other app functionalities
├─ MovieReviewsApp.swift       # App lifecycle entry point
├─ RatingsListView.swift       # List of your own ratings/reviews that you have left for movies
├─ ReviewsSheet.swift          # Sheet UI for desplaying all reviews left from any user in the database 
├─ ViewModel.swift             # Main view model handling app data and changing views

## Getting Started 
1. Open the project in **Xcode**.
2. Set up **Firebase** for the project.
3. Download and add your `GoogleService-Info.plist` file to the Xcode project (do not commit this file to GitHub).
4. In the Firebase Console:
   - Enable **Authentication** → Email/Password (for Log In and Sign Up).
   - Enable **Cloud Firestore** → Create a `movies/` collection, with documents for each movie (e.g., `/Back to the Future/`, `/Barbie/`, `/Batman/`, etc.). Each document ID should match the movie IDs used in the app.
5. Build and run on a physical iOS device or simulator.
