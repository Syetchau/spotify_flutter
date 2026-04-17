# 🎵 Spotify Flutter Clone

A high-performance Spotify clone built with Flutter, demonstrating Clean Architecture, SOLID principles, and the BLoC/Cubit state management pattern.

As an Android developer transitioning to Flutter, this project serves as a practical implementation of professional-grade mobile architecture, mapping Android's ViewModel/Repository patterns to Flutter's ecosystem.

## 🏗️ Architecture Overview

This project follows **Clean Architecture**, ensuring a strict separation of concerns:

- **Presentation Layer**: Handled by BLoC/Cubit. This acts as the ViewModel, managing UI logic and emitting immutable states.
- **Domain Layer**: Contains the Business Logic. It defines UseCases and Entities, ensuring the core logic is independent of external frameworks.
- **Data Layer**: Implements Repositories. It manages data flow from Firebase (Remote) and local sources using the Repository Pattern.

## 🛠️ Tech Stack & Dependencies

| Category                   | Tools / Packages                          |
|:---------------------------|:------------------------------------------|
| **Language**               | [Dart](https://dart.dev/)                 |
| **Framework**              | [Flutter](https://flutter.dev/)           |
| **State Management**       | `flutter_bloc`, `hydrated_bloc`           |
| **Service Locator**        | `get_it` (Dependency Injection)           |
| **Functional Programming** | `dartz` (Either type for Error Handling)  |
| **Backend**                | `firebase_core`, `firebase_auth`          |
| **Authentication**         | `google_sign_in`, `flutter_facebook_auth` |
| **Storage**                | `path_provider`                           |
| **UI/UX**                  | `flutter_svg`, Custom Satoshi Fonts       |

## 🚀 Key Features Applied

- **Clean UI**: Responsive design with custom theme support.
- **Auth Flow**: Production-grade Sign Up/Sign In using Firebase Auth.
- **Defensive UI**: Implementation of Throttling on action buttons to prevent double-execution.
- **Immutable States**: Predictable UI updates using BLoC state management.
- **Global Error Handling**: Leveraging the `Either` type to handle exceptions gracefully in the UI.

## 📂 Project Structure

```text
lib/
├── common/              # Shared assets across multiple features
│   ├── helpers/         # Logic helpers (Extensions, formatters)
│   └── widgets/         # Reusable UI components (Buttons, AppBars)
├── core/                # App-wide configurations and base logic
│   ├── configs/         # Theme data and asset constants (Vectors, Images)
│   └── usecase/         # Base UseCase interface definition
├── data/                # Data layer (Implementation)
│   ├── models/          # Data Transfer Objects (DTOs) & JSON parsing
│   ├── repositoryImpl/  # Concrete implementations of repositories
│   └── sources/         # Remote (Firebase) & Local data sources
├── domain/              # Domain layer (Business Logic)
│   ├── entities/        # Plain Dart objects (Business Models)
│   ├── repository/      # Repository interfaces (Abstract classes)
│   └── usecases/        # Specific application business rules
├── presentation/        # Presentation layer (UI & State Management)
│   ├── auth/            # Authentication feature (Sign In, Sign Up pages)
│   ├── choose_mode/     # Light/Dark mode selection
│   ├── intro/           # Onboarding/Get Started screens
│   ├── splash/          # Startup splash screen
│   └── root/            # Main application shell
└── service/             # Infrastructure services
    └── service_locator.dart # Dependency Injection setup (GetIt)
```
## ⚙️ Setup & Installation
Follow these steps to get the development environment running locally:

### 1. Clone the Repository
```bash
git clone https://github.com/Syetchau/spotify_flutter.git
```

### 2. Install Dependencies
```bash
flutter pub get
```

### 3. Firebase Configuration
This project requires Firebase. You need to set up your own Firebase project and add the configuration files:

- Android: Place google-services.json in android/app/

- iOS: Place GoogleService-Info.plist in ios/Runner/

- Flutter: Place firebase_options.dart in lib/firebase_options.dart if the file not auto generated

Alternatively, use the FlutterFire CLI:

```bash
flutterfire configure
```

### 4. Run the Application

```bash
# To run on a connected device or emulator
flutter run

# To run in Release mode (performance testing)
flutter run --release
```

## 🧠 Learning Objectives (Android Dev Perspective)
Mapping ViewModel logic to Cubit.

Understanding the Widget Lifecycle vs Android Fragments.

Implementing Unidirectional Data Flow in a multi-platform environment.

Using GetIt as a lightweight alternative to Dagger/Hilt.