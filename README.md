# 📱 **Film Space**

*A clean and fast Flutter app to explore movie information powered by TMDB.*

Film Space is a lightweight movie browser that helps users discover trending movies, view cast details, genres, ratings, posters, and full movie descriptions. Built using Flutter, TMDB API, Bloc, and optimized image caching for smooth performance.

---

## 🚀 **Features**

* 🎬 Browse **trending movies**
* 🔍 Fast **search** with debounce
* 📝 View **movie details**
* 👥 Explore **full cast profiles**
* 🖼 Cached posters (high performance)
* 🌗 **Light & Dark theme** support
* ⚡ Smooth slide animations for navigation
* 📄 API-secured using **`.env`** variables

---

## 📦 **Tech Stack**

* **Flutter** (3.x)
* **Dio** for API calls
* **Bloc** State Management
* **TMDB API**
* **Cached Network Image**
* **Shimmer** placeholder loaders
* **Environment Variables** using `flutter_dotenv`

---

## 🔐 **Environment Setup (`.env`)**

This project uses an `.env` file to store your **TMDB API Key** securely.

### 📌 Step 1 — Create a `.env` file in the root of your Flutter project:

```
/moviedetails
  ├── lib/
  ├── android/
  ├── ios/
  ├── .env   ← create this file here
  └── pubspec.yaml
```

### 📌 Step 2 — Add your TMDB API key inside `.env`:

```env
TMDB_API_KEY=your_tmdb_api_key_here
TMDB_READ_ACCESS_TOKEN=your_read_access_token
```

### 📌 Step 3 — Load the `.env` in `main.dart`:

```dart
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(MovieApp());
}
```

---

## 🎯 **How to Get Your TMDB API Key**

1. Go to: [https://www.themoviedb.org/signup](https://www.themoviedb.org/signup)
2. Create an account
3. Navigate to:
   **Settings → API → Request an API Key**
4. Choose **Developer API**
5. Copy your **API Read Access Token** and **API v3 Key**
6. Paste it into your `.env`:

```env
TMDB_API_KEY=your_tmdb_api_key_here
TMDB_READ_ACCESS_TOKEN=your_read_access_token
```

---

## 🛠 **Running the App**

### Install dependencies:

```
flutter pub get
```

### Run the app:

```
flutter run
```

---

## 🧪 **Build Release APK**

### Android APK:

```
flutter build apk --release
```

### App Bundle (Play Store):

```
flutter build appbundle
```

---

## 📂 **Project Structure**

```
lib/
 ├── blocs/
 ├── models/
 ├── repos/
 ├── screens/
 ├── service/
 ├── core/
 └── main.dart

assets/
 ├── fonts/
 └── filmspace.png

.env
pubspec.yaml
```

---

## 🖼 **Screenshots (optional)**

(Add your screenshots later)

```
/screenshots
  screen1.png
  screen2.png
  screen3.png
```

---

## 📘 **API Reference**

This app uses **TMDB API**:
[https://developer.themoviedb.org/reference/intro/getting-started](https://developer.themoviedb.org/reference/intro/getting-started)

---

## 🙌 **Author**

Developed by **Sai Venkat**
Feel free to open issues or suggest improvements.

---
