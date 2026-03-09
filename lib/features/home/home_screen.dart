import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/accessibility/accessibility_provider.dart';
import '../../core/constants/app_constants.dart';
import '../../core/constants/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/navigation/bottom_nav_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final accessibility = context.watch<AccessibilityProvider>();

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              _buildHeader(context, accessibility),
              const SizedBox(height: 20),
              // Quick access for accessibility features
              _buildQuickAccessBar(context, accessibility),
              const SizedBox(height: 24),
              // Your Classes section
              _buildClassesHeader(context),
              const SizedBox(height: 16),
              // Class Grid
              _buildClassGrid(context, accessibility),
            ],
          ),
        ),
      ),
      floatingActionButton: Semantics(
        label: 'Ask AI Assistant',
        button: true,
        child: FloatingActionButton.extended(
          onPressed: () {
            accessibility.triggerHaptic();
            accessibility.speakAlways('Opening AI assistant');
            Navigator.pushNamed(context, AppRoutes.askAi);
          },
          backgroundColor: AppColors.primary,
          icon: const Icon(Icons.auto_awesome, color: Colors.white, size: 24),
          label: const Text('Ask AI', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: const BottomNavBar(currentIndex: 0),
    );
  }

  Widget _buildHeader(BuildContext context, AccessibilityProvider accessibility) {
    return Row(
      children: [
        // Avatar
        Semantics(
          label: 'Student profile picture',
          child: Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: AppColors.headerGradient,
            ),
            child: const Icon(Icons.person, color: Colors.white, size: 32),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome back,',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              Text(
                'Hello, Student!',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
                semanticsLabel: 'Hello Student',
              ),
            ],
          ),
        ),
        // Mode indicator
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                accessibility.isVideoMode ? Icons.videocam : Icons.headphones,
                size: 16,
                color: AppColors.primary,
              ),
              const SizedBox(width: 4),
              Text(
                accessibility.isVideoMode ? 'Deaf' : 'Blind',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildQuickAccessBar(BuildContext context, AccessibilityProvider accessibility) {
    return Column(
      children: [
        Row(
          children: [
            // Sign Language Dictionary
            Expanded(
              child: Semantics(
                label: 'Open Sign Language Dictionary',
                button: true,
                child: GestureDetector(
                  onTap: () {
                    accessibility.triggerHaptic();
                    accessibility.speakAlways('Sign Language Dictionary');
                    Navigator.pushNamed(context, AppRoutes.signLanguage);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F5E9),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.sign_language, color: Color(0xFF4CAF50), size: 24),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Sign Language',
                                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF2E7D32),
                                ),
                              ),
                              const Text('Dictionary', style: TextStyle(fontSize: 11, color: Color(0xFF4CAF50))),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Emergency SOS
            Expanded(
              child: Semantics(
                label: 'Emergency SOS help',
                button: true,
                child: GestureDetector(
                  onTap: () {
                    accessibility.triggerStrongHaptic();
                    accessibility.speakAlways('Emergency');
                    Navigator.pushNamed(context, AppRoutes.emergency);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFEBEE),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.sos, color: Color(0xFFF44336), size: 24),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Emergency',
                                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFFC62828),
                                ),
                              ),
                              const Text('SOS Help', style: TextStyle(fontSize: 11, color: Color(0xFFF44336))),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        // Ask AI button - full width
        Semantics(
          label: 'Ask AI Assistant - your learning buddy',
          button: true,
          child: GestureDetector(
            onTap: () {
              accessibility.triggerHaptic();
              accessibility.speakAlways('Opening AI assistant');
              Navigator.pushNamed(context, AppRoutes.askAi);
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                gradient: AppColors.splashGradient,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.auto_awesome, color: Colors.white, size: 22),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Ask AI Assistant',
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Ask questions, navigate, get help',
                          style: TextStyle(fontSize: 11, color: Colors.white.withValues(alpha: 0.8)),
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios, color: Colors.white.withValues(alpha: 0.7), size: 16),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildClassesHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your Classes',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '${AppConstants.totalClasses} active subjects this semester',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildClassGrid(BuildContext context, AccessibilityProvider accessibility) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 14,
        mainAxisSpacing: 14,
        childAspectRatio: 1.0,
      ),
      itemCount: AppConstants.totalClasses,
      itemBuilder: (context, index) {
        return _ClassCard(
          classNumber: index + 1,
          gradient: AppColors.classGradients[index % AppColors.classGradients.length],
          onTap: () {
            accessibility.triggerHaptic();
            accessibility.speak('Class ${index + 1}');
            Navigator.pushNamed(context, AppRoutes.subjects, arguments: {
              'classNumber': index + 1,
            });
          },
        );
      },
    );
  }
}

class _ClassCard extends StatelessWidget {
  final int classNumber;
  final LinearGradient gradient;
  final VoidCallback onTap;

  const _ClassCard({
    required this.classNumber,
    required this.gradient,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Class $classNumber',
      button: true,
      child: Material(
        borderRadius: BorderRadius.circular(16),
        elevation: 4,
        shadowColor: Colors.black12,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            decoration: BoxDecoration(
              gradient: gradient,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.class_, color: Colors.white, size: 28),
                  const SizedBox(height: 8),
                  Text(
                    'Class $classNumber',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
