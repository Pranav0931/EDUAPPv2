import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/accessibility/accessibility_provider.dart';
import '../../core/constants/app_routes.dart';
import '../../core/theme/app_colors.dart';

class AskAiScreen extends StatefulWidget {
  const AskAiScreen({super.key});

  @override
  State<AskAiScreen> createState() => _AskAiScreenState();
}

class _AskAiScreenState extends State<AskAiScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<_ChatMessage> _messages = [];
  bool _isTyping = false;

  @override
  void initState() {
    super.initState();
    // Welcome message
    _messages.add(_ChatMessage(
      text: 'Hi! I\'m your AI learning assistant. You can ask me anything about your lessons, '
          'or say things like:\n\n'
          '• "Take me to English lessons"\n'
          '• "Open Class 3 Math"\n'
          '• "Start a quiz"\n'
          '• "Go to my profile"\n'
          '• "Explain photosynthesis"\n'
          '• "Help me with alphabets"\n\n'
          'How can I help you today?',
      isUser: false,
    ));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final a11y = context.read<AccessibilityProvider>();
      a11y.speakAlways(
        'Ask AI assistant. You can type or speak your question. '
        'I can help you navigate to lessons, explain topics, or start quizzes.',
      );
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    final a11y = context.read<AccessibilityProvider>();
    a11y.triggerHaptic();

    setState(() {
      _messages.add(_ChatMessage(text: text, isUser: true));
      _messageController.clear();
      _isTyping = true;
    });

    _scrollToBottom();

    // Process the message with a short delay to feel natural
    Future.delayed(const Duration(milliseconds: 800), () {
      if (!mounted) return;
      final response = _processMessage(text);
      setState(() {
        _messages.add(_ChatMessage(text: response.text, isUser: false, action: response.action));
        _isTyping = false;
      });
      _scrollToBottom();
      a11y.speakAlways(response.text);
    });
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  _AiResponse _processMessage(String input) {
    final lower = input.toLowerCase();

    // Navigation commands
    if (lower.contains('home')) {
      return _AiResponse(
        text: 'Taking you to the Home screen! 🏠',
        action: () => Navigator.pushNamedAndRemoveUntil(context, AppRoutes.home, (r) => false),
      );
    }
    if (lower.contains('profile')) {
      return _AiResponse(
        text: 'Opening your Profile! Here you can see your XP, streak, and achievements. 📊',
        action: () => Navigator.pushNamed(context, AppRoutes.profile),
      );
    }
    if (lower.contains('setting')) {
      return _AiResponse(
        text: 'Opening Settings! You can adjust accessibility, voice, and display options. ⚙️',
        action: () => Navigator.pushNamed(context, AppRoutes.settings),
      );
    }
    if (lower.contains('quiz') || lower.contains('test')) {
      return _AiResponse(
        text: 'Let\'s take a quiz! Go to any lesson first, then tap the Quiz button at the bottom to start. '
            'Would you like me to help you find a specific subject?',
        action: null,
      );
    }
    if (lower.contains('emergency') || lower.contains('sos') || lower.contains('help me')) {
      return _AiResponse(
        text: 'Opening Emergency SOS screen. Stay calm, help is on the way! 🆘',
        action: () => Navigator.pushNamed(context, AppRoutes.emergency),
      );
    }
    if (lower.contains('sign language') || lower.contains('sign')) {
      return _AiResponse(
        text: 'Opening Sign Language Dictionary! You can explore signs by category. 🤟',
        action: () => Navigator.pushNamed(context, AppRoutes.signLanguage),
      );
    }

    // Subject navigation
    for (int i = 1; i <= 9; i++) {
      if (lower.contains('class $i') || lower.contains('class$i')) {
        return _AiResponse(
          text: 'Opening Class $i subjects! Pick a subject to start learning. 📚',
          action: () => Navigator.pushNamed(context, AppRoutes.subjects, arguments: {'classNumber': i}),
        );
      }
    }

    // Subject-specific
    if (lower.contains('english')) {
      return _AiResponse(
        text: 'English is a great choice! Go to any class and tap on English to see chapters and lessons. '
            'Topics include alphabets, vowels, grammar, reading, and writing.',
        action: null,
      );
    }
    if (lower.contains('math') || lower.contains('maths')) {
      return _AiResponse(
        text: 'Math helps build problem-solving skills! Go to any class and tap on Mathematics. '
            'Topics include counting, addition, subtraction, shapes, and more.',
        action: null,
      );
    }
    if (lower.contains('science')) {
      return _AiResponse(
        text: 'Science is fascinating! Topics include plants, animals, the human body, seasons, and more. '
            'Go to any class and tap on Science to explore.',
        action: null,
      );
    }

    // Educational content explanations
    if (lower.contains('photosynthesis')) {
      return _AiResponse(
        text: 'Photosynthesis is the process by which plants make their own food. '
            'Plants use sunlight, water from the soil, and carbon dioxide from the air '
            'to produce glucose (sugar) and oxygen. The equation is:\n\n'
            'Sunlight + Water + CO₂ → Glucose + Oxygen\n\n'
            'This mostly happens in the leaves, which contain chlorophyll (the green pigment).',
        action: null,
      );
    }
    if (lower.contains('alphabet') || lower.contains('abc')) {
      return _AiResponse(
        text: 'The English alphabet has 26 letters: A to Z. There are 5 vowels (A, E, I, O, U) '
            'and 21 consonants. Want me to take you to the Alphabets lesson?',
        action: null,
      );
    }
    if (lower.contains('vowel')) {
      return _AiResponse(
        text: 'Vowels are special letters: A, E, I, O, U. Every word needs at least one vowel! '
            'They can make both short and long sounds. For example:\n'
            '• A: "apple" (short) vs "ape" (long)\n'
            '• E: "egg" (short) vs "eagle" (long)',
        action: null,
      );
    }
    if (lower.contains('add') || lower.contains('plus') || lower.contains('sum')) {
      return _AiResponse(
        text: 'Addition means putting numbers together to get a bigger number! For example:\n'
            '• 2 + 3 = 5 (putting 2 apples and 3 apples together gives 5 apples)\n'
            '• 10 + 5 = 15\n\n'
            'Remember: The order doesn\'t matter! 3 + 2 is the same as 2 + 3.',
        action: null,
      );
    }
    if (lower.contains('subtract') || lower.contains('minus')) {
      return _AiResponse(
        text: 'Subtraction means taking away from a number to get a smaller number! For example:\n'
            '• 5 - 2 = 3 (if you have 5 apples and give away 2, you have 3 left)\n'
            '• 10 - 4 = 6\n\n'
            'Tip: Think of it as "how many are left?"',
        action: null,
      );
    }

    // Mode questions
    if (lower.contains('mode') || lower.contains('deaf') || lower.contains('blind')) {
      return _AiResponse(
        text: 'This app supports two learning modes:\n\n'
            '• Audio Mode (for blind users): Lessons are read aloud via text-to-speech\n'
            '• Video Mode (for deaf users): Lessons include captions and sign language\n\n'
            'You can change your mode in Settings.',
        action: null,
      );
    }

    // Greeting
    if (lower.contains('hello') || lower.contains('hi') || lower == 'hey') {
      return _AiResponse(
        text: 'Hello! 👋 I\'m here to help you learn. You can ask me about any subject, '
            'request explanations, or ask me to navigate to any part of the app. What would you like to do?',
        action: null,
      );
    }
    if (lower.contains('thank')) {
      return _AiResponse(
        text: 'You\'re welcome! Happy to help you learn. Keep up the great work! 🌟',
        action: null,
      );
    }

    // Default helpful response
    return _AiResponse(
      text: 'I can help you with:\n\n'
          '📚 **Navigate** — Say "Go to Class 3" or "Open profile"\n'
          '📖 **Learn** — Ask about any topic like "What is photosynthesis?"\n'
          '🧮 **Math help** — Ask about addition, subtraction, shapes\n'
          '📝 **Quiz** — Say "Start a quiz"\n'
          '🆘 **Emergency** — Say "SOS" for help\n\n'
          'Try asking me something specific!',
      action: null,
    );
  }

  void _handleQuickAction(String action) {
    _messageController.text = action;
    _sendMessage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            _buildHeader(context),
            // Quick Action Chips
            _buildQuickActions(),
            // Chat messages
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemCount: _messages.length + (_isTyping ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == _messages.length && _isTyping) {
                    return _buildTypingIndicator();
                  }
                  return _buildMessageBubble(_messages[index]);
                },
              ),
            ),
            // Input field
            _buildInputField(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(gradient: AppColors.headerGradient),
      padding: const EdgeInsets.fromLTRB(8, 8, 16, 16),
      child: Row(
        children: [
          Semantics(
            label: 'Go back',
            button: true,
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back, color: Colors.white),
            ),
          ),
          const SizedBox(width: 8),
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
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'Your learning buddy',
                  style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 12),
                ),
              ],
            ),
          ),
          Semantics(
            label: 'Clear chat',
            button: true,
            child: IconButton(
              onPressed: () {
                final a11y = context.read<AccessibilityProvider>();
                a11y.triggerHaptic();
                setState(() {
                  _messages.clear();
                  _messages.add(_ChatMessage(
                    text: 'Chat cleared! How can I help you?',
                    isUser: false,
                  ));
                });
                a11y.speakAlways('Chat cleared');
              },
              icon: const Icon(Icons.refresh, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    final actions = [
      ('📚 My Classes', 'Take me to home'),
      ('📝 Start Quiz', 'Start a quiz'),
      ('🤟 Sign Language', 'Open sign language dictionary'),
      ('👤 Profile', 'Open my profile'),
      ('📖 English Help', 'Help me with english'),
      ('🧮 Math Help', 'Help me with math'),
    ];

    return SizedBox(
      height: 44,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        itemCount: actions.length,
        itemBuilder: (context, index) {
          final (label, message) = actions[index];
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Semantics(
              label: label,
              button: true,
              child: ActionChip(
                label: Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                backgroundColor: AppColors.primary.withValues(alpha: 0.08),
                side: BorderSide(color: AppColors.primary.withValues(alpha: 0.2)),
                onPressed: () => _handleQuickAction(message),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMessageBubble(_ChatMessage message) {
    final isUser = message.isUser;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isUser)
            Container(
              width: 32,
              height: 32,
              margin: const EdgeInsets.only(right: 8, top: 4),
              decoration: BoxDecoration(
                gradient: AppColors.splashGradient,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.auto_awesome, color: Colors.white, size: 16),
            ),
          Flexible(
            child: Column(
              crossAxisAlignment: isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Semantics(
                  label: '${isUser ? "You" : "AI Assistant"}: ${message.text}',
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: isUser ? AppColors.primary : Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(16),
                        topRight: const Radius.circular(16),
                        bottomLeft: isUser ? const Radius.circular(16) : Radius.zero,
                        bottomRight: isUser ? Radius.zero : const Radius.circular(16),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      message.text,
                      style: TextStyle(
                        color: isUser ? Colors.white : AppColors.textPrimary,
                        fontSize: 14,
                        height: 1.4,
                      ),
                    ),
                  ),
                ),
                if (message.action != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Semantics(
                      label: 'Go there now',
                      button: true,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          final a11y = context.read<AccessibilityProvider>();
                          a11y.triggerHaptic();
                          message.action!();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        icon: const Icon(Icons.arrow_forward, size: 16),
                        label: const Text('Go there now', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          if (isUser) const SizedBox(width: 8),
        ],
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              gradient: AppColors.splashGradient,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.auto_awesome, color: Colors.white, size: 16),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(3, (i) {
                return Padding(
                  padding: EdgeInsets.only(left: i > 0 ? 4 : 0),
                  child: _TypingDot(delay: i * 200),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 8, 8, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Semantics(
              label: 'Type your question here',
              textField: true,
              child: TextField(
                controller: _messageController,
                decoration: InputDecoration(
                  hintText: 'Ask me anything...',
                  hintStyle: TextStyle(color: AppColors.textSecondary.withValues(alpha: 0.6)),
                  filled: true,
                  fillColor: AppColors.surface,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
                textInputAction: TextInputAction.send,
                onSubmitted: (_) => _sendMessage(),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Semantics(
            label: 'Send message',
            button: true,
            child: GestureDetector(
              onTap: _sendMessage,
              child: Container(
                width: 48,
                height: 48,
                decoration: const BoxDecoration(
                  gradient: AppColors.splashGradient,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.send, color: Colors.white, size: 22),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChatMessage {
  final String text;
  final bool isUser;
  final VoidCallback? action;

  _ChatMessage({required this.text, required this.isUser, this.action});
}

class _AiResponse {
  final String text;
  final VoidCallback? action;

  _AiResponse({required this.text, required this.action});
}

class _TypingDot extends StatefulWidget {
  final int delay;
  const _TypingDot({required this.delay});

  @override
  State<_TypingDot> createState() => _TypingDotState();
}

class _TypingDotState extends State<_TypingDot> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) _controller.repeat(reverse: true);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.3 + _controller.value * 0.7),
            shape: BoxShape.circle,
          ),
        );
      },
    );
  }
}
