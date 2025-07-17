# FusionCards - Nearby Merchants App

An interactive Flutter application that:

* 🌍 Detects the user’s current location
* 🏙️ Reverse geocodes to display the city/state
* 🛠️ Fetches nearby merchants via Foursquare Places API
* 📍 Shows the user’s location and merchant markers on an OpenStreetMap
* 📋 Presents merchant details in a swipeable bottom sheet with map-center functionality

---

## Demo

https://youtube.com/shorts/ofnrqrLseaY?si=uG5AqU6PBZrZaTZ_

---

## Features

* **Location Detection**: Uses `geolocator` to fetch GPS coordinates
* **Reverse Geocoding**: Uses OpenStreetMap’s Nominatim API to get city/state
* **Places Search**: Integrates Foursquare v3 Places API (search endpoint) to list merchant name, category, distance, and address
* **Map View**: Renders OpenStreetMap tiles via `flutter_map`, with a blue user marker and red merchant markers
* **Interactive Bottom Sheet**: Swipeable sheet showing merchants; tapping the sheet’s map pin icon pans/zooms the map to that merchant’s location
* **Pull Bar Indicator**: Visual cue that the bottom sheet is draggable

---

## Tech Stack & Tools

* **Flutter & Dart** for cross-platform UI
* **flutter\_map + latlong2** for OpenStreetMap integration
* **geolocator** for location services
* **http** for network requests (Nominatim & Foursquare APIs)
* **permission\_handler** for runtime permission management
* **VS Code / Android Studio** as IDE
* **Android Emulator / Physical Device** for testing

### AI & Productivity Tools

* **ChatGPT (o4-mini)** for architecture guidance, code scaffolding, and debugging support
* **Gemini** for inline code suggestions in Android Studio

---

## Getting Started

### Prerequisites

* Flutter SDK (>= 3.0)
* An API key from [Foursquare Places](https://developer.foursquare.com/) (Bearer API Key, v3)
* Android Studio or VS Code

### Installation & Setup

1. **Clone the repo**

   ```bash
   git clone https://github.com/mchkbalaji/find-merchants-app.git
   cd find-merchants-app-master
   ```

2. **Add your Foursquare API Key**

    * Create a file in the lib folder named 'secrets.dart'
    * Add:

      ```dotenv
      String SECRET_BEARER_KEY='Bearer FOURSQUARE_BEARER_KEY';
      ```
    * This file is ignored by Git (`.gitignore` includes `secrets.dart`).

3. **Install dependencies**

   ```bash
   flutter pub get
   ```

4. **Run the app**

   ```bash
   flutter run
   ```

    * Select your emulator or connected device.

5. **Grant location permission** when prompted.

---

## Project Structure

```
lib/
├── main.dart                 # Entry point, theme setup
├── secrets.dart              # Stores API key
├── models/
│   └── merchant.dart         # Merchant data model with lat/lng
├── screens/
│   ├── home_screen.dart      # Permission request screen
│   └── map_screen.dart       # Map + API integration + bottom sheet
├── widgets/
│   └── merchant_bottom_sheet.dart  # Draggable merchant list
└── pubspec.yaml
```

---

## Future Improvements

* Caching map tiles or using a paid tile provider (MapTiler)
* Dark mode theming
* Detailed merchant view with photos & reviews
* Category filters or search within results

---

*Thank you for this opportunity!* 🎈
