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

  String get learningMode => _learningMode;
  bool get isAudioMode => _learningMode == AppConstants.modeAudio;
  bool get isVideoMode => _learningMode == AppConstants.modeVideo;
  bool get talkBackEnabled => _talkBackEnabled;
  bool get highContrastEnabled => _highContrastEnabled;
  bool get largeTextEnabled => _largeTextEnabled;
  bool get hapticFeedbackEnabled => _hapticFeedbackEnabled;

  double get textScaleFactor => _largeTextEnabled ? 1.3 : 1.0;

  AccessibilityProvider() {
    _initTts();
    _loadPreferences();
  }

  Future<void> _initTts() async {
    await _tts.setLanguage('en-US');
    await _tts.setSpeechRate(0.5);
    await _tts.setVolume(1.0);
    await _tts.setPitch(1.0);
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    _learningMode = prefs.getString(AppConstants.prefLearningMode) ?? '';
    _talkBackEnabled = prefs.getBool(AppConstants.prefTalkBack) ?? false;
    _highContrastEnabled = prefs.getBool(AppConstants.prefHighContrast) ?? false;
    _largeTextEnabled = prefs.getBool(AppConstants.prefLargeText) ?? false;
    _hapticFeedbackEnabled = prefs.getBool(AppConstants.prefHapticFeedback) ?? true;
    notifyListeners();
  }

  Future<void> setLearningMode(String mode) async {
    _learningMode = mode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppConstants.prefLearningMode, mode);
    notifyListeners();
    if (isAudioMode) {
      await speak('$mode mode selected');
    }
  }

  Future<void> speak(String text) async {
    if (_talkBackEnabled || isAudioMode) {
      await _tts.speak(text);
    }
  }

  Future<void> stopSpeaking() async {
    await _tts.stop();
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

  @override
  void dispose() {
    _tts.stop();
    super.dispose();
  }
}
