# 📝 Notes App

A feature-rich Notes Application built with **Flutter and Dart**, using **SQLite (sqflite)** for local data storage and **Provider** for state management.

The application follows a layered architecture to keep the code organized, maintainable, and easy to understand. It also includes random quote fetching through a REST API and persistent theme preferences.

## ✨ Features

### 🗒️ Notes Management (CRUD)
- Create new notes with title, content, and category.
- View all saved notes.
- Edit existing notes.
- Delete individual notes.
- Delete all notes at once.

### 🔍 Search & Organization
- Search notes by title.
- Filter notes by category.
- Pin and unpin important notes.
- Sort notes by newest or oldest.
- Archive and unarchive notes.

### 🎨 Theme Customization
- Light mode and dark mode.
- Save theme preferences using SharedPreferences.
- Maintain the selected theme after restarting the application.

### 💬 Random Quotes
- Fetch random quotes from the DummyJSON API.
- Display quotes at the top of the home screen.
- Refresh quotes through API requests.

### 🧩 Reusable Components & Utilities
- Reusable widgets to reduce code duplication.
- Separate utilities for common helper functionality.
- Organized code for better maintainability and reusability.

## 📱 Application Screens

The application consists of **5 screens**, providing an organized user experience for managing notes and application settings.

## 🏗️ Project Architecture

The application follows a layered architecture:

```text
          UI Layer
     (Screens & Widgets)
             |
             v
        Provider Layer
      (State Management)
             |
             v
       Repository Layer
       (Data Operations)
             |
             v
      Database Service
             |
             v
          SQLite
```

### Architecture Overview

- **UI Layer:** Handles the application's screens, widgets, and user interactions.
- **Provider Layer:** Manages application state using ChangeNotifier, including loading states, errors, searching, filtering, sorting, and note operations.
- **Repository Layer:** Acts as an intermediary between the Provider and Database Service.
- **Database Service:** Handles SQLite initialization and database operations.
- **SharedPreferences:** Stores user theme preferences locally.
- **API Integration:** Fetches random quotes from DummyJSON.

## 🛠️ Technologies & Packages

| Technology | Purpose |
|---|---|
| Flutter & Dart | Application development |
| SQLite (sqflite) | Local database |
| Provider | State management |
| Repository Pattern | Separation of data operations |
| SharedPreferences | Persistent theme preferences |
| HTTP | REST API communication |
| DummyJSON API | Random quote fetching |
| Path | Database path management |

## 🌐 API Integration

The application uses the DummyJSON random quotes endpoint:

[DummyJSON Random Quotes API](https://dummyjson.com/quotes/random)

## 📁 Project Structure

```text
lib/
│
├── models/
│   └── note.dart
│
├── providers/
│   ├── notes_provider.dart
│   ├── quote_provider.dart
│   └── theme_provider.dart
│
├── repositories/
│   └── notes_repo.dart
│
├── db/
│   └── database_service.dart
│
├── screens/
│   ├── (application screens)
│
├── widgets/
│   └── (reusable widgets)
│
├── utils/
│   └── (utility files)
│
└── main.dart
```

*The structure is illustrative. Update folder and file names according to the actual project.*

## 🚀 Getting Started

### Prerequisites

- Flutter SDK
- Dart SDK
- Android Studio or Visual Studio Code

### Installation

**1. Clone the repository**

```bash
git clone YOUR_REPOSITORY_URL
```

**2. Navigate to the project directory**

```bash
cd notes_app
```

**3. Install dependencies**

```bash
flutter pub get
```

**4. Run the application**

```bash
flutter run
```

## 🎯 Project Objectives

This project was developed to gain practical experience in Flutter development and understand how to build a structured application using:

- State management with Provider.
- Local database integration using SQLite.
- CRUD operations and data organization.
- Repository pattern and layered architecture.
- REST API integration.
- Persistent local storage.
- Reusable widgets and utility functions.
- Light and dark theme implementation.

---

**Developed with Flutter**