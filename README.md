# Pokédex Flutter App

A cross-platform Pokédex application built with Flutter, showcasing MVVM architecture, clean code principles, and modern Flutter development practices.

## App preview

### Light Mode

<div align="center">
  <img src="screenshots/Simulator Screenshot - iPhone 11 - 2025-10-23 at 14.26.45.png" width="250" alt="Splash Screen"/>
  <img src="screenshots/Simulator Screenshot - iPhone 11 - 2025-10-23 at 14.26.47.png" width="250" alt="Login Screen"/>
  <img src="screenshots/Simulator Screenshot - iPhone 11 - 2025-10-23 at 14.49.02.png" width="250" alt="Register Screen"/>
</div>

<div align="center">
  <img src="screenshots/Simulator Screenshot - iPhone 11 - 2025-10-23 at 14.27.08.png" width="250" alt="Home - Pokemon List"/>
  <img src="screenshots/Simulator Screenshot - iPhone 11 - 2025-10-23 at 14.27.11.png" width="250" alt="Pokemon Detail - Ivysaur"/>
  <img src="screenshots/Simulator Screenshot - iPhone 11 - 2025-10-23 at 14.27.16.png" width="250" alt="Pokemon Detail - Charizard"/>
</div>

<div align="center">
  <img src="screenshots/Simulator Screenshot - iPhone 11 - 2025-10-23 at 14.48.51.png" width="250" alt="Favorites Screen"/>
</div>

### Dark Mode

<div align="center">
  <img src="screenshots/Simulator Screenshot - iPhone 11 - 2025-10-23 at 14.49.22.png" width="250" alt="Home - Dark Mode"/>
  <img src="screenshots/Simulator Screenshot - iPhone 11 - 2025-10-23 at 14.49.26.png" width="250" alt="Pokemon Detail - Dark Mode"/>
  <img src="screenshots/Simulator Screenshot - iPhone 11 - 2025-10-23 at 14.49.30.png" width="250" alt="Favorites - Dark Mode"/>
</div>

<div align="center">
  <img src="screenshots/Simulator Screenshot - iPhone 11 - 2025-10-23 at 14.49.46.png" width="250" alt="Search Feature - Dark Mode"/>
</div>
## Features

- **Authentication**: Firebase Authentication with email/password
- **Pokemon List**: Paginated list of all Pokemon from PokéAPI
- **Search**: Real-time search Pokemon by name with debouncing
- **Pokemon Details**: Detailed view with stats, types, description, and images
- **Favorites**: Save and manage favorite Pokemon with local storage
- **Favorites View**: Dedicated screen to view all favorited Pokemon
- **Theme Support**: Dark and Light mode with persistent user preference
- **Cross-Platform**: Runs on Android, iOS, and Web

## Tech Stack

### Core Technologies
- **Flutter**: Latest stable version
- **Dart**: Programming language
- **PokéAPI**: RESTful API for Pokemon data

### Architecture
- **MVVM Pattern**: Clear separation between UI, business logic, and data layers
- **Repository Pattern**: Abstraction layer for data sources
- **Dependency Injection**: GetIt for service locator pattern
- **State Management**: Riverpod for reactive state management

### Dependencies
- `flutter_riverpod` - State management
- `get_it` - Dependency injection
- `firebase_core` & `firebase_auth` - Authentication
- `dio` - HTTP client for API calls
- `shared_preferences` - Local data persistence
- `json_annotation` & `json_serializable` - JSON serialization
- `dartz` - Functional programming utilities

## Project Structure

```
lib/
├── core/
│   ├── constants/       # API constants and app-wide constants
│   ├── errors/          # Error handling and failures
│   ├── network/         # Network configuration (Dio client)
│   └── utils/           # Utility functions
├── data/
│   ├── data_sources/    # Remote and local data sources
│   ├── models/          # Data models with JSON serialization
│   └── repositories/    # Repository implementations
├── domain/
│   ├── entities/        # Business entities
│   └── repositories/    # Repository interfaces
├── presentation/
│   ├── providers/       # Riverpod providers
│   ├── view_models/     # ViewModels for business logic
│   ├── views/           # UI screens
│   └── widgets/         # Reusable widgets
└── di/                  # Dependency injection setup
```

## Architectural Decisions

### MVVM Architecture
The app follows the Model-View-ViewModel (MVVM) pattern:
- **Model**: Domain entities and data models
- **View**: Flutter widgets in the presentation layer
- **ViewModel**: State management and business logic using Riverpod StateNotifiers

### Repository Pattern
- Abstracts data sources from the business logic
- Allows easy switching between remote and local data sources
- Implements the `Either` pattern for error handling using Dartz

### Dependency Injection
- Uses GetIt as a service locator for dependency injection
- All dependencies are registered at app startup
- Promotes testability and loose coupling

### State Management with Riverpod
- StateNotifierProvider for mutable state
- FutureProvider for async operations

## Setup Instructions

### Prerequisites
- Flutter SDK (latest stable version)
- Dart SDK
- A code editor (VS Code, Android Studio, or IntelliJ)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/MotebangMok/pokedex_app
   cd pokedex_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run code generation**
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```


4. **Run the app**
   ```bash
   # For development
   flutter run

   # For specific platform
   flutter run -d chrome        # Web
   flutter run -d android       # Android
   flutter run -d ios           # iOS (macOS only)
   ```

## Testing

### Run Unit Tests
```bash
flutter test test/data/repository
```

### Run All Tests
```bash
flutter test
```


## Features in Detail

### Authentication
- Email/password registration and login
- Firebase Authentication integration
- Persistent auth state
- Automatic navigation based on auth state

### Pokemon List
- Infinite scroll with pagination
- Grid layout with Pokemon thumbnails
- Pull-to-refresh functionality
- Efficient state management
- Real-time search bar with debouncing
- Search results displayed in same grid layout
- Clear button to exit search mode
- Empty state for no search results

### Pokemon Details
- High-quality Pokemon artwork
- Type indicators with color coding
- Base stats with progress bars
- Physical attributes (height, weight)
- Flavor text description from Pokemon species

### Favorites
- Add/remove favorites from detail view
- Dedicated favorites screen to view all favorited Pokemon
- Remove favorites with quick swipe action
- Local storage using SharedPreferences
- Per-user favorite management
- Visual indicators for favorited Pokemon
- Empty state with helpful prompts
- Pull-to-refresh in favorites view

### Theme Support
- System-wide dark/light theme toggle
- Persistent theme preference
- Smooth theme transitions
- Material 3 design

### Error Handling & Timeouts
- **30-second timeout** on all API requests
- Automatic loading indicator termination on timeout
- User-friendly error messages for network issues
- **Retry buttons** for failed requests
- Graceful handling of timeout scenarios
- Clear error states with helpful prompts

## API Integration

The app integrates with [PokéAPI](https://pokeapi.co/):
- `/pokemon` - List of all Pokemon
- `/pokemon/{id}` - Pokemon details
- `/pokemon-species/{id}` - Pokemon description

## License

All the code available under the MIT + Apache 2.0. licenses. See [LICENSE](LICENSE).

## Contact

For questions or issues, please contact the developer.
