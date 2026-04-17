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

### 📋 Prerequisites
- Flutter SDK: `>=3.0.0`
- Dart SDK: `>=3.0.0`
- Java: `17` (Recommended for Android builds)
- CocoaPods: Latest version (For iOS)

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
### 4. Google & Facebook Sign-In Configuration

To enable social authentication, native configuration is required for both platforms.

#### 🟢 Google Sign-In

- **Firebase Console**: Enable **Google** as a Sign-in provider.

- **Android**:

    - Generate your **Debug SHA-1**:
      ```bash
      keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android
      ```
      
    - Add the SHA-1 to your **Firebase Project Settings**.
  
    - Download and place `google-services.json` in `android/app/`.
  
- **iOS**:
    - Locate `REVERSED_CLIENT_ID` in `GoogleService-Info.plist`.
  
    - Add it to `ios/Runner/Info.plist`:
  
      ```xml
      <key>CFBundleURLTypes</key>
      <array>
          <dict>
              <key>CFBundleTypeRole</key>
              <string>Editor</string>
              <key>CFBundleURLSchemes</key>
              <array>
                  <string>YOUR_REVERSED_CLIENT_ID_HERE</string>
              </array>
          </dict>
      </array>
      ```

#### 🔵 Facebook Sign-In

- **Meta for Developers**: Create an app and obtain your **App ID** and **Client Token** at the [Meta Developers Portal](https://developers.facebook.com/).

- **Firebase Console**: 

    - Enable **Facebook** in the Auth providers list.
  
    - Enter your **App ID** and **App Secret** (found in your Meta App settings).
  
    - **Crucial**: Copy the **OAuth redirect URI** provided by Firebase (e.g., `https://your-project-id.firebaseapp.com/__/auth/handler`) and paste it into your [Meta Developers Portal](https://developers.facebook.com/) under **Facebook Login > Settings > Valid OAuth Redirect URIs**.

- **Android**:

    - Add these to `android/app/src/main/res/values/strings.xml`:
  
      ```xml
      <string name="facebook_app_id">YOUR_APP_ID</string>
      <string name="fb_login_protocol_scheme">fbYOUR_APP_ID</string>
      <string name="facebook_client_token">YOUR_CLIENT_TOKEN</string>
      ```
      
    - Add this inside the `<application>` tag in `AndroidManifest.xml`:
  
      ```xml
      <meta-data android:name="com.facebook.sdk.ApplicationId" android:value="@string/facebook_app_id"/>
      <meta-data android:name="com.facebook.sdk.ClientToken" android:value="@string/facebook_client_token"/>
  
      <activity android:name="com.facebook.FacebookActivity"
          android:configChanges="keyboard|keyboardHidden|screenLayout|screenSize|orientation"
          android:label="@string/app_name" />
      <activity
          android:name="com.facebook.CustomTabActivity"
          android:exported="true">
          <intent-filter>
              <action android:name="android.intent.action.VIEW" />
              <category android:name="android.intent.category.DEFAULT" />
              <category android:name="android.intent.category.BROWSABLE" />
              <data android:scheme="@string/fb_login_protocol_scheme" />
          </intent-filter>
      </activity>
      ```

- **iOS**:
    - Open `ios/Runner/Info.plist` and add the following entries (replace `YOUR_APP_ID`, `YOUR_CLIENT_TOKEN`, and `YOUR_APP_NAME` with your actual Meta Developer credentials):
      ```xml
      <key>CFBundleURLTypes</key>
      <array>
        <dict>
          <key>CFBundleURLSchemes</key>
          <array>
            <string>fbYOUR_APP_ID</string>
          </array>
        </dict>
      </array>
      <key>FacebookAppID</key>
      <string>YOUR_APP_ID</string>
      <key>FacebookClientToken</key>
      <string>YOUR_CLIENT_TOKEN</string>
      <key>FacebookDisplayName</key>
      <string>YOUR_APP_NAME</string>
      <key>LSApplicationQueriesSchemes</key>
      <array>
        <string>fbapi</string>
        <string>fb-messenger-share-api</string>
      </array>
      ```

### 5. Run the Application

```bash
# To run on a connected device or emulator
flutter run

# To run in Release mode (performance testing)
flutter run --release
```

## 🧠 Architecture Mapping (Android vs. Flutter)

| Category                 | Android (Native) | Flutter (This Project)        |
|:-------------------------|:-----------------|:------------------------------|
| **Logic & State**        | ViewModel        | Cubit / BLoC                  |
| **Reactive UI**          | LiveData / Flow  | Streams / States              |
| **Dependency Injection** | Dagger / Hilt    | GetIt                         |
| **Networking**           | Retrofit         | Dio / Http                    |
| **Persistence**          | Room             | Path Provider / Hydrated BLoC |

## 🤝 Contributing

Contributions are what make the open-source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📜 License

![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)

Distributed under the **MIT License**. See [LICENSE](./LICENSE) for more information.

## ✉️ Contact

**Liew Syet Chau** - [LinkedIn](https://www.linkedin.com/in/liew-syet-chau-8b2a45186/) - syetchau@gmail.com 

Project Link: [https://github.com/Syetchau/spotify_flutter](https://github.com/Syetchau/spotify_flutter)