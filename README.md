# EduApp — Inclusive Learning Platform

> A production-ready Flutter mobile app for **blind and deaf students** (Class 1–9) featuring audio lessons, video lessons with captions, quizzes, and full accessibility support.

---

## Project Overview

| Field | Detail |
|-------|--------|
| **App Name** | EduApp |
| **Version** | 2.4.0 |
| **Platform** | Android (Flutter) |
| **Design Source** | [Stitch Project 849892866353914343](https://stitch.withgoogle.com/projects/849892866353914343) |
| **Design Theme** | Light mode, Primary `#681B98`, Font: Inter, Roundness: 12px |
| **Architecture** | Clean Architecture with Feature-based folders |
| **State Management** | Provider |

---

## What We Are Building

EduApp is an inclusive education platform that helps students from **Class 1 to Class 9** learn school subjects through two accessibility modes:

- **Audio Mode (Blind Students)** — Text-to-speech navigation, audio lessons, spoken button labels via `flutter_tts`
- **Video Mode (Deaf Students)** — Video lessons with live captions, visual concept cards, highlighted keywords

**Core Features:**
- Splash → Learning Mode Selection → Home → Subjects → Lessons → Quizzes
- 9 class cards with colorful gradients
- 4 subjects: English, Mathematics, Science, Balbharti
- Audio player with visualizer, speed controls (0.5x–2.0x)
- Video player with captions, key visual points, gesture guide
- Quiz system with timer, image questions, A/B/C/D options
- Profile with XP progress, streaks, achievements, daily challenges
- Settings with accessibility toggles (TalkBack, High Contrast, Large Text, Haptic)
- Bottom navigation: Home, Quizzes, Profile, Settings
- Ask AI floating action button

---

## Tech Stack

| Package | Purpose |
|---------|---------|
| `flutter` (Material 3) | UI framework |
| `provider` ^6.1.2 | State management |
| `flutter_tts` ^4.2.0 | Text-to-speech for blind users |
| `video_player` ^2.9.3 | Video lesson playback |
| `audioplayers` ^6.1.0 | Audio lesson playback |
| `shared_preferences` ^2.3.4 | Persistent user settings |
| `google_fonts` ^6.2.1 | Inter font (matches Stitch design) |

---

## Project Structure

```
lib/
├── main.dart                              # App entry, MultiProvider, routes
│
├── core/
│   ├── accessibility/
│   │   └── accessibility_provider.dart    # TTS, learning mode, a11y toggles
│   ├── constants/
│   │   ├── app_constants.dart             # App name, prefs keys, class count
│   │   └── app_routes.dart                # Named route constants
│   ├── theme/
│   │   ├── app_colors.dart                # All colors, gradients (Stitch)
│   │   └── app_theme.dart                 # Light/dark Material 3 themes
│   └── utils/
│       └── settings_provider.dart         # Dark mode, notifications, language
│
├── features/
│   ├── splash/
│   │   └── splash_screen.dart             # Gradient bg, icon, title, auto-nav
│   ├── learning_mode/
│   │   └── learning_mode_screen.dart      # Audio/Video mode selector cards
│   ├── home/
│   │   └── home_screen.dart               # Header, 3×3 class grid, Ask AI FAB
│   ├── subjects/
│   │   └── subjects_screen.dart           # Subject list with progress bars
│   ├── video_player/
│   │   └── video_lesson_screen.dart       # Video player, captions, visuals
│   ├── audio_player/
│   │   └── audio_lesson_screen.dart       # Audio player, visualizer, speed
│   ├── quizzes/
│   │   └── quiz_screen.dart               # Question card, options, timer
│   ├── profile/
│   │   └── profile_screen.dart            # XP, streak, achievements, challenge
│   └── settings/
│       └── settings_screen.dart           # A11y toggles, general settings
│
└── widgets/
    ├── accessibility_widgets/
    │   ├── semantic_wrapper.dart           # Reusable Semantics wrapper
    │   └── speak_on_tap.dart              # TTS on tap wrapper
    ├── buttons/
    │   ├── accessible_icon_button.dart    # IconButton with semantics + TTS
    │   └── primary_button.dart            # Gradient primary button
    ├── cards/
    │   ├── gradient_card.dart             # Gradient background card
    │   └── subject_card.dart              # Subject card with progress
    ├── navigation/
    │   └── bottom_nav_bar.dart            # 4-tab bottom nav
    └── progress_components/
        ├── quiz_progress.dart             # Quiz progress indicator
        └── xp_progress_bar.dart           # XP progress bar
```

---

## Routing

| Route | Screen | Description |
|-------|--------|-------------|
| `/` | SplashScreen | Gradient bg, auto-navigates to learning mode |
| `/learningMode` | LearningModeScreen | Choose Audio or Video mode |
| `/home` | HomeScreen | Class grid (1–9), Ask AI button |
| `/subjects` | SubjectsScreen | Subject list with progress bars |
| `/lessonVideo` | VideoLessonScreen | Video player + captions (Deaf Mode) |
| `/lessonAudio` | AudioLessonScreen | Audio player + visualizer (Blind Mode) |
| `/quiz` | QuizScreen | Question cards, timer, A/B/C/D options |
| `/profile` | ProfileScreen | XP, streak, achievements |
| `/settings` | SettingsScreen | Accessibility & general toggles |

---

## Stitch Design Screens (Project 849892866353914343)

| # | Screen ID | Title | Visible | Matched |
|---|-----------|-------|---------|---------|
| 1 | `c9215f75` | Splash Screen | ✅ | ✅ |
| 2 | `2aaa6f81` | Mode Selection Screen | ✅ | ✅ |
| 3 | `896ac92e` | Home Screen | ✅ | ✅ |
| 4 | `c33185b4` | Subjects Screen | ✅ | ✅ |
| 5 | `9145791b` | Audio Lesson (Unit 3 Science) | ✅ | ✅ |
| 6 | `957730d4` | Video Lesson (Enhanced) | ✅ | ✅ |
| 7 | `d3db7a39` | Video Lesson (Child-Friendly) | ✅ | ✅ |
| 8 | `2e549d4a` | Science Quiz | ✅ | ✅ |
| 9 | `f7e6b3ff` | Profile Screen | ✅ | ✅ |
| 10 | `d1359445` | Settings Screen | ✅ | ✅ |
| — | 14 hidden screens | Variants/drafts | Hidden | N/A |

---

## Build Progress

### Phase 1: Core Setup — ✅ COMPLETE
- [x] Flutter project scaffold (`edu_app`)
- [x] pubspec.yaml with all dependencies
- [x] App colors from Stitch design (`#681B98` primary)
- [x] Material 3 light/dark theme
- [x] Named routes (9 routes)
- [x] AccessibilityProvider (TTS, mode, toggles)
- [x] SettingsProvider (dark mode, notifications, language)
- [x] `main.dart` with MultiProvider + Consumer

### Phase 2: All 10 Screens — ✅ COMPLETE
- [x] Splash Screen — gradient bg, school icon, title, progress indicator, auto-nav
- [x] Learning Mode Screen — Audio/Video mode cards with select buttons
- [x] Home Screen — avatar, welcome text, 3×3 class grid, Ask AI FAB, bottom nav
- [x] Subjects Screen — English/Math/Science/Balbharti with progress bars + arrows
- [x] Video Lesson Screen — header, player controls, captions, key visual points, gesture guide, coming up next
- [x] Audio Lesson Screen — large play button, pulse animation, visualizer, progress bar, speed controls (0.5x–2.0x)
- [x] Quiz Screen — header, progress/timer, question card with image, A/B/C/D options, next button, report/review
- [x] Profile Screen — avatar, Level 12 badge, XP bar (1250/2000), 15-day streak, achievements, daily challenge
- [x] Settings Screen — Accessibility section (4 toggles) + General section (language, notifications, dark mode) + sign out
- [x] Bottom Navigation Bar — Home, Quizzes, Profile, Settings

### Phase 3: Reusable Widgets — ✅ COMPLETE
- [x] `BottomNavBar` — 4-tab navigation with route handling
- [x] `SemanticWrapper` — accessibility semantics wrapper
- [x] `SpeakOnTap` — TTS on tap wrapper
- [x] `AccessibleIconButton` — icon button with semantics + TTS
- [x] `PrimaryButton` — gradient primary button
- [x] `GradientCard` — gradient background card
- [x] `SubjectCard` — subject card with progress
- [x] `QuizProgress` — quiz progress indicator
- [x] `XPProgressBar` — experience progress bar

### Phase 4: Code Quality — ✅ COMPLETE
- [x] `flutter analyze` → **0 issues**
- [x] `flutter build apk --debug` → **builds successfully**
- [x] All `withOpacity()` → `withValues(alpha:)` (no deprecation warnings)
- [x] All `activeColor` → `activeThumbColor` (no deprecation warnings)
- [x] Semantic labels on every interactive element

### Phase 5: Accessibility — ✅ COMPLETE
- [x] `flutter_tts` integrated in AccessibilityProvider
- [x] TTS speaks button labels on tap (Audio Mode)
- [x] Learning mode stored in SharedPreferences
- [x] Semantic labels on all buttons, sliders, images
- [x] Large text mode (1.3x scale factor)
- [x] High contrast mode toggle
- [x] Haptic feedback on interactions
- [x] TalkBack support toggle
- [x] Captions enabled by default in Video Mode
- [x] Key visual concept cards for deaf learners

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
