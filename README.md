<p align="center">
  <img src="https://img.shields.io/badge/Flutter-3.11-02569B?logo=flutter&logoColor=white" alt="Flutter">
  <img src="https://img.shields.io/badge/Dart-3.11-0175C2?logo=dart&logoColor=white" alt="Dart">
  <img src="https://img.shields.io/badge/Material_3-Enabled-681B98" alt="Material 3">
  <img src="https://img.shields.io/badge/Platform-Android-3DDC84?logo=android&logoColor=white" alt="Android">
  <img src="https://img.shields.io/badge/License-MIT-green" alt="License">
  <img src="https://img.shields.io/badge/Version-2.4.0-blue" alt="Version">
</p>

<h1 align="center">📚 EduApp</h1>
<h3 align="center">Inclusive Learning Platform for Blind & Deaf Students</h3>

<p align="center">
  A Flutter mobile application designed to make education accessible for <b>blind and deaf students</b> from Class 1 to Class 9, featuring audio lessons with TTS, video lessons with live captions, interactive quizzes, and comprehensive accessibility support.
</p>

<p align="center">
  <a href="https://stitch.withgoogle.com/projects/849892866353914343">🎨 View Design on Google Stitch</a>
</p>

---

## ✨ Features

### 🎯 Core Learning
- **9 Class Levels** — Class 1 through Class 9 with colorful gradient cards
- **4 Subjects** — English, Mathematics, Science, Balbharti with progress tracking
- **Audio Lessons** — Large play button, audio visualizer, playback speed control (0.5x–2.0x)
- **Video Lessons** — Video player with live captions, volume control, fullscreen, key visual concept cards
- **Interactive Quizzes** — Timed questions with image support, A/B/C/D options, progress tracking

### ♿ Accessibility (Built-In)
- **Audio Mode (Blind Users)** — Text-to-speech via `flutter_tts`, every button speaks its label on tap
- **Video Mode (Deaf Users)** — Always-on captions, highlighted keywords, visual concept cards, gesture guide
- **TalkBack Support** — Screen reader optimized with `Semantics` on every interactive element
- **High Contrast Mode** — Enhanced visual clarity toggle
- **Large Text Mode** — 1.3x text scaling across the entire app
- **Haptic Feedback** — Vibration on every interaction
- **Large Tap Areas** — Minimum 48dp touch targets

### 👤 Gamification & Progress
- **XP System** — Earn experience points for completing lessons
- **Daily Streaks** — Track consecutive learning days
- **Achievements** — Fast Learner, Quiz Master, 7-Day Hero badges
- **Daily Challenges** — Bonus XP for completing extra tasks
- **Profile** — Level badge, XP progress bar, achievement showcase

### ⚙️ Customization
- **Dark Mode** — Full dark theme support
- **Language Selector** — Multi-language ready
- **Notification Controls** — Daily reminder toggles
- **Sign Out** — Account management

---

## 📱 Screens

| Screen | Description |
|--------|-------------|
| **Splash** | Purple-blue gradient, education icon, loading indicator, auto-navigation |
| **Learning Mode** | Choose Audio Mode (blind) or Video Mode (deaf) |
| **Home** | Welcome header, 3×3 class grid, Ask AI FAB, bottom navigation |
| **Subjects** | Subject cards with icons, progress bars, completion percentages |
| **Video Lesson** | Video player with captions, visual key points, bookmark, gesture guide |
| **Audio Lesson** | Circular play button with pulse animation, visualizer, speed slider |
| **Quiz** | Timer, progress bar, image questions, highlighted option selection |
| **Profile** | Avatar, level badge, XP bar, streak card, achievements, daily challenge |
| **Settings** | 4 accessibility toggles, language, notifications, dark mode, sign out |

---

## 🏗️ Architecture

```
lib/
├── main.dart                              # App entry, MultiProvider, routes
├── core/
│   ├── accessibility/
│   │   └── accessibility_provider.dart    # TTS, learning mode, a11y toggles
│   ├── constants/
│   │   ├── app_constants.dart             # App config & preference keys
│   │   └── app_routes.dart                # Named route constants
│   ├── theme/
│   │   ├── app_colors.dart                # Colors & gradients from Stitch design
│   │   └── app_theme.dart                 # Material 3 light/dark themes
│   └── utils/
│       └── settings_provider.dart         # Dark mode, notifications, language
├── features/
│   ├── splash/                            # Splash screen
│   ├── learning_mode/                     # Audio/Video mode selector
│   ├── home/                              # Home with class grid
│   ├── subjects/                          # Subject list with progress
│   ├── video_player/                      # Video lesson (deaf mode)
│   ├── audio_player/                      # Audio lesson (blind mode)
│   ├── quizzes/                           # Quiz system
│   ├── profile/                           # User profile & gamification
│   └── settings/                          # App settings
└── widgets/
    ├── accessibility_widgets/             # SemanticWrapper, SpeakOnTap
    ├── buttons/                           # AccessibleIconButton, PrimaryButton
    ├── cards/                             # GradientCard, SubjectCard
    ├── navigation/                        # BottomNavBar
    └── progress_components/               # QuizProgress, XpProgressBar
```

**Design Principles:**
- **Clean Architecture** — Feature-based folder structure
- **Reusable Widgets** — 10 shared components with accessibility built-in
- **State Management** — Provider with `ChangeNotifier`
- **Named Routes** — 9 declarative routes
- **Responsive Layout** — Adaptive grids and flexible layouts

---

## 🛠️ Tech Stack

| Technology | Purpose |
|-----------|---------|
| **Flutter 3.11** | Cross-platform UI framework |
| **Dart 3.11** | Programming language |
| **Material 3** | Design system |
| **Provider 6.1** | State management |
| **flutter_tts 4.2** | Text-to-speech for blind users |
| **video_player 2.9** | Video lesson playback |
| **audioplayers 6.1** | Audio lesson playback |
| **shared_preferences 2.3** | Persistent local storage |
| **google_fonts 6.2** | Inter font (matches Stitch design) |

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK 3.11+
- Android Studio / VS Code
- Android device or emulator

### Installation

```bash
# Clone the repository
git clone https://github.com/Pranav0931/EDUAPPv2.git
cd EDUAPPv2

# Install dependencies
flutter pub get

# Run on connected device
flutter run

# Build release APK
flutter build apk --release
```

### Verify Setup

```bash
flutter doctor    # Check environment
flutter analyze   # Zero issues ✅
```

---

## 🎨 Design Reference

The UI was designed in **Google Stitch** and faithfully replicated in Flutter.

| Design Token | Value |
|-------------|-------|
| Primary Color | `#681B98` |
| Secondary Color | `#4A90D9` |
| Font | Inter (Google Fonts) |
| Border Radius | 12px |
| Theme | Material 3, Light + Dark |

**[View Full Design →](https://stitch.withgoogle.com/projects/849892866353914343)**

---

## 🗺️ Routing

| Route | Screen |
|-------|--------|
| `/` | Splash Screen |
| `/learningMode` | Learning Mode Selection |
| `/home` | Home Screen |
| `/subjects` | Subjects Screen |
| `/lessonVideo` | Video Lesson (Deaf Mode) |
| `/lessonAudio` | Audio Lesson (Blind Mode) |
| `/quiz` | Quiz Screen |
| `/profile` | Profile Screen |
| `/settings` | Settings Screen |

---

## ♿ Accessibility Compliance

### Blind Mode
- Every interactive element wrapped in `Semantics(label: ..., button: true)`
- `flutter_tts` speaks labels on tap — class names, subjects, quiz answers, navigation
- Speed-adjustable audio playback (0.5x–2.0x)
- Haptic feedback on every interaction

### Deaf Mode
- Live captions always visible during video lessons
- Key visual concept cards with icons and descriptions
- Highlighted keywords in caption text
- Gesture guide: swipe to change concept, double-tap to bookmark, two-finger tap to toggle captions

### Universal
- Large tap targets (minimum 48dp)
- High contrast mode toggle
- Large text mode (1.3x scaling)
- Dark mode support
- Semantic labels on all UI elements

---

## 📄 License

This project is licensed under the MIT License.

---

<p align="center">
  Made with ❤️ for inclusive education<br>
  <b>EduApp v2.4.0</b>
</p>

---

## What's Next (Upcoming Work)

### Phase 6: Real Data & Backend Integration
- [ ] Connect actual video files via `video_player`
- [ ] Connect actual audio files via `audioplayers`
- [ ] Quiz data from JSON/API (not hardcoded)
- [ ] Subject & lesson data models
- [ ] User authentication (Firebase Auth or similar)
- [ ] Cloud Firestore for progress tracking
- [ ] Real student profile data

### Phase 7: Enhanced Features
- [ ] Animated page transitions between screens
- [ ] Quiz timer countdown (currently static)
- [ ] Quiz scoring and result screen
- [ ] Lesson completion tracking
- [ ] Download lessons for offline use
- [ ] Push notifications for daily challenges
- [ ] AI Assistant screen (Ask AI button functionality)
- [ ] Multi-language support (Hindi, Marathi)

### Phase 8: Production Polish
- [ ] App icon and splash screen assets
- [ ] Onboarding flow for first-time users
- [ ] Error handling and loading states
- [ ] Unit tests and widget tests
- [ ] Integration tests
- [ ] Performance optimization
- [ ] Release build signing
- [ ] Play Store listing

---

## How to Run

```bash
# Get dependencies
flutter pub get

# Run on connected device/emulator
flutter run

# Build debug APK
flutter build apk --debug

# Run analysis
flutter analyze
```

**APK Output:** `build/app/outputs/flutter-apk/app-debug.apk`

---

## Quick Context for AI Assistant

When continuing work on this project, share this:

> **Project:** EduApp — Inclusive Learning Platform
> **Stitch Project:** `849892866353914343`
> **Status:** Phase 1–5 complete (all screens, widgets, accessibility, 0 analysis issues)
> **Next:** Phase 6 (real data & backend integration)
> **Path:** `E:\Startup\EDUAPP`

---

*Last updated: March 7, 2026*
