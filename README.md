# instaClass

> A Flutter-based e‑learning app offering on‑demand video courses for all grade levels, with secure user authentication and Firebase back‑end.

[![Flutter](https://img.shields.io/badge/Flutter-3.x-blue.svg)](https://flutter.dev)  
[![Firebase](https://img.shields.io/badge/Firebase-Auth%20%7C%20Firestore-orange.svg)](https://firebase.google.com)  
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

---

## 🚀 App Overview

`instaClass` lets students:
- **Browse & subscribe** to grade‑specific courses  
- **Watch** YouTube‑hosted lessons inside the app  
- **Sign up**, **login**, **reset password** (via Firebase Auth)  
- **Purchase** course access via redeemable codes (coming soon)  
- **Save notes** per lesson (coming soon)

Built with Flutter & Firebase, it’s designed to be easily extendable and performant on iOS, Android, Web, desktop and Linux.

---

## ⭐ Key Features

| Feature                     | Status       |
|-----------------------------|--------------|
| User Authentication (email) | ✅ Complete  |
| Forgot / Reset Password     | ✅ Complete  |
| Course Catalog & Filters    | ✅ Complete  |
| In‑app YouTube Playback     | ✅ Complete  |
| Subscription via Code       | 🔜 Planned   |
| Notes per Lesson            | 🔜 Planned   |
| Multi‑language (i18n)       | 🔄 In progress |

---

## 🏛 Architecture

This project follows an **MVVM‑style** structure:
lib/
├── screens/ # UI pages (View)
├── services/ # Firebase & API clients (Model)
├── view_models/ # Business logic & state (ViewModel)
├── widgets/ # Reusable UI components
└── utils/ # Themes, colors, helpers

Each screen listens to its ViewModel via `ChangeNotifier`, and ViewModels call `auth_service`, `data_from_firestore_servers`, etc.

---

## 📂 Project Structure

ib/
├── main.dart
├── screens/
│ ├── auth/ # login, signup, forgot_password
│ └── courses_page.dart
├── services/ # auth_service.dart, firestore & REST connectors
├── view_models/ # auth_viewmodel.dart, data_from_firestore_view_model.dart…
├── widgets/ # custom_app_bar, button_style_app, CoursesGridWidget…
├── utils/ # app_colors.dart, localization_view_model.dart…
└── translations/ # ar.json, en.json

---

## ⚙️ Tech Stack

- **Flutter** (Dart)  
- **Firebase**: Auth, Firestore, Cloud Functions  
- **Localization**: JSON‑based (en/ar)  
- **State Management**: `ChangeNotifier` / MVVM  
- **YouTube Playback**: `youtube_player_flutter`  
- **Platform Support**: iOS, Android, Web, macOS, Windows, Linux

---

## 🛠 Getting Started

1. **Clone this repo**  
   ```bash
   git clone git@github.com:your-username/instaClass.git

