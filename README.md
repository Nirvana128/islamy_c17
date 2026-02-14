# Islami App

**Islami** is a comprehensive Flutter application designed to assist Muslims in their daily spiritual routine. The app provides accurate prayer times, live Quran radio streaming, and a collection of daily Azkar, all wrapped in a modern and elegant user interface.

---

##  Key Features

###  1. Prayer Times & Dates (Time Tab)
* **Accurate Timing:** Fetches real-time prayer schedules (Fajr, Dhuhr, Asr, Maghrib, Isha) based on location (Cairo, Egypt by default).
* **Dual Date Display:** Shows both Hijri and Gregorian dates in a custom-styled header.
* **Next Prayer Countdown:** Highlights the upcoming prayer and the time remaining.
* **Custom UI:** Features a unique golden gradient design with a wavy header.

###  2. Quran Radio & Reciters (Radio Tab)
* **Live Radio:** Stream various Islamic radio stations directly within the app.
* **Reciters List:** Access a curated list of famous Quran reciters.
* **Audio Controls:** Integrated audio player to Play, Pause, and Stop streams seamlessly.

###  3. Azkar (Supplications)
* **Categorized Access:** organized sections for Morning, Evening, Waking up, and Sleeping Azkar.
* **Grid Layout:** A clean grid view for easy navigation between different Azkar categories.

---

## Tech Stack

This project is built using:
* **Framework:** Flutter (Dart)
* **Networking:** `http` package for API integration.
* **Audio:** `audioplayers` package for streaming audio content.
* **UI Components:** Custom `ClipRRect`, `LinearGradient`, `Stack`, and `GridView`.

---

##  APIs Used

The application relies on the following public APIs for data:

1.  **Prayer Times:** [Aladhan API](https://aladhan.com/prayer-times-api)
    * Used to fetch daily timings and Hijri dates.
2.  **Radio & Reciters:** [Mp3Quran API](https://mp3quran.net/api/v3/)
    * Used to fetch radio station URLs and Reciter audio streams.

---

##  Getting Started

To run this project on your local machine, follow these steps:

1.  **Clone the repository:**
    ```bash
    git clone [https://github.com/your-username/islami-app.git](https://github.com/your-username/islami-app.git)
    ```

2.  **Navigate to the project directory:**
    ```bash
    cd islami-app
    ```

3.  **Install dependencies:**
    ```bash
    flutter pub get
    ```

4.  **Run the app:**
    ```bash
    flutter run
    ```

---

##  Project Structure

A brief overview of the main folders:

* `lib/api/`: Contains `ApiManager` for handling HTTP requests.
* `lib/models/`: Data models for parsing JSON (Radio, PrayerTime, etc.).
* `lib/screens/`: UI screens including `TimeTab`, `RadioTab`, and `Home`.
* `lib/theme/`: App colors and theme configurations.

---

##  Author

**Nova**
* Programmer & AI Engineer

---

 **Star this repo if you find it useful!**

