import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/accessibility/accessibility_provider.dart';
import 'core/constants/app_routes.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/settings_provider.dart';
import 'features/splash/splash_screen.dart';
import 'features/learning_mode/learning_mode_screen.dart';
import 'features/home/home_screen.dart';
import 'features/subjects/subjects_screen.dart';
import 'features/lessons/lessons_list_screen.dart';
import 'features/video_player/video_lesson_screen.dart';
import 'features/audio_player/audio_lesson_screen.dart';
import 'features/quizzes/quiz_screen.dart';
import 'features/profile/profile_screen.dart';
import 'features/settings/settings_screen.dart';
import 'features/sign_language/sign_language_screen.dart';
import 'features/emergency/emergency_screen.dart';
import 'features/transcript/lesson_transcript_screen.dart';
import 'features/ask_ai/ask_ai_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const EduApp());
}

class EduApp extends StatelessWidget {
  const EduApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AccessibilityProvider()),
        ChangeNotifierProvider(create: (_) => SettingsProvider()),
      ],
      child: Consumer2<AccessibilityProvider, SettingsProvider>(
        builder: (context, a11y, settings, _) {
          return MaterialApp(
            title: 'EDUAPP',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: settings.darkMode ? ThemeMode.dark : ThemeMode.light,
            builder: (context, child) {
              final mediaQuery = MediaQuery.of(context);
              return MediaQuery(
                data: mediaQuery.copyWith(
                  textScaler: TextScaler.linear(a11y.textScaleFactor),
                ),
                child: child!,
              );
            },
            initialRoute: AppRoutes.splash,
            routes: {
              AppRoutes.splash: (_) => const SplashScreen(),
              AppRoutes.learningMode: (_) => const LearningModeScreen(),
              AppRoutes.home: (_) => const HomeScreen(),
              AppRoutes.subjects: (_) => const SubjectsScreen(),
              AppRoutes.lessons: (_) => const LessonsListScreen(),
              AppRoutes.lessonVideo: (_) => const VideoLessonScreen(),
              AppRoutes.lessonAudio: (_) => const AudioLessonScreen(),
              AppRoutes.quiz: (_) => const QuizScreen(),
              AppRoutes.profile: (_) => const ProfileScreen(),
              AppRoutes.settings: (_) => const SettingsScreen(),
              AppRoutes.signLanguage: (_) => const SignLanguageScreen(),
              AppRoutes.emergency: (_) => const EmergencyScreen(),
              AppRoutes.transcript: (_) => const LessonTranscriptScreen(),
              AppRoutes.askAi: (_) => const AskAiScreen(),
            },
          );
        },
      ),
    );
  }
}
