<p align="center">
  <img src="https://img.shields.io/badge/Flutter-3.11-02569B?logo=flutter&logoColor=white" alt="Flutter">
  <img src="https://img.shields.io/badge/Dart-3.11-0175C2?logo=dart&logoColor=white" alt="Dart">
  <img src="https://img.shields.io/badge/Material_3-Enabled-681B98" alt="Material 3">
  <img src="https://img.shields.io/badge/Platform-Android-3DDC84?logo=android&logoColor=white" alt="Android">
  <img src="https://img.shields.io/badge/License-MIT-green" alt="License">
  <img src="https://img.shields.io/badge/Version-3.0.0-blue" alt="Version">
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
- **4 Subjects per Class** — English, Mathematics, Science, Balbharti with structured chapters & lessons
- **Audio Lessons** — Real TTS playback of lesson transcripts, sentence-by-sentence reading, speed control (0.5x–2.0x), pulse animation visualizer
- **Video Lessons** — Timer-based playback with auto-advancing captions, seekable progress bar, speed control, skip forward/backward
- **Interactive Quizzes** — Per-lesson MCQ questions with explanations, progress bar, scoring
- **Lesson Transcripts** — Paragraph-by-paragraph reading with "Read All" option

### 🤖 Ask AI Assistant
- **AI Chatbot** — Students can ask questions about any topic and get instant explanations
- **Smart Navigation** — Say "Go to Class 3" or "Open profile" to navigate the app by voice/text
- **Topic Explanations** — Answers questions about photosynthesis, vowels, math operations, and more
- **Quick Action Chips** — One-tap shortcuts for common queries
- **Action Buttons** — "Go there now" buttons to navigate directly from chat responses

### 🆘 Emergency SOS
- **Large SOS Button** — Pulsing emergency button with haptic pattern alerts
- **Quick Actions** — Vibrate, Speak Alert, Flash Screen
- **Safety Confirmation** — "I Am Safe" button to cancel alerts
- **Works in Any Mode** — `speakAlways()` ensures alerts are heard regardless of audio/video mode

### 🤟 Sign Language Dictionary
- **Categorized Terms** — Browse sign language terms by subject category
- **Handshape Descriptions** — Detailed instructions for each sign
- **Search** — Find specific signs quickly

### ♿ Accessibility (Built-In)
- **Audio Mode (Blind Users)** — Full TTS reading of lesson content, auto-read on screen entry, button announcements
- **Video Mode (Deaf Users)** — Always-on captions synced to playback, key visual concept cards, gesture guide
- **TalkBack Support** — Screen reader optimized with `Semantics` on every interactive element
- **High Contrast Mode** — Enhanced visual clarity toggle
- **Large Text Mode** — 1.3x text scaling across the entire app
- **Haptic Feedback** — Vibration on every interaction (light, medium, heavy, pattern)
- **Configurable Voice** — Adjustable speech rate (10%–100%) and pitch (0.5x–2.0x)
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
| **Home** | Welcome header, 3×3 class grid, Ask AI card, SOS & Sign Language quick access, Ask AI FAB |
| **Subjects** | Subject cards with icons, progress bars, completion percentages |
| **Lessons List** | Chapter sections with lesson cards, duration, quiz count, mode-aware icons |
| **Video Lesson** | Timer-based player with auto-captions, speed control, skip, key visual points, gesture guide |
| **Audio Lesson** | Real TTS playback of transcripts, pulse animation, visualizer, speed slider, seek bar |
| **Quiz** | Timer, progress bar, MCQ options with explanations, scoring |
| **Ask AI** | AI chatbot with quick actions, navigation commands, topic explanations, action buttons |
| **Sign Language** | Dictionary with categories, search, handshape descriptions |
| **Emergency** | SOS button with haptic patterns, speak alert, flash screen, safety confirmation |
| **Transcript** | Paragraph-by-paragraph lesson reading with Read All option |
| **Profile** | Avatar, level badge, XP bar, streak card, achievements, daily challenge |
| **Settings** | Accessibility toggles, voice settings, language, notifications, dark mode, sign out |

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
│   └── data/
│       └── lesson_data.dart               # Structured lesson database (Class 1-9)
├── features/
│   ├── splash/                            # Splash screen
│   ├── learning_mode/                     # Audio/Video mode selector
│   ├── home/                              # Home with class grid & Ask AI
│   ├── subjects/                          # Subject list with progress
│   ├── lessons/                           # Lessons list by chapter
│   ├── video_player/                      # Video lesson with timer playback
│   ├── audio_player/                      # Audio lesson with TTS reading
│   ├── quizzes/                           # Quiz system with scoring
│   ├── ask_ai/                            # AI chatbot assistant
│   ├── sign_language/                     # Sign language dictionary
│   ├── emergency/                         # SOS emergency screen
│   ├── transcript/                        # Lesson transcript viewer
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
- **Named Routes** — 14 declarative routes
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
| `/lessons` | Lessons List |
| `/lessonVideo` | Video Lesson (Deaf Mode) |
| `/lessonAudio` | Audio Lesson (Blind Mode) |
| `/quiz` | Quiz Screen |
| `/askAi` | Ask AI Chatbot |
| `/signLanguage` | Sign Language Dictionary |
| `/emergency` | Emergency SOS |
| `/transcript` | Lesson Transcript |
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
  <b>EduApp v3.0.0</b>
</p>

---

## 📋 Changelog (v3.0.0)

### ✅ Completed
- [x] Structured lesson database — Class 1-9, 4 subjects, chapters with lessons, quizzes, captions, key visual points
- [x] Real audio playback — TTS reads lesson transcripts sentence-by-sentence with seek, speed, pause/resume
- [x] Real video playback — Timer-based with auto-advancing captions, speed control, progress tracking
- [x] Ask AI Assistant — Chatbot with navigation, topic explanations, quick actions
- [x] Emergency SOS — Pulsing button, haptic patterns, speak alert, flash screen
- [x] Sign Language Dictionary — Categorized terms with handshape descriptions
- [x] Lesson transcripts — Paragraph-by-paragraph reading
- [x] Quiz system with per-lesson questions and explanations
- [x] App icon and splash screen assets

### 🔜 What's Next

#### Phase 4: Backend Integration
- [ ] User authentication (Firebase Auth)
- [ ] Cloud Firestore for progress/XP tracking
- [ ] Real video file streaming via `video_player`
- [ ] Real audio file streaming via `audioplayers`
- [ ] Lesson data from API/Firestore

#### Phase 5: Enhanced Features
- [ ] Animated page transitions
- [ ] Lesson completion tracking & progress persistence
- [ ] Download lessons for offline use
- [ ] Push notifications for daily challenges
- [ ] Multi-language support (Hindi, Marathi)
- [ ] AI Assistant with real LLM integration

#### Phase 6: Production Polish
- [ ] Onboarding flow for first-time users
- [ ] Error handling and loading states
- [ ] Unit tests and widget tests
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
