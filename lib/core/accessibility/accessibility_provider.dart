import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/app_constants.dart';

class AccessibilityProvider extends ChangeNotifier {
  final FlutterTts _tts = FlutterTts();

  String _learningMode = '';
  bool _talkBackEnabled = false;
  bool _highContrastEnabled = false;
  bool _largeTextEnabled = false;
  bool _hapticFeedbackEnabled = true;
  double _speechRate = 0.5;
  double _speechPitch = 1.0;
  bool _autoReadEnabled = false;
  bool _screenDescriptionEnabled = true;

  String get learningMode => _learningMode;
  bool get isAudioMode => _learningMode == AppConstants.modeAudio;
  bool get isVideoMode => _learningMode == AppConstants.modeVideo;
  bool get talkBackEnabled => _talkBackEnabled;
  bool get highContrastEnabled => _highContrastEnabled;
  bool get largeTextEnabled => _largeTextEnabled;
  bool get hapticFeedbackEnabled => _hapticFeedbackEnabled;
  double get speechRate => _speechRate;
  double get speechPitch => _speechPitch;
  bool get autoReadEnabled => _autoReadEnabled;
  bool get screenDescriptionEnabled => _screenDescriptionEnabled;

  double get textScaleFactor => _largeTextEnabled ? 1.3 : 1.0;

  AccessibilityProvider() {
    _initTts();
    _loadPreferences();
  }

  Future<void> _initTts() async {
    await _tts.setLanguage('en-US');
    await _tts.setSpeechRate(_speechRate);
    await _tts.setVolume(1.0);
    await _tts.setPitch(_speechPitch);
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    _learningMode = prefs.getString(AppConstants.prefLearningMode) ?? '';
    _talkBackEnabled = prefs.getBool(AppConstants.prefTalkBack) ?? false;
    _highContrastEnabled = prefs.getBool(AppConstants.prefHighContrast) ?? false;
    _largeTextEnabled = prefs.getBool(AppConstants.prefLargeText) ?? false;
    _hapticFeedbackEnabled = prefs.getBool(AppConstants.prefHapticFeedback) ?? true;
    _speechRate = prefs.getDouble(AppConstants.prefSpeechRate) ?? 0.5;
    _speechPitch = prefs.getDouble(AppConstants.prefSpeechPitch) ?? 1.0;
    _autoReadEnabled = prefs.getBool(AppConstants.prefAutoRead) ?? false;
    _screenDescriptionEnabled = prefs.getBool(AppConstants.prefScreenDescription) ?? true;
    await _tts.setSpeechRate(_speechRate);
    await _tts.setPitch(_speechPitch);
    notifyListeners();
  }

  Future<void> setLearningMode(String mode) async {
    _learningMode = mode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppConstants.prefLearningMode, mode);
    notifyListeners();
    if (isAudioMode) {
      await speak('$mode mode selected. All content will be read aloud.');
    }
  }

  Future<void> speak(String text) async {
    if (_talkBackEnabled || isAudioMode) {
      await _tts.speak(text);
    }
  }

  /// Speak regardless of mode — for critical announcements like SOS
  Future<void> speakAlways(String text) async {
    await _tts.speak(text);
  }

  Future<void> stopSpeaking() async {
    await _tts.stop();
  }

  /// Read long content paragraph by paragraph with pauses
  Future<void> speakLongContent(String text) async {
    if (!_talkBackEnabled && !isAudioMode) return;
    final sentences = text.split(RegExp(r'[.!?]+\s*'));
    for (final sentence in sentences) {
      final trimmed = sentence.trim();
      if (trimmed.isNotEmpty) {
        await _tts.speak(trimmed);
        await _tts.awaitSpeakCompletion(true);
      }
    }
  }

  Future<void> setSpeechRate(double rate) async {
    _speechRate = rate.clamp(0.1, 1.0);
    await _tts.setSpeechRate(_speechRate);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(AppConstants.prefSpeechRate, _speechRate);
    notifyListeners();
  }

  Future<void> setSpeechPitch(double pitch) async {
    _speechPitch = pitch.clamp(0.5, 2.0);
    await _tts.setPitch(_speechPitch);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(AppConstants.prefSpeechPitch, _speechPitch);
    notifyListeners();
  }

  Future<void> toggleAutoRead(bool value) async {
    _autoReadEnabled = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppConstants.prefAutoRead, value);
    notifyListeners();
  }

  Future<void> toggleScreenDescription(bool value) async {
    _screenDescriptionEnabled = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppConstants.prefScreenDescription, value);
    notifyListeners();
  }

  Future<void> toggleTalkBack(bool value) async {
    _talkBackEnabled = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppConstants.prefTalkBack, value);
    notifyListeners();
  }

  Future<void> toggleHighContrast(bool value) async {
    _highContrastEnabled = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppConstants.prefHighContrast, value);
    notifyListeners();
  }

  Future<void> toggleLargeText(bool value) async {
    _largeTextEnabled = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppConstants.prefLargeText, value);
    notifyListeners();
  }

  Future<void> toggleHapticFeedback(bool value) async {
    _hapticFeedbackEnabled = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppConstants.prefHapticFeedback, value);
    notifyListeners();
  }

  void triggerHaptic() {
    if (_hapticFeedbackEnabled) {
      HapticFeedback.mediumImpact();
    }
  }

  /// Strong haptic for important events (correct answer, SOS, errors)
  void triggerStrongHaptic() {
    if (_hapticFeedbackEnabled) {
      HapticFeedback.heavyImpact();
    }
  }

  /// Pattern vibration for deaf users (e.g., correct = 2 short, wrong = 1 long)
  Future<void> triggerPatternHaptic({required bool isPositive}) async {
    if (!_hapticFeedbackEnabled) return;
    if (isPositive) {
      HapticFeedback.lightImpact();
      await Future.delayed(const Duration(milliseconds: 100));
      HapticFeedback.lightImpact();
    } else {
      HapticFeedback.heavyImpact();
    }
  }

  @override
  void dispose() {
    _tts.stop();
    super.dispose();
  }
}
