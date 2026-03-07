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
              const SizedBox(height: 28),
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
        label: 'Ask AI assistant',
        button: true,
        child: FloatingActionButton.extended(
          onPressed: () {
            accessibility.triggerHaptic();
            accessibility.speak('AI assistant');
          },
          backgroundColor: AppColors.primary,
          icon: const Icon(Icons.psychology, color: Colors.white),
          label: const Text('Ask AI', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
        ),
      ),
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
        // Notification bell
        Semantics(
          label: 'Notifications',
          button: true,
          child: IconButton(
            onPressed: () {
              accessibility.triggerHaptic();
              accessibility.speak('Notifications');
            },
            icon: const Icon(Icons.notifications_outlined, size: 28),
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
            Navigator.pushNamed(context, AppRoutes.subjects);
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
