# 📝 NeoAssessment – Online Assessment Management System

NeoAssessment is a **cross-platform online assessment and examination management system** built using **Flutter** and **BLoC architecture**.  
The application enables administrators to manage **domains, levels, question categories, candidates, exams, and exam assignments** from a single platform.

---

## 🚀 Features

### 📚 Domain Management
- Create, update, delete, and list domains
- Domain-based filtering across exams and candidates

### 📊 Level Management
- Manage difficulty/experience levels
- Used for exam creation and filtering

### 🗂 Question Category Management
- Create and manage question categories
- Map categories to domains

### 📝 Exam Management
- Create exams with:
  - Domain
  - Level
  - Question Category
  - Passing Score
- Select multiple questions dynamically
- Filter questions in real-time
- View exam details in modal view
- Delete exams

### 👤 Candidate Management
- Create, update, and delete candidates
- Assign domain and experience
- Password validation and date picker support

### 🎯 Exam Assignment
- Assign exams to candidates
- Filter exams based on candidate domain and level
- Track assigned exams

---

## 🧱 Project Architecture

The project follows a **Clean Architecture + BLoC pattern**:
``` text

lib/
├── data/
│ ├── datasources/
│ ├── models/
│ └── repositories/
│
├── domain/
│ ├── entities/
│ ├── repositories/
│ └── usecases/
│
├── presentation/
│ ├── bloc/
│ ├── pages/
│ └── widgets/
│
└── main.dart
```

### 🔄 State Management Flow

UI → Event → BLoC → Repository → State → UI


- Business logic is isolated inside BLoCs
- UI reacts to state changes only
- No direct API calls from UI layer

---

## 🛠 Tech Stack

| Technology | Purpose |
|----------|--------|
| Flutter | Cross-platform UI |
| Dart | Programming language |
| flutter_bloc | State management |
| Equatable | State comparison |
| REST API | Backend communication |
| Material UI | UI components |

---

## 📱 Screens Implemented

- Domain Management
- Level Management
- Question Category Management
- Exam Creation & Listing
- Exam Detail Modal
- Exam Assignment
- Candidate Management

---

## ✅ Form Validation & UX

- All forms use `Form` + `GlobalKey<FormState>`
- Input validation before API calls
- Snackbar feedback for:
  - Success
  - Errors
  - Deletion confirmation
- Modal-based CRUD operations for better UX

---

## 🔐 Security & Best Practices

- Password validation enforced
- No sensitive logic in UI layer
- Controlled state updates via BLoC
- Clean and modular code structure

---

## ▶️ Getting Started

### Prerequisites
- Flutter SDK (latest stable)
- Dart SDK
- Android Studio / VS Code

### Installation

```bash
git clone https://github.com/<your-username>/neoassessment_flutter.git
cd neoassessment_flutter
flutter pub get
flutter run


### 📌 Future Enhancements
- Role-based access control
- Exam result evaluation
- Candidate performance analytics
- Pagination and search
- Offline caching
- Admin dashboard charts
```


🧑‍💻 Author

Abhay Kapadnis
Flutter Developer
📱 Cross-platform Application Development
📦 BLoC • Clean Architecture • REST APIs
