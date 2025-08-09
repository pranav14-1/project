## Project Structure

This is the main structure of the `lib` folder, containing all the application's Dart source code.

```
lib/
├── main.dart
├── screens/
│   ├── signin.dart
│   ├── signup.dart
│   ├── splash_screen.dart
│   └── home/
│       ├── home_screen.dart           (Main container)
│       ├── home_content.dart          (Home tab content)
│       ├── location_content.dart      (Location tab)
│       ├── attendance_content.dart    (Attendance tab)
│       ├── work_activity_content.dart (Work Activity tab)
│       └── profile_content.dart       (Profile tab)
└── utils/
    ├── page_transitions.dart        (Manages the transition of between app screens)
    └── shimmer_widgets.dart         (Provides reusable loading animation widgets)
```
```

