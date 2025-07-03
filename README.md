# User List Flutter App

A Flutter application that displays a paginated list of employees fetched from a mock API. Users can tap on an employee to view their details and the last opened employee is saved locally and displayed at the top of the list.

---

## 🏗 Features

- 🔄 Fetches employee data from a mock API.
- 📜 Paginated ListView with 10 items per page.
- 💾 Remembers the last opened employee using shared_preferences.
- 📱 Responsive UI across devices.
- 🔄 Pull-to-refresh and infinite scroll.
- 🔐 Basic error handling (No internet, API errors, empty lists).
- 📦 Clean architecture with separation of concerns.

---

## 📲 Screens

### 🏠 Home Screen
- Fetches data from: https://fake-json-api.mock.beeceptor.com/users?_page=1&_limit=10
- Shows paginated list of employee names.
- Displays loading indicators while fetching.
- Handles errors with user-friendly messages.
- Displays last opened employee (if any) at the top of the list.

### 👤 Details Screen
- On tapping an employee, navigates to a new screen.
- Shows the selected employee’s name.
- Placeholder description: This is [Employee Name].
- Saves the selected employee to shared_preferences.

---

## 📦 Tech Stack

- *Flutter*
- *http* (for API calls)
- *shared_preferences* (for local persistence)

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK
- Dart SDK
- Android Studio / VS Code

### Installation

```bash
git clone https://github.com/your-username/employee-directory-app.git
cd employee-directory-app
flutter pub get
flutter run
