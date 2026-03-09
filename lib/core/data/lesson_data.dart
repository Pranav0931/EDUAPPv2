// Structured lesson data model for EduApp.
// Organized: Class → Subject → Chapter → Lessons with demo audio/video URLs.
//
// Demo content uses freely available educational resources.
// In production, replace URLs with your own hosted content.

class LessonContent {
  final String id;
  final String title;
  final String description;
  final String transcript;
  final String videoUrl;
  final String audioUrl;
  final String thumbnailIcon; // Material icon name
  final int durationSeconds;
  final List<String> captions;
  final List<KeyVisualPoint> keyVisualPoints;
  final List<QuizQuestion> quizQuestions;
  final List<SignLanguageTerm> signLanguageTerms;

  const LessonContent({
    required this.id,
    required this.title,
    required this.description,
    required this.transcript,
    this.videoUrl = '',
    this.audioUrl = '',
    this.thumbnailIcon = 'school',
    this.durationSeconds = 300,
    this.captions = const [],
    this.keyVisualPoints = const [],
    this.quizQuestions = const [],
    this.signLanguageTerms = const [],
  });
}

class KeyVisualPoint {
  final String iconName;
  final String title;
  final String subtitle;
  final int colorValue;

  const KeyVisualPoint({
    required this.iconName,
    required this.title,
    required this.subtitle,
    this.colorValue = 0xFF4CAF50,
  });
}

class QuizQuestion {
  final String question;
  final String imageDescription;
  final List<String> options;
  final int correctIndex;
  final String explanation;

  const QuizQuestion({
    required this.question,
    this.imageDescription = '',
    required this.options,
    required this.correctIndex,
    this.explanation = '',
  });
}

class SignLanguageTerm {
  final String term;
  final String description;
  final String handshapeDescription;
  final String category;

  const SignLanguageTerm({
    required this.term,
    required this.description,
    required this.handshapeDescription,
    this.category = 'General',
  });
}

class SubjectData {
  final String name;
  final String iconName;
  final int colorValue;
  final List<ChapterData> chapters;

  const SubjectData({
    required this.name,
    required this.iconName,
    required this.colorValue,
    required this.chapters,
  });
}

class ChapterData {
  final String id;
  final String title;
  final String unitLabel;
  final List<LessonContent> lessons;

  const ChapterData({
    required this.id,
    required this.title,
    required this.unitLabel,
    required this.lessons,
  });
}

class ClassData {
  final int classNumber;
  final List<SubjectData> subjects;

  const ClassData({
    required this.classNumber,
    required this.subjects,
  });
}

/// Complete demo lesson database for Classes 1-9
class LessonDatabase {
  LessonDatabase._();

  static List<ClassData> get allClasses => [
        _class1,
        _class2,
        _class3,
        _class4,
        _class5,
        _class6,
        _class7,
        _class8,
        _class9,
      ];

  static ClassData getClass(int classNumber) {
    if (classNumber < 1 || classNumber > 9) return _class1;
    return allClasses[classNumber - 1];
  }

  // ═══════════════════════════════════════════
  // CLASS 1
  // ═══════════════════════════════════════════
  static const _class1 = ClassData(
    classNumber: 1,
    subjects: [
      SubjectData(
        name: 'English',
        iconName: 'menu_book',
        colorValue: 0xFF667EEA,
        chapters: [
          ChapterData(
            id: 'c1_eng_ch1',
            title: 'Alphabets & Sounds',
            unitLabel: 'UNIT 1: ENGLISH',
            lessons: [
              LessonContent(
                id: 'c1_eng_ch1_l1',
                title: 'Learning A to Z',
                description: 'Learn all 26 alphabets with their sounds and examples.',
                transcript:
                    'Welcome to your first English lesson! Today we will learn the English alphabet from A to Z. '
                    'The letter A makes the sound "ah" as in Apple. B makes the sound "buh" as in Ball. '
                    'C makes the sound "kuh" as in Cat. D makes the sound "duh" as in Dog. '
                    'E makes the sound "eh" as in Elephant. F makes the sound "fuh" as in Fish. '
                    'G makes the sound "guh" as in Goat. H makes the sound "huh" as in Hat. '
                    'Now let us practice together! Can you say each letter after me? A, B, C, D, E, F, G! '
                    'Great job! Keep practicing every day and you will know all 26 letters very well.',
                durationSeconds: 420,
                captions: [
                  'Welcome to your first English lesson!',
                  'Today we will learn the English alphabet from A to Z.',
                  'The letter A makes the sound "ah" as in Apple.',
                  'B makes the sound "buh" as in Ball.',
                  'C makes the sound "kuh" as in Cat.',
                  'D makes the sound "duh" as in Dog.',
                  'Now let us practice together!',
                  'Can you say each letter after me?',
                ],
                keyVisualPoints: [
                  KeyVisualPoint(iconName: 'abc', title: 'Alphabet A-Z', subtitle: '26 letters in English', colorValue: 0xFF667EEA),
                  KeyVisualPoint(iconName: 'record_voice_over', title: 'Letter Sounds', subtitle: 'Each letter has a unique sound', colorValue: 0xFF42A5F5),
                  KeyVisualPoint(iconName: 'pets', title: 'Animal Examples', subtitle: 'A for Apple, B for Ball', colorValue: 0xFF66BB6A),
                  KeyVisualPoint(iconName: 'music_note', title: 'ABC Song', subtitle: 'Sing along to remember!', colorValue: 0xFFFFA726),
                ],
                quizQuestions: [
                  QuizQuestion(question: 'How many letters are in the English alphabet?', options: ['20', '24', '26', '30'], correctIndex: 2, explanation: 'There are 26 letters from A to Z.'),
                  QuizQuestion(question: 'Which letter comes after B?', options: ['A', 'C', 'D', 'E'], correctIndex: 1, explanation: 'C comes after B in the alphabet.'),
                  QuizQuestion(question: 'What sound does the letter A make?', options: ['Buh', 'Ah', 'Kuh', 'Duh'], correctIndex: 1, explanation: 'A makes the "ah" sound, like in Apple.'),
                ],
                signLanguageTerms: [
                  SignLanguageTerm(term: 'Alphabet', description: 'The set of letters used in writing', handshapeDescription: 'Fingerspell A-B-C by forming each letter with your hand', category: 'English'),
                  SignLanguageTerm(term: 'Apple', description: 'A round fruit', handshapeDescription: 'Make a fist with index knuckle extended, twist at cheek', category: 'Objects'),
                ],
              ),
              LessonContent(
                id: 'c1_eng_ch1_l2',
                title: 'Vowels: A, E, I, O, U',
                description: 'Learn the five special letters called vowels.',
                transcript:
                    'Today we will learn about vowels! Vowels are very special letters. '
                    'There are 5 vowels: A, E, I, O, U. Every word needs at least one vowel. '
                    'A sounds like "ah" in cat. E sounds like "eh" in bed. '
                    'I sounds like "ih" in sit. O sounds like "oh" in hot. '
                    'U sounds like "uh" in cup. Remember: A, E, I, O, U are your vowel friends!',
                durationSeconds: 360,
                captions: [
                  'Today we will learn about vowels!',
                  'Vowels are very special letters.',
                  'There are 5 vowels: A, E, I, O, U.',
                  'Every word needs at least one vowel.',
                  'A sounds like "ah" in cat.',
                  'E sounds like "eh" in bed.',
                  'Remember: A, E, I, O, U are your vowel friends!',
                ],
                keyVisualPoints: [
                  KeyVisualPoint(iconName: 'star', title: '5 Vowels', subtitle: 'A, E, I, O, U', colorValue: 0xFFFF6B6B),
                  KeyVisualPoint(iconName: 'record_voice_over', title: 'Vowel Sounds', subtitle: 'Each vowel has its own sound', colorValue: 0xFF4ECDC4),
                ],
                quizQuestions: [
                  QuizQuestion(question: 'How many vowels are there?', options: ['3', '4', '5', '6'], correctIndex: 2, explanation: 'There are 5 vowels: A, E, I, O, U.'),
                  QuizQuestion(question: 'Which of these is a vowel?', options: ['B', 'C', 'E', 'F'], correctIndex: 2, explanation: 'E is one of the 5 vowels.'),
                ],
              ),
            ],
          ),
          ChapterData(
            id: 'c1_eng_ch2',
            title: 'Simple Words',
            unitLabel: 'UNIT 2: ENGLISH',
            lessons: [
              LessonContent(
                id: 'c1_eng_ch2_l1',
                title: 'Three-Letter Words',
                description: 'Learn to read and spell simple three-letter words like cat, dog, and bat.',
                transcript:
                    'Let us learn some simple words today! We will start with three-letter words. '
                    'C-A-T spells Cat. A cat is a small furry animal that says meow. '
                    'D-O-G spells Dog. A dog is a friendly animal that says woof. '
                    'B-A-T spells Bat. A bat flies at night. '
                    'H-A-T spells Hat. You wear a hat on your head. '
                    'Now you try! Can you spell these words with me?',
                durationSeconds: 380,
                captions: [
                  'Let us learn some simple words today!',
                  'C-A-T spells Cat. A cat is a small furry animal.',
                  'D-O-G spells Dog. A dog is a friendly animal.',
                  'B-A-T spells Bat. A bat flies at night.',
                  'H-A-T spells Hat. You wear a hat on your head.',
                  'Now you try! Can you spell these words?',
                ],
                keyVisualPoints: [
                  KeyVisualPoint(iconName: 'pets', title: 'Cat', subtitle: 'C-A-T: A furry pet', colorValue: 0xFFFFA726),
                  KeyVisualPoint(iconName: 'pets', title: 'Dog', subtitle: 'D-O-G: A friendly pet', colorValue: 0xFF42A5F5),
                  KeyVisualPoint(iconName: 'nightlight', title: 'Bat', subtitle: 'B-A-T: Flies at night', colorValue: 0xFF9C27B0),
                  KeyVisualPoint(iconName: 'checkroom', title: 'Hat', subtitle: 'H-A-T: Worn on head', colorValue: 0xFF66BB6A),
                ],
                quizQuestions: [
                  QuizQuestion(question: 'How do you spell Cat?', options: ['K-A-T', 'C-A-T', 'C-A-D', 'K-A-D'], correctIndex: 1, explanation: 'Cat is spelled C-A-T.'),
                  QuizQuestion(question: 'Which word means a friendly animal that says woof?', options: ['Cat', 'Bat', 'Dog', 'Hat'], correctIndex: 2, explanation: 'A dog is a friendly animal that says woof.'),
                ],
              ),
            ],
          ),
        ],
      ),
      SubjectData(
        name: 'Mathematics',
        iconName: 'calculate',
        colorValue: 0xFFFF6B6B,
        chapters: [
          ChapterData(
            id: 'c1_math_ch1',
            title: 'Numbers 1 to 10',
            unitLabel: 'UNIT 1: MATHEMATICS',
            lessons: [
              LessonContent(
                id: 'c1_math_ch1_l1',
                title: 'Counting 1 to 10',
                description: 'Learn to count from 1 to 10 with fun examples.',
                transcript:
                    'Let us learn to count! We will count from 1 to 10. '
                    'Number 1 - one finger up! Number 2 - two fingers! '
                    'Number 3 - three fingers! Number 4 - four fingers! '
                    'Number 5 - that is one whole hand! '
                    'Number 6, 7, 8, 9, and 10 - that is both hands! '
                    'Can you count with me? 1, 2, 3, 4, 5, 6, 7, 8, 9, 10! '
                    'Excellent! You can count to ten!',
                durationSeconds: 300,
                captions: [
                  'Let us learn to count from 1 to 10!',
                  'Number 1 - one finger up!',
                  'Number 2 - two fingers!',
                  'Number 5 - that is one whole hand!',
                  'Number 10 - that is both your hands!',
                  'Can you count with me?',
                  '1, 2, 3, 4, 5, 6, 7, 8, 9, 10!',
                ],
                keyVisualPoints: [
                  KeyVisualPoint(iconName: 'looks_one', title: 'Numbers 1-5', subtitle: 'Count on one hand', colorValue: 0xFFFF6B6B),
                  KeyVisualPoint(iconName: 'looks_two', title: 'Numbers 6-10', subtitle: 'Count on both hands', colorValue: 0xFF42A5F5),
                  KeyVisualPoint(iconName: 'front_hand', title: 'Finger Counting', subtitle: 'Use your fingers to count', colorValue: 0xFF66BB6A),
                  KeyVisualPoint(iconName: 'groups', title: 'Count Objects', subtitle: 'Count things around you', colorValue: 0xFFFFA726),
                ],
                quizQuestions: [
                  QuizQuestion(question: 'What number comes after 5?', options: ['4', '5', '6', '7'], correctIndex: 2, explanation: '6 comes after 5.'),
                  QuizQuestion(question: 'How many fingers on one hand?', options: ['3', '4', '5', '6'], correctIndex: 2, explanation: 'We have 5 fingers on one hand.'),
                  QuizQuestion(question: 'What number comes before 10?', options: ['7', '8', '9', '11'], correctIndex: 2, explanation: '9 comes before 10.'),
                ],
                signLanguageTerms: [
                  SignLanguageTerm(term: 'One', description: 'The number 1', handshapeDescription: 'Hold up your index finger', category: 'Numbers'),
                  SignLanguageTerm(term: 'Five', description: 'The number 5', handshapeDescription: 'Open your hand with all 5 fingers spread', category: 'Numbers'),
                  SignLanguageTerm(term: 'Ten', description: 'The number 10', handshapeDescription: 'Hold up a fist with thumb up and shake', category: 'Numbers'),
                ],
              ),
              LessonContent(
                id: 'c1_math_ch1_l2',
                title: 'Number Names',
                description: 'Learn to write number names: one, two, three... up to ten.',
                transcript:
                    'Now that we can count, let us learn to write number names! '
                    '1 is written as "one". 2 is "two". 3 is "three". '
                    '4 is "four". 5 is "five". '
                    '6 is "six". 7 is "seven". 8 is "eight". '
                    '9 is "nine". 10 is "ten". '
                    'Let us practice writing these number names together!',
                durationSeconds: 330,
                captions: [
                  'Now let us learn to write number names!',
                  '1 is "one", 2 is "two", 3 is "three".',
                  '4 is "four", 5 is "five".',
                  '6 is "six", 7 is "seven".',
                  '8 is "eight", 9 is "nine", 10 is "ten".',
                  'Let us practice writing these number names!',
                ],
                keyVisualPoints: [
                  KeyVisualPoint(iconName: 'edit', title: 'Writing Numbers', subtitle: 'Learn to write each name', colorValue: 0xFFFF6B6B),
                  KeyVisualPoint(iconName: 'spellcheck', title: 'Spelling', subtitle: 'Spell out each number', colorValue: 0xFF42A5F5),
                ],
                quizQuestions: [
                  QuizQuestion(question: 'How do you write the number 3 in words?', options: ['Tree', 'Three', 'Thee', 'Thre'], correctIndex: 1, explanation: '3 is written as "three".'),
                  QuizQuestion(question: 'Which number name matches 7?', options: ['Five', 'Six', 'Seven', 'Eight'], correctIndex: 2, explanation: '7 is written as "seven".'),
                ],
              ),
            ],
          ),
          ChapterData(
            id: 'c1_math_ch2',
            title: 'Shapes Around Us',
            unitLabel: 'UNIT 2: MATHEMATICS',
            lessons: [
              LessonContent(
                id: 'c1_math_ch2_l1',
                title: 'Basic Shapes',
                description: 'Learn about circle, square, triangle, and rectangle.',
                transcript:
                    'Let us explore shapes! Shapes are everywhere around us. '
                    'A circle is round like a ball or the sun. It has no corners. '
                    'A square has 4 equal sides and 4 corners. Think of a window! '
                    'A triangle has 3 sides and 3 corners. Think of a mountain! '
                    'A rectangle has 4 sides but two are longer. Think of a door! '
                    'Can you find these shapes in your classroom?',
                durationSeconds: 350,
                captions: [
                  'Let us explore shapes!',
                  'A circle is round like a ball or the sun.',
                  'A square has 4 equal sides and 4 corners.',
                  'A triangle has 3 sides and 3 corners.',
                  'A rectangle has 4 sides but two are longer.',
                  'Can you find these shapes in your classroom?',
                ],
                keyVisualPoints: [
                  KeyVisualPoint(iconName: 'circle', title: 'Circle', subtitle: 'Round, no corners', colorValue: 0xFFFF6B6B),
                  KeyVisualPoint(iconName: 'square', title: 'Square', subtitle: '4 equal sides', colorValue: 0xFF42A5F5),
                  KeyVisualPoint(iconName: 'change_history', title: 'Triangle', subtitle: '3 sides, 3 corners', colorValue: 0xFF66BB6A),
                  KeyVisualPoint(iconName: 'rectangle', title: 'Rectangle', subtitle: '4 sides, 2 long 2 short', colorValue: 0xFFFFA726),
                ],
                quizQuestions: [
                  QuizQuestion(question: 'Which shape has no corners?', options: ['Square', 'Triangle', 'Circle', 'Rectangle'], correctIndex: 2, explanation: 'A circle is round and has no corners.'),
                  QuizQuestion(question: 'How many sides does a triangle have?', options: ['2', '3', '4', '5'], correctIndex: 1, explanation: 'A triangle has 3 sides.'),
                ],
              ),
            ],
          ),
        ],
      ),
      SubjectData(
        name: 'Science',
        iconName: 'science',
        colorValue: 0xFF4ECDC4,
        chapters: [
          ChapterData(
            id: 'c1_sci_ch1',
            title: 'My Body',
            unitLabel: 'UNIT 1: SCIENCE',
            lessons: [
              LessonContent(
                id: 'c1_sci_ch1_l1',
                title: 'Parts of My Body',
                description: 'Learn about different parts of your body and what they do.',
                transcript:
                    'Today we will learn about our body! Our body is amazing. '
                    'We have a head at the top. Our head holds our brain, which helps us think. '
                    'We have two eyes to see beautiful things around us. '
                    'We have two ears to hear sounds and music. '
                    'We have a nose to smell flowers and food. '
                    'We have a mouth to eat, drink, and talk. '
                    'We have two hands to hold things and write. '
                    'We have two legs to walk and run. '
                    'Every part of our body is important! Let us take care of our body.',
                durationSeconds: 400,
                captions: [
                  'Today we will learn about our body!',
                  'We have a head that holds our brain.',
                  'We have two eyes to see things.',
                  'We have two ears to hear sounds.',
                  'We have a nose to smell.',
                  'We have a mouth to eat, drink, and talk.',
                  'We have two hands and two legs.',
                  'Every part of our body is important!',
                ],
                keyVisualPoints: [
                  KeyVisualPoint(iconName: 'face', title: 'Head & Face', subtitle: 'Eyes, ears, nose, mouth', colorValue: 0xFF4ECDC4),
                  KeyVisualPoint(iconName: 'front_hand', title: 'Hands', subtitle: 'Hold, write, and touch', colorValue: 0xFF42A5F5),
                  KeyVisualPoint(iconName: 'directions_run', title: 'Legs', subtitle: 'Walk, run, and jump', colorValue: 0xFF66BB6A),
                  KeyVisualPoint(iconName: 'psychology', title: 'Brain', subtitle: 'Helps us think and learn', colorValue: 0xFFFF6B6B),
                ],
                quizQuestions: [
                  QuizQuestion(question: 'How many eyes do we have?', options: ['1', '2', '3', '4'], correctIndex: 1, explanation: 'We have 2 eyes to see.'),
                  QuizQuestion(question: 'What do we use to hear sounds?', options: ['Eyes', 'Nose', 'Ears', 'Mouth'], correctIndex: 2, explanation: 'We use our ears to hear sounds.'),
                  QuizQuestion(question: 'Which body part helps us think?', options: ['Hands', 'Legs', 'Nose', 'Brain'], correctIndex: 3, explanation: 'Our brain helps us think and learn.'),
                ],
                signLanguageTerms: [
                  SignLanguageTerm(term: 'Body', description: 'The physical structure of a person', handshapeDescription: 'Place both flat hands on chest then move down to stomach', category: 'Science'),
                  SignLanguageTerm(term: 'Eyes', description: 'Organs used for seeing', handshapeDescription: 'Point to your eyes with index finger', category: 'Body Parts'),
                  SignLanguageTerm(term: 'Ears', description: 'Organs used for hearing', handshapeDescription: 'Point to your ear with index finger', category: 'Body Parts'),
                ],
              ),
            ],
          ),
          ChapterData(
            id: 'c1_sci_ch2',
            title: 'Plants Around Us',
            unitLabel: 'UNIT 2: SCIENCE',
            lessons: [
              LessonContent(
                id: 'c1_sci_ch2_l1',
                title: 'Plants Around Us',
                description: 'Learn about different parts of plants and how they grow.',
                transcript:
                    'Plants are living things! They are all around us. '
                    'Plants have roots that go into the soil. Roots drink water from the ground. '
                    'Plants have a stem that stands tall. The stem carries water to the leaves. '
                    'Plants have leaves that are usually green. Leaves make food using sunlight! '
                    'Some plants have flowers that are colorful and beautiful. '
                    'Plants give us oxygen to breathe. We should take care of plants!',
                durationSeconds: 370,
                captions: [
                  'Plants are living things!',
                  'Plants have roots that drink water from the ground.',
                  'The stem stands tall and carries water to leaves.',
                  'Leaves make food using sunlight!',
                  'Some plants have colorful flowers.',
                  'Plants give us oxygen to breathe.',
                  'We should take care of plants!',
                ],
                keyVisualPoints: [
                  KeyVisualPoint(iconName: 'eco', title: 'Leaves Make Food', subtitle: 'Leaves use sunlight to make food', colorValue: 0xFF4CAF50),
                  KeyVisualPoint(iconName: 'water_drop', title: 'Roots Absorb Water', subtitle: 'Roots take water from the soil', colorValue: 0xFF2196F3),
                  KeyVisualPoint(iconName: 'vertical_align_top', title: 'Stem Supports', subtitle: 'The stem holds the plant upright', colorValue: 0xFF9C27B0),
                  KeyVisualPoint(iconName: 'air', title: 'Plants Give Oxygen', subtitle: 'Plants release fresh oxygen', colorValue: 0xFF00BCD4),
                ],
                quizQuestions: [
                  QuizQuestion(question: 'Which part of the plant makes food using sunlight?', options: ['Roots', 'Leaves', 'Stem', 'Flower'], correctIndex: 1, explanation: 'Leaves make food using sunlight through photosynthesis.'),
                  QuizQuestion(question: 'What do roots absorb from the soil?', options: ['Sunlight', 'Air', 'Water', 'Food'], correctIndex: 2, explanation: 'Roots absorb water from the soil.'),
                  QuizQuestion(question: 'What do plants give us?', options: ['Water', 'Oxygen', 'Soil', 'Rocks'], correctIndex: 1, explanation: 'Plants give us oxygen to breathe.'),
                ],
                signLanguageTerms: [
                  SignLanguageTerm(term: 'Plant', description: 'A living thing that grows in soil', handshapeDescription: 'Push one hand up through the other open hand (like growing)', category: 'Science'),
                  SignLanguageTerm(term: 'Water', description: 'Liquid needed by all living things', handshapeDescription: 'Make W hand shape and tap chin twice', category: 'Science'),
                  SignLanguageTerm(term: 'Sun', description: 'The star that gives light and warmth', handshapeDescription: 'Draw a circle in the air above, then bring fingers down like rays', category: 'Science'),
                ],
              ),
            ],
          ),
        ],
      ),
      SubjectData(
        name: 'Balbharti',
        iconName: 'auto_stories',
        colorValue: 0xFFFFA726,
        chapters: [
          ChapterData(
            id: 'c1_bal_ch1',
            title: 'मराठी अक्षरे (Marathi Alphabets)',
            unitLabel: 'UNIT 1: BALBHARTI',
            lessons: [
              LessonContent(
                id: 'c1_bal_ch1_l1',
                title: 'स्वर (Vowels)',
                description: 'Learn Marathi vowels: अ, आ, इ, ई, उ, ऊ and their sounds.',
                transcript:
                    'Welcome to Marathi! Let us learn Marathi vowels called Swar. '
                    'अ (a) - the first letter, like "a" in America. '
                    'आ (aa) - a longer sound, like "aa" in Aam (mango). '
                    'इ (i) - a short sound, like "i" in India. '
                    'ई (ee) - a longer sound, like "ee" in Eel. '
                    'उ (u) - like "u" in put. '
                    'ऊ (oo) - a longer sound, like "oo" in school. '
                    'These are the basic Marathi vowels! Practice saying them aloud.',
                durationSeconds: 400,
                captions: [
                  'Welcome to Marathi! Let us learn Swar (vowels).',
                  'अ (a) - the first letter.',
                  'आ (aa) - a longer sound, like in Aam.',
                  'इ (i) - a short sound.',
                  'ई (ee) - a longer sound.',
                  'उ (u) and ऊ (oo) - short and long sounds.',
                  'Practice saying them aloud!',
                ],
                keyVisualPoints: [
                  KeyVisualPoint(iconName: 'translate', title: 'अ - आ', subtitle: 'Short and long A sounds', colorValue: 0xFFFFA726),
                  KeyVisualPoint(iconName: 'translate', title: 'इ - ई', subtitle: 'Short and long I sounds', colorValue: 0xFF42A5F5),
                  KeyVisualPoint(iconName: 'translate', title: 'उ - ऊ', subtitle: 'Short and long U sounds', colorValue: 0xFF66BB6A),
                  KeyVisualPoint(iconName: 'record_voice_over', title: 'Practice', subtitle: 'Say each vowel aloud', colorValue: 0xFFFF6B6B),
                ],
                quizQuestions: [
                  QuizQuestion(question: 'What is the first Marathi vowel?', options: ['आ', 'अ', 'इ', 'उ'], correctIndex: 1, explanation: 'अ (a) is the first Marathi vowel.'),
                  QuizQuestion(question: 'Which vowel sounds like "oo" in school?', options: ['उ', 'ऊ', 'इ', 'अ'], correctIndex: 1, explanation: 'ऊ (oo) makes the long "oo" sound.'),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );

  // ═══════════════════════════════════════════
  // CLASS 2
  // ═══════════════════════════════════════════
  static const _class2 = ClassData(
    classNumber: 2,
    subjects: [
      SubjectData(
        name: 'English',
        iconName: 'menu_book',
        colorValue: 0xFF667EEA,
        chapters: [
          ChapterData(
            id: 'c2_eng_ch1',
            title: 'Sentence Formation',
            unitLabel: 'UNIT 1: ENGLISH',
            lessons: [
              LessonContent(
                id: 'c2_eng_ch1_l1',
                title: 'Making Simple Sentences',
                description: 'Learn to form simple sentences using subject and action words.',
                transcript:
                    'Today we will learn how to make sentences! A sentence tells us something. '
                    'Every sentence needs someone doing something. '
                    '"The cat sits." Cat is who, and sits is what the cat does. '
                    '"The dog runs." Dog is who, runs is what the dog does. '
                    '"I read a book." I is who, read is what I do. '
                    'Always start a sentence with a capital letter and end with a full stop. '
                    'Now try making your own sentences!',
                durationSeconds: 380,
                captions: [
                  'Today we will learn how to make sentences!',
                  'Every sentence needs someone doing something.',
                  '"The cat sits." - Cat is the subject.',
                  '"The dog runs." - Dog is the subject.',
                  'Start with a capital letter, end with a full stop.',
                  'Now try making your own sentences!',
                ],
                keyVisualPoints: [
                  KeyVisualPoint(iconName: 'subject', title: 'Subject', subtitle: 'Who or what the sentence is about', colorValue: 0xFF667EEA),
                  KeyVisualPoint(iconName: 'directions_run', title: 'Action Word', subtitle: 'What the subject does', colorValue: 0xFFFF6B6B),
                  KeyVisualPoint(iconName: 'text_format', title: 'Capital Letter', subtitle: 'Start every sentence with one', colorValue: 0xFF66BB6A),
                  KeyVisualPoint(iconName: 'more_horiz', title: 'Full Stop', subtitle: 'End every sentence with a period', colorValue: 0xFFFFA726),
                ],
                quizQuestions: [
                  QuizQuestion(question: 'What do you put at the end of a sentence?', options: ['Comma', 'Full stop', 'Question mark', 'Nothing'], correctIndex: 1, explanation: 'A sentence ends with a full stop (period).'),
                  QuizQuestion(question: 'In "The cat sits", what is the action word?', options: ['The', 'Cat', 'Sits', 'None'], correctIndex: 2, explanation: '"Sits" is the action word - it tells what the cat does.'),
                ],
              ),
            ],
          ),
        ],
      ),
      SubjectData(
        name: 'Mathematics',
        iconName: 'calculate',
        colorValue: 0xFFFF6B6B,
        chapters: [
          ChapterData(
            id: 'c2_math_ch1',
            title: 'Addition',
            unitLabel: 'UNIT 1: MATHEMATICS',
            lessons: [
              LessonContent(
                id: 'c2_math_ch1_l1',
                title: 'Adding Numbers',
                description: 'Learn to add numbers up to 20 using objects and fingers.',
                transcript:
                    'Today we will learn addition! Addition means putting numbers together. '
                    'If you have 2 apples and someone gives you 3 more, how many do you have? '
                    '2 plus 3 equals 5! We write it as 2 + 3 = 5. '
                    'The plus sign (+) means "add". The equals sign (=) means "the answer is". '
                    'Try these: 1 + 1 = 2. 3 + 2 = 5. 4 + 3 = 7. '
                    'You can use your fingers to count! Start with one number and count up.',
                durationSeconds: 400,
                captions: [
                  'Addition means putting numbers together.',
                  '2 apples + 3 apples = 5 apples!',
                  'We write it as 2 + 3 = 5.',
                  'The + sign means "add".',
                  'The = sign means "the answer is".',
                  'Use your fingers to count!',
                ],
                keyVisualPoints: [
                  KeyVisualPoint(iconName: 'add', title: 'Plus Sign (+)', subtitle: 'Means "add together"', colorValue: 0xFFFF6B6B),
                  KeyVisualPoint(iconName: 'drag_handle', title: 'Equals Sign (=)', subtitle: 'Means "the answer is"', colorValue: 0xFF42A5F5),
                  KeyVisualPoint(iconName: 'front_hand', title: 'Finger Counting', subtitle: 'Use fingers to help add', colorValue: 0xFF66BB6A),
                  KeyVisualPoint(iconName: 'shopping_basket', title: 'Objects Help', subtitle: 'Count apples, toys, etc.', colorValue: 0xFFFFA726),
                ],
                quizQuestions: [
                  QuizQuestion(question: 'What is 2 + 3?', options: ['4', '5', '6', '7'], correctIndex: 1, explanation: '2 plus 3 equals 5.'),
                  QuizQuestion(question: 'What does the + sign mean?', options: ['Subtract', 'Add', 'Multiply', 'Divide'], correctIndex: 1, explanation: 'The + sign means "add together".'),
                  QuizQuestion(question: 'What is 4 + 4?', options: ['6', '7', '8', '9'], correctIndex: 2, explanation: '4 plus 4 equals 8.'),
                ],
                signLanguageTerms: [
                  SignLanguageTerm(term: 'Add', description: 'To put numbers together', handshapeDescription: 'Bring both open hands together, fingertips touching', category: 'Math'),
                  SignLanguageTerm(term: 'Equals', description: 'The answer is', handshapeDescription: 'Both flat hands move together in parallel', category: 'Math'),
                ],
              ),
            ],
          ),
        ],
      ),
      SubjectData(
        name: 'Science',
        iconName: 'science',
        colorValue: 0xFF4ECDC4,
        chapters: [
          ChapterData(
            id: 'c2_sci_ch1',
            title: 'Animals Around Us',
            unitLabel: 'UNIT 1: SCIENCE',
            lessons: [
              LessonContent(
                id: 'c2_sci_ch1_l1',
                title: 'Pet Animals & Wild Animals',
                description: 'Learn the difference between pet animals and wild animals.',
                transcript:
                    'Animals are everywhere! Some live with us, and some live in forests. '
                    'Pet animals live with people. Dogs, cats, parrots, and fish are pet animals. '
                    'We take care of pet animals. We give them food and love. '
                    'Wild animals live in forests and jungles. Lions, tigers, elephants, and monkeys are wild animals. '
                    'Wild animals find their own food. We should not disturb them. '
                    'All animals are important for our world!',
                durationSeconds: 380,
                captions: [
                  'Some animals live with us, some in forests.',
                  'Dogs, cats, parrots are pet animals.',
                  'We take care of our pets.',
                  'Lions, tigers, elephants are wild animals.',
                  'Wild animals find their own food.',
                  'All animals are important!',
                ],
                keyVisualPoints: [
                  KeyVisualPoint(iconName: 'pets', title: 'Pet Animals', subtitle: 'Dogs, cats, parrots, fish', colorValue: 0xFF4ECDC4),
                  KeyVisualPoint(iconName: 'forest', title: 'Wild Animals', subtitle: 'Lions, tigers, elephants', colorValue: 0xFFFF6B6B),
                  KeyVisualPoint(iconName: 'favorite', title: 'Care for Pets', subtitle: 'Give food, water, and love', colorValue: 0xFFFFA726),
                  KeyVisualPoint(iconName: 'park', title: 'Forest Home', subtitle: 'Wild animals live in nature', colorValue: 0xFF66BB6A),
                ],
                quizQuestions: [
                  QuizQuestion(question: 'Which is a pet animal?', options: ['Lion', 'Tiger', 'Dog', 'Elephant'], correctIndex: 2, explanation: 'A dog is a pet animal that lives with people.'),
                  QuizQuestion(question: 'Where do wild animals live?', options: ['Houses', 'Schools', 'Forests', 'Cars'], correctIndex: 2, explanation: 'Wild animals live in forests and jungles.'),
                ],
              ),
            ],
          ),
        ],
      ),
      SubjectData(
        name: 'Balbharti',
        iconName: 'auto_stories',
        colorValue: 0xFFFFA726,
        chapters: [
          ChapterData(
            id: 'c2_bal_ch1',
            title: 'साधे शब्द (Simple Words)',
            unitLabel: 'UNIT 1: BALBHARTI',
            lessons: [
              LessonContent(
                id: 'c2_bal_ch1_l1',
                title: 'दोन अक्षरी शब्द (Two-Letter Words)',
                description: 'Learn simple two-letter Marathi words.',
                transcript:
                    'Let us learn simple Marathi words with two letters! '
                    'घर (ghar) means house. It is where we live. '
                    'फल (phal) means fruit. We eat fruits to stay healthy. '
                    'जल (jal) means water. We drink water every day. '
                    'Practice reading and writing these words!',
                durationSeconds: 340,
                captions: [
                  'Let us learn two-letter Marathi words!',
                  'घर means house - where we live.',
                  'फल means fruit - we eat fruits.',
                  'जल means water - we drink it daily.',
                  'Practice reading and writing!',
                ],
                keyVisualPoints: [
                  KeyVisualPoint(iconName: 'home', title: 'घर (House)', subtitle: 'Where we live', colorValue: 0xFFFFA726),
                  KeyVisualPoint(iconName: 'nutrition', title: 'फल (Fruit)', subtitle: 'Healthy food we eat', colorValue: 0xFF66BB6A),
                  KeyVisualPoint(iconName: 'water_drop', title: 'जल (Water)', subtitle: 'We drink every day', colorValue: 0xFF42A5F5),
                ],
                quizQuestions: [
                  QuizQuestion(question: 'What does घर mean?', options: ['Water', 'Fruit', 'House', 'Tree'], correctIndex: 2, explanation: 'घर means house.'),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );

  // ═══════════════════════════════════════════
  // CLASS 3
  // ═══════════════════════════════════════════
  static const _class3 = ClassData(
    classNumber: 3,
    subjects: [
      SubjectData(name: 'English', iconName: 'menu_book', colorValue: 0xFF667EEA, chapters: [
        ChapterData(id: 'c3_eng_ch1', title: 'Nouns & Pronouns', unitLabel: 'UNIT 1: ENGLISH', lessons: [
          LessonContent(id: 'c3_eng_ch1_l1', title: 'What are Nouns?', description: 'Learn about naming words - nouns.', durationSeconds: 400,
            transcript: 'A noun is a naming word. It is the name of a person, place, animal, or thing. '
                'Ram is a noun - it names a person. School is a noun - it names a place. '
                'Dog is a noun - it names an animal. Book is a noun - it names a thing. '
                'Look around you! Everything you can see and name is a noun.',
            captions: ['A noun is a naming word.', 'It names a person, place, animal, or thing.', 'Ram, school, dog, book are all nouns.', 'Everything you can name is a noun!'],
            keyVisualPoints: [KeyVisualPoint(iconName: 'person', title: 'Person', subtitle: 'Ram, teacher, mother', colorValue: 0xFF667EEA), KeyVisualPoint(iconName: 'place', title: 'Place', subtitle: 'School, park, home', colorValue: 0xFFFF6B6B), KeyVisualPoint(iconName: 'pets', title: 'Animal', subtitle: 'Dog, cat, bird', colorValue: 0xFF66BB6A), KeyVisualPoint(iconName: 'backpack', title: 'Thing', subtitle: 'Book, pen, bag', colorValue: 0xFFFFA726)],
            quizQuestions: [QuizQuestion(question: 'What is a noun?', options: ['An action word', 'A naming word', 'A describing word', 'A joining word'], correctIndex: 1, explanation: 'A noun is a naming word for people, places, animals, and things.'), QuizQuestion(question: 'Which of these is a noun?', options: ['Run', 'Beautiful', 'School', 'Quickly'], correctIndex: 2, explanation: 'School is a noun because it names a place.')],
          ),
        ]),
      ]),
      SubjectData(name: 'Mathematics', iconName: 'calculate', colorValue: 0xFFFF6B6B, chapters: [
        ChapterData(id: 'c3_math_ch1', title: 'Multiplication', unitLabel: 'UNIT 1: MATHEMATICS', lessons: [
          LessonContent(id: 'c3_math_ch1_l1', title: 'Learning Multiplication', description: 'Understand multiplication as repeated addition.', durationSeconds: 420,
            transcript: 'Multiplication is a quick way to add the same number many times! '
                'If you have 3 groups of 2 apples, you can say 3 times 2 equals 6. '
                'We write it as 3 × 2 = 6. The times sign (×) means "groups of". '
                '2 × 4 means 2 groups of 4, which is 4 + 4 = 8. '
                '5 × 3 means 5 groups of 3, which is 3 + 3 + 3 + 3 + 3 = 15. '
                'Multiplication tables help us learn these quickly!',
            captions: ['Multiplication is repeated addition!', '3 groups of 2 = 3 × 2 = 6.', 'The × sign means "groups of".', '5 × 3 = 3+3+3+3+3 = 15.', 'Learn multiplication tables!'],
            keyVisualPoints: [KeyVisualPoint(iconName: 'close', title: 'Times Sign (×)', subtitle: 'Means "groups of"', colorValue: 0xFFFF6B6B), KeyVisualPoint(iconName: 'grid_view', title: 'Groups', subtitle: 'Think in groups of objects', colorValue: 0xFF42A5F5)],
            quizQuestions: [QuizQuestion(question: 'What is 3 × 2?', options: ['5', '6', '7', '8'], correctIndex: 1, explanation: '3 times 2 equals 6.'), QuizQuestion(question: 'What does 4 × 3 mean?', options: ['4 + 3', '4 groups of 3', '4 minus 3', '4 divided by 3'], correctIndex: 1, explanation: '4 × 3 means 4 groups of 3.')],
          ),
        ]),
      ]),
      SubjectData(name: 'Science', iconName: 'science', colorValue: 0xFF4ECDC4, chapters: [
        ChapterData(id: 'c3_sci_ch1', title: 'Food & Nutrition', unitLabel: 'UNIT 1: SCIENCE', lessons: [
          LessonContent(id: 'c3_sci_ch1_l1', title: 'Healthy Food', description: 'Learn about different food groups and healthy eating.', durationSeconds: 380,
            transcript: 'Food gives us energy to play, study, and grow! '
                'There are different types of food. Fruits and vegetables give vitamins. '
                'Milk, cheese, and eggs give us proteins to grow strong. '
                'Rice, bread, and chapati give us energy to play. '
                'We should eat all types of food to stay healthy. '
                'Drink plenty of water every day! Junk food is not good for health.',
            captions: ['Food gives us energy!', 'Fruits and vegetables have vitamins.', 'Milk and eggs give proteins.', 'Rice and bread give energy.', 'Eat all food types!', 'Drink water and avoid junk food.'],
            keyVisualPoints: [KeyVisualPoint(iconName: 'nutrition', title: 'Fruits & Veggies', subtitle: 'Vitamins for good health', colorValue: 0xFF66BB6A), KeyVisualPoint(iconName: 'egg', title: 'Proteins', subtitle: 'Milk, eggs, cheese for growth', colorValue: 0xFFFFA726), KeyVisualPoint(iconName: 'rice_bowl', title: 'Carbohydrates', subtitle: 'Rice, bread for energy', colorValue: 0xFF42A5F5), KeyVisualPoint(iconName: 'water_drop', title: 'Water', subtitle: 'Drink plenty every day', colorValue: 0xFF4ECDC4)],
            quizQuestions: [QuizQuestion(question: 'Which food gives us vitamins?', options: ['Rice', 'Fruits', 'Bread', 'Butter'], correctIndex: 1, explanation: 'Fruits and vegetables give us vitamins.'), QuizQuestion(question: 'Why should we eat different types of food?', options: ['For taste only', 'To stay healthy', 'Because teachers say so', 'No reason'], correctIndex: 1, explanation: 'Eating different foods gives our body all the nutrients it needs.')],
          ),
        ]),
      ]),
      SubjectData(name: 'Balbharti', iconName: 'auto_stories', colorValue: 0xFFFFA726, chapters: [
        ChapterData(id: 'c3_bal_ch1', title: 'वाक्य रचना (Sentences)', unitLabel: 'UNIT 1: BALBHARTI', lessons: [
          LessonContent(id: 'c3_bal_ch1_l1', title: 'साधी वाक्ये (Simple Sentences)', description: 'Learn to form simple Marathi sentences.', durationSeconds: 360,
            transcript: 'Let us make Marathi sentences! मी शाळेत जातो means "I go to school." '
                'ती पुस्तक वाचते means "She reads a book." '
                'Every Marathi sentence has a subject, object, and verb. '
                'The verb usually comes at the end in Marathi!',
            captions: ['Let us make Marathi sentences!', 'मी शाळेत जातो - I go to school.', 'ती पुस्तक वाचते - She reads a book.', 'The verb comes at the end in Marathi!'],
            keyVisualPoints: [KeyVisualPoint(iconName: 'school', title: 'शाळा (School)', subtitle: 'Common noun in sentences', colorValue: 0xFFFFA726), KeyVisualPoint(iconName: 'menu_book', title: 'पुस्तक (Book)', subtitle: 'Object in the sentence', colorValue: 0xFF42A5F5)],
            quizQuestions: [QuizQuestion(question: 'Where does the verb go in a Marathi sentence?', options: ['Beginning', 'Middle', 'End', 'Anywhere'], correctIndex: 2, explanation: 'The verb usually comes at the end in Marathi.')],
          ),
        ]),
      ]),
    ],
  );

  // ═══════════════════════════════════════════
  // CLASS 4
  // ═══════════════════════════════════════════
  static const _class4 = ClassData(
    classNumber: 4,
    subjects: [
      SubjectData(name: 'English', iconName: 'menu_book', colorValue: 0xFF667EEA, chapters: [
        ChapterData(id: 'c4_eng_ch1', title: 'Tenses', unitLabel: 'UNIT 1: ENGLISH', lessons: [
          LessonContent(id: 'c4_eng_ch1_l1', title: 'Past, Present, Future', description: 'Learn about the three tenses in English.', durationSeconds: 420,
            transcript: 'Time tells us when something happens. In English, we have 3 tenses. '
                'Present tense is happening NOW. "I eat lunch." "She plays cricket." '
                'Past tense ALREADY happened. "I ate lunch." "She played cricket yesterday." '
                'Future tense WILL happen. "I will eat lunch." "She will play cricket tomorrow." '
                'Notice how the verb changes! Eat → ate → will eat.',
            captions: ['English has 3 tenses: past, present, future.', 'Present: happening now.', 'Past: already happened.', 'Future: will happen.', 'The verb changes for each tense!'],
            keyVisualPoints: [KeyVisualPoint(iconName: 'today', title: 'Present Tense', subtitle: 'Happening right now', colorValue: 0xFF667EEA), KeyVisualPoint(iconName: 'history', title: 'Past Tense', subtitle: 'Already happened', colorValue: 0xFFFF6B6B), KeyVisualPoint(iconName: 'update', title: 'Future Tense', subtitle: 'Will happen later', colorValue: 0xFF66BB6A)],
            quizQuestions: [QuizQuestion(question: '"I played cricket" is in which tense?', options: ['Present', 'Past', 'Future', 'None'], correctIndex: 1, explanation: '"Played" is past tense - it already happened.'), QuizQuestion(question: 'Which is future tense?', options: ['I run', 'I ran', 'I will run', 'I running'], correctIndex: 2, explanation: '"Will run" shows future tense.')],
          ),
        ]),
      ]),
      SubjectData(name: 'Mathematics', iconName: 'calculate', colorValue: 0xFFFF6B6B, chapters: [
        ChapterData(id: 'c4_math_ch1', title: 'Fractions', unitLabel: 'UNIT 1: MATHEMATICS', lessons: [
          LessonContent(id: 'c4_math_ch1_l1', title: 'Understanding Fractions', description: 'Learn what fractions are with everyday examples.', durationSeconds: 400,
            transcript: 'A fraction is a part of a whole! If you cut a pizza into 4 equal slices and take 1, you have 1/4 (one-fourth). '
                'The top number is called numerator - it tells how many parts you have. '
                'The bottom number is called denominator - it tells total equal parts. '
                'Half means 1/2. One-third means 1/3. One-fourth means 1/4.',
            captions: ['A fraction is a part of a whole.', '1 slice of 4 = one-fourth (1/4).', 'Top number = numerator (parts you have).', 'Bottom number = denominator (total parts).', 'Half = 1/2, one-third = 1/3.'],
            keyVisualPoints: [KeyVisualPoint(iconName: 'pie_chart', title: 'Numerator', subtitle: 'How many parts you took', colorValue: 0xFFFF6B6B), KeyVisualPoint(iconName: 'donut_large', title: 'Denominator', subtitle: 'Total equal parts', colorValue: 0xFF42A5F5)],
            quizQuestions: [QuizQuestion(question: 'If a pizza has 4 slices and you eat 1, what fraction did you eat?', options: ['1/2', '1/3', '1/4', '3/4'], correctIndex: 2, explanation: '1 out of 4 slices = 1/4 (one-fourth).'), QuizQuestion(question: 'In the fraction 3/5, what is the denominator?', options: ['3', '5', '8', '15'], correctIndex: 1, explanation: 'The denominator (bottom number) is 5.')],
          ),
        ]),
      ]),
      SubjectData(name: 'Science', iconName: 'science', colorValue: 0xFF4ECDC4, chapters: [
        ChapterData(id: 'c4_sci_ch1', title: 'The Solar System', unitLabel: 'UNIT 1: SCIENCE', lessons: [
          LessonContent(id: 'c4_sci_ch1_l1', title: 'Our Solar System', description: 'Learn about the sun, planets, and our place in space.', durationSeconds: 450,
            transcript: 'Our Solar System is in space! The Sun is a giant star at the center. '
                '8 planets orbit around the Sun. Mercury is closest, then Venus, Earth, Mars. '
                'Earth is our home planet - the only one with life! '
                'Jupiter is the largest planet. Saturn has beautiful rings. '
                'Uranus and Neptune are the farthest, very cold planets.',
            captions: ['The Sun is at the center of our Solar System.', '8 planets orbit the Sun.', 'Earth is our home - the only planet with life!', 'Jupiter is the biggest, Saturn has rings.', 'Uranus and Neptune are farthest and coldest.'],
            keyVisualPoints: [KeyVisualPoint(iconName: 'wb_sunny', title: 'The Sun', subtitle: 'Giant star at the center', colorValue: 0xFFFFA726), KeyVisualPoint(iconName: 'public', title: 'Earth', subtitle: 'Our home planet', colorValue: 0xFF42A5F5), KeyVisualPoint(iconName: 'blur_circular', title: 'Saturn', subtitle: 'Has beautiful rings', colorValue: 0xFF9C27B0), KeyVisualPoint(iconName: 'rocket', title: '8 Planets', subtitle: 'Mercury to Neptune', colorValue: 0xFFFF6B6B)],
            quizQuestions: [QuizQuestion(question: 'How many planets are in our Solar System?', options: ['6', '7', '8', '9'], correctIndex: 2, explanation: 'There are 8 planets in our Solar System.'), QuizQuestion(question: 'Which planet has rings?', options: ['Mars', 'Jupiter', 'Saturn', 'Venus'], correctIndex: 2, explanation: 'Saturn is famous for its beautiful rings.')],
          ),
        ]),
      ]),
      SubjectData(name: 'Balbharti', iconName: 'auto_stories', colorValue: 0xFFFFA726, chapters: [
        ChapterData(id: 'c4_bal_ch1', title: 'कविता (Poetry)', unitLabel: 'UNIT 1: BALBHARTI', lessons: [
          LessonContent(id: 'c4_bal_ch1_l1', title: 'छान छान गाणी (Beautiful Songs)', description: 'Learn and enjoy Marathi poems and rhymes.', durationSeconds: 350,
            transcript: 'Poetry in Marathi is called "Kavita". Poems have rhythm and rhyme. '
                'They express feelings beautifully. Let us read a simple poem about nature. '
                'झाडे हिरवी रान हिरवं, means the trees are green, the forest is green. '
                'Poems help us feel and imagine beautiful things!',
            captions: ['Marathi poetry is called Kavita.', 'Poems have rhythm and rhyme.', 'झाडे हिरवी रान हिरवं = Trees are green.', 'Poetry helps us feel and imagine!'],
            keyVisualPoints: [KeyVisualPoint(iconName: 'music_note', title: 'Rhythm', subtitle: 'Poems have a beat', colorValue: 0xFFFFA726), KeyVisualPoint(iconName: 'favorite', title: 'Feelings', subtitle: 'Poems express emotions', colorValue: 0xFFFF6B6B)],
            quizQuestions: [QuizQuestion(question: 'What is poetry called in Marathi?', options: ['गाणे', 'कविता', 'कथा', 'निबंध'], correctIndex: 1, explanation: 'Poetry is called कविता (Kavita) in Marathi.')],
          ),
        ]),
      ]),
    ],
  );

  // ═══════════════════════════════════════════
  // CLASSES 5-9 (Structured with age-appropriate content)
  // ═══════════════════════════════════════════
  static const _class5 = ClassData(
    classNumber: 5,
    subjects: [
      SubjectData(name: 'English', iconName: 'menu_book', colorValue: 0xFF667EEA, chapters: [
        ChapterData(id: 'c5_eng_ch1', title: 'Parts of Speech', unitLabel: 'UNIT 1: ENGLISH', lessons: [
          LessonContent(id: 'c5_eng_ch1_l1', title: 'Adjectives - Describing Words', description: 'Learn how adjectives make sentences colorful.', durationSeconds: 400,
            transcript: 'Adjectives are describing words! They tell us more about a noun. '
                '"The big dog" - big is an adjective describing the dog. '
                '"A beautiful flower" - beautiful describes the flower. '
                'Adjectives can describe size (big, small), color (red, blue), shape (round, square), or feeling (happy, sad). '
                'Try adding adjectives to make your sentences more interesting!',
            captions: ['Adjectives are describing words.', '"Big" in "big dog" is an adjective.', 'They describe size, color, shape, feeling.', 'Add adjectives for better sentences!'],
            keyVisualPoints: [KeyVisualPoint(iconName: 'straighten', title: 'Size', subtitle: 'Big, small, tall, short', colorValue: 0xFF667EEA), KeyVisualPoint(iconName: 'palette', title: 'Color', subtitle: 'Red, blue, green, yellow', colorValue: 0xFFFF6B6B)],
            quizQuestions: [QuizQuestion(question: 'In "The tall boy", which word is the adjective?', options: ['The', 'Tall', 'Boy', 'None'], correctIndex: 1, explanation: '"Tall" is the adjective describing the boy.')],
          ),
        ]),
      ]),
      SubjectData(name: 'Mathematics', iconName: 'calculate', colorValue: 0xFFFF6B6B, chapters: [
        ChapterData(id: 'c5_math_ch1', title: 'Decimals', unitLabel: 'UNIT 1: MATHEMATICS', lessons: [
          LessonContent(id: 'c5_math_ch1_l1', title: 'Introduction to Decimals', description: 'Learn what decimals are and how to use them.', durationSeconds: 420,
            transcript: 'Decimals are numbers with a dot (point) in them! '
                'The dot is called a "decimal point". It separates whole numbers from parts. '
                '2.5 means 2 and a half. The 5 is in the tenths place. '
                'Money uses decimals too! ₹10.50 means 10 rupees and 50 paise. '
                'Decimals help us be more exact with numbers.',
            captions: ['Decimals have a dot called "decimal point".', '2.5 means 2 and a half.', 'Money uses decimals: ₹10.50.', 'Decimals help us be more exact!'],
            keyVisualPoints: [KeyVisualPoint(iconName: 'more_horiz', title: 'Decimal Point', subtitle: 'Separates whole and parts', colorValue: 0xFFFF6B6B), KeyVisualPoint(iconName: 'currency_rupee', title: 'Money', subtitle: '₹10.50 uses decimals', colorValue: 0xFF66BB6A)],
            quizQuestions: [QuizQuestion(question: 'What does 3.5 mean?', options: ['35', '3 and a half', '3 point 5 hundred', '350'], correctIndex: 1, explanation: '3.5 means 3 and a half (3 + 0.5).')],
          ),
        ]),
      ]),
      SubjectData(name: 'Science', iconName: 'science', colorValue: 0xFF4ECDC4, chapters: [
        ChapterData(id: 'c5_sci_ch1', title: 'States of Matter', unitLabel: 'UNIT 1: SCIENCE', lessons: [
          LessonContent(id: 'c5_sci_ch1_l1', title: 'Solid, Liquid, Gas', description: 'Learn about the three states of matter.', durationSeconds: 400,
            transcript: 'Everything around us is matter! Matter exists in 3 states. '
                'Solid: Has a fixed shape. Examples: rocks, books, tables. You can hold them! '
                'Liquid: Takes the shape of its container. Examples: water, milk, juice. They flow! '
                'Gas: Fills up any space. Examples: air, steam, smoke. You often cannot see gases! '
                'Matter can change states! Ice (solid) melts into water (liquid), which boils into steam (gas).',
            captions: ['Matter exists in 3 states: solid, liquid, gas.', 'Solids have a fixed shape.', 'Liquids take the shape of their container.', 'Gases fill up any space.', 'Matter can change states: ice → water → steam!'],
            keyVisualPoints: [KeyVisualPoint(iconName: 'inventory_2', title: 'Solid', subtitle: 'Fixed shape, you can hold it', colorValue: 0xFF42A5F5), KeyVisualPoint(iconName: 'water_drop', title: 'Liquid', subtitle: 'Flows, takes container shape', colorValue: 0xFF4ECDC4), KeyVisualPoint(iconName: 'cloud', title: 'Gas', subtitle: 'Fills any space, often invisible', colorValue: 0xFF9C27B0)],
            quizQuestions: [QuizQuestion(question: 'Which state of matter has a fixed shape?', options: ['Liquid', 'Gas', 'Solid', 'Plasma'], correctIndex: 2, explanation: 'Solids have a fixed shape.'), QuizQuestion(question: 'What state is steam?', options: ['Solid', 'Liquid', 'Gas', 'None'], correctIndex: 2, explanation: 'Steam is water in gas form.')],
          ),
        ]),
      ]),
      SubjectData(name: 'Balbharti', iconName: 'auto_stories', colorValue: 0xFFFFA726, chapters: [
        ChapterData(id: 'c5_bal_ch1', title: 'निबंध लेखन (Essay Writing)', unitLabel: 'UNIT 1: BALBHARTI', lessons: [
          LessonContent(id: 'c5_bal_ch1_l1', title: 'माझी शाळा (My School)', description: 'Learn to write an essay about your school.', durationSeconds: 380,
            transcript: 'Let us learn to write an essay in Marathi! An essay has an introduction, body, and conclusion. '
                'माझी शाळा खूप छान आहे means "My school is very nice." '
                'शाळेत आम्ही अभ्यास करतो means "In school, we study." '
                'Good essays have clear sentences and express your thoughts well.',
            captions: ['An essay has introduction, body, conclusion.', 'माझी शाळा खूप छान आहे = My school is very nice.', 'Express your thoughts clearly!'],
            keyVisualPoints: [KeyVisualPoint(iconName: 'article', title: 'Introduction', subtitle: 'Start with the topic', colorValue: 0xFFFFA726), KeyVisualPoint(iconName: 'format_list_bulleted', title: 'Body', subtitle: 'Main points and details', colorValue: 0xFF42A5F5)],
            quizQuestions: [QuizQuestion(question: 'What are the parts of an essay?', options: ['Start and end', 'Intro, Body, Conclusion', 'Title only', 'Poem and story'], correctIndex: 1, explanation: 'An essay has introduction, body, and conclusion.')],
          ),
        ]),
      ]),
    ],
  );

  static const _class6 = ClassData(
    classNumber: 6,
    subjects: [
      SubjectData(name: 'English', iconName: 'menu_book', colorValue: 0xFF667EEA, chapters: [
        ChapterData(id: 'c6_eng_ch1', title: 'Active & Passive Voice', unitLabel: 'UNIT 1: ENGLISH', lessons: [
          LessonContent(id: 'c6_eng_ch1_l1', title: 'Active and Passive Voice', description: 'Learn to change sentences between active and passive voice.', durationSeconds: 420,
            transcript: 'In active voice, the subject performs the action. "Ram eats the apple." Ram is doing the eating. '
                'In passive voice, the subject receives the action. "The apple is eaten by Ram." The apple receives the action. '
                'Active: Subject + Verb + Object. Passive: Object + is/was + Verb(past participle) + by Subject.',
            captions: ['Active voice: subject does the action.', 'Passive voice: subject receives the action.', '"Ram eats apple" → "Apple is eaten by Ram".', 'Both sentences mean the same thing!'],
            keyVisualPoints: [KeyVisualPoint(iconName: 'trending_up', title: 'Active Voice', subtitle: 'Subject does the action', colorValue: 0xFF667EEA), KeyVisualPoint(iconName: 'trending_down', title: 'Passive Voice', subtitle: 'Subject receives action', colorValue: 0xFFFF6B6B)],
            quizQuestions: [QuizQuestion(question: '"The ball was kicked by Raj." Which voice is this?', options: ['Active', 'Passive', 'Both', 'Neither'], correctIndex: 1, explanation: 'This is passive voice because the ball (object) is the subject.')],
          ),
        ]),
      ]),
      SubjectData(name: 'Mathematics', iconName: 'calculate', colorValue: 0xFFFF6B6B, chapters: [
        ChapterData(id: 'c6_math_ch1', title: 'Algebra Basics', unitLabel: 'UNIT 1: MATHEMATICS', lessons: [
          LessonContent(id: 'c6_math_ch1_l1', title: 'Introduction to Algebra', description: 'Learn what variables are and how to use them.', durationSeconds: 450,
            transcript: 'Algebra uses letters to represent unknown numbers! '
                'If x + 3 = 7, what is x? We need to find the number that plus 3 gives 7. '
                'x = 4 because 4 + 3 = 7! '
                'Variables are like empty boxes waiting to be filled with the right number.',
            captions: ['Algebra uses letters for unknowns!', 'x + 3 = 7, what is x?', 'x = 4 because 4 + 3 = 7!', 'Variables are like empty boxes.'],
            keyVisualPoints: [KeyVisualPoint(iconName: 'help', title: 'Variable', subtitle: 'A letter representing a number', colorValue: 0xFFFF6B6B), KeyVisualPoint(iconName: 'functions', title: 'Equation', subtitle: 'A math sentence with equals', colorValue: 0xFF42A5F5)],
            quizQuestions: [QuizQuestion(question: 'If x + 5 = 10, what is x?', options: ['3', '4', '5', '6'], correctIndex: 2, explanation: 'x = 5 because 5 + 5 = 10.')],
          ),
        ]),
      ]),
      SubjectData(name: 'Science', iconName: 'science', colorValue: 0xFF4ECDC4, chapters: [
        ChapterData(id: 'c6_sci_ch1', title: 'Light & Shadows', unitLabel: 'UNIT 1: SCIENCE', lessons: [
          LessonContent(id: 'c6_sci_ch1_l1', title: 'How Light Travels', description: 'Learn about light, reflection, and shadows.', durationSeconds: 420,
            transcript: 'Light always travels in straight lines! When light hits an opaque object, it creates a shadow. '
                'Transparent objects like glass let light pass through completely. '
                'Translucent objects like frosted glass let some light through. '
                'Opaque objects like wood block all light. '
                'Reflection happens when light bounces off a surface, like a mirror!',
            captions: ['Light travels in straight lines.', 'Shadows form behind opaque objects.', 'Transparent = light passes through.', 'Opaque = light is blocked.', 'Mirrors reflect light!'],
            keyVisualPoints: [KeyVisualPoint(iconName: 'light_mode', title: 'Light', subtitle: 'Travels in straight lines', colorValue: 0xFFFFA726), KeyVisualPoint(iconName: 'dark_mode', title: 'Shadow', subtitle: 'Formed when light is blocked', colorValue: 0xFF424242)],
            quizQuestions: [QuizQuestion(question: 'How does light travel?', options: ['In curves', 'In circles', 'In straight lines', 'In zigzag'], correctIndex: 2, explanation: 'Light always travels in straight lines.')],
          ),
        ]),
      ]),
      SubjectData(name: 'Balbharti', iconName: 'auto_stories', colorValue: 0xFFFFA726, chapters: [
        ChapterData(id: 'c6_bal_ch1', title: 'गोष्टी व बोधकथा (Stories)', unitLabel: 'UNIT 1: BALBHARTI', lessons: [
          LessonContent(id: 'c6_bal_ch1_l1', title: 'बोधकथा - कावळा आणि कोल्हा', description: 'The famous Marathi moral story of the crow and the fox.', durationSeconds: 380,
            transcript: 'एक कावळा एका झाडावर बसला होता. त्याच्या चोचीत चीजचा एक तुकडा होता. '
                'एक धूर्त कोल्हा आला आणि त्याने कावळ्याची स्तुती केली. '
                '"किती सुंदर आवाज आहे तुमचा! गाणे गा ना!" '
                'कावळ्याने गाणे गायला चोच उघडली आणि चीज खाली पडले! '
                'बोधः खुशामत करणाऱ्यांपासून सावध राहा!',
            captions: ['A crow sat on a tree with cheese in its beak.', 'A clever fox came and flattered the crow.', '"Your voice is so beautiful! Sing for me!"', 'The crow opened its beak to sing and the cheese fell!', 'Moral: Beware of flatterers!'],
            keyVisualPoints: [KeyVisualPoint(iconName: 'pets', title: 'कावळा (Crow)', subtitle: 'Had cheese in its beak', colorValue: 0xFF424242), KeyVisualPoint(iconName: 'psychology', title: 'Moral', subtitle: 'Beware of flatterers!', colorValue: 0xFFFFA726)],
            quizQuestions: [QuizQuestion(question: 'What is the moral of the crow and fox story?', options: ['Be kind to animals', 'Beware of flatterers', 'Share food', 'Sing every day'], correctIndex: 1, explanation: 'The moral is to beware of those who flatter you for selfish reasons.')],
          ),
        ]),
      ]),
    ],
  );

  static const _class7 = ClassData(
    classNumber: 7,
    subjects: [
      SubjectData(name: 'English', iconName: 'menu_book', colorValue: 0xFF667EEA, chapters: [
        ChapterData(id: 'c7_eng_ch1', title: 'Comprehension', unitLabel: 'UNIT 1: ENGLISH', lessons: [
          LessonContent(id: 'c7_eng_ch1_l1', title: 'Reading Comprehension', description: 'Learn techniques to understand passages and answer questions.', durationSeconds: 420,
            transcript: 'Reading comprehension means understanding what you read. '
                'Step 1: Read the passage carefully. Step 2: Identify the main idea. '
                'Step 3: Look for key details. Step 4: Answer questions using evidence from the text. '
                'Always go back to the passage to find your answers!',
            captions: ['Comprehension = understanding what you read.', 'Step 1: Read carefully.', 'Step 2: Find the main idea.', 'Step 3: Look for key details.', 'Use evidence from the text!'],
            keyVisualPoints: [KeyVisualPoint(iconName: 'search', title: 'Read Carefully', subtitle: 'Understand each sentence', colorValue: 0xFF667EEA), KeyVisualPoint(iconName: 'lightbulb', title: 'Main Idea', subtitle: 'What is the passage about?', colorValue: 0xFFFFA726)],
            quizQuestions: [QuizQuestion(question: 'What is the first step in reading comprehension?', options: ['Answer questions', 'Read the passage carefully', 'Write a summary', 'Ask the teacher'], correctIndex: 1, explanation: 'Always start by reading the passage carefully.')],
          ),
        ]),
      ]),
      SubjectData(name: 'Mathematics', iconName: 'calculate', colorValue: 0xFFFF6B6B, chapters: [
        ChapterData(id: 'c7_math_ch1', title: 'Geometry', unitLabel: 'UNIT 1: MATHEMATICS', lessons: [
          LessonContent(id: 'c7_math_ch1_l1', title: 'Triangles & Their Properties', description: 'Learn about types of triangles and their angles.', durationSeconds: 420,
            transcript: 'A triangle has 3 sides and 3 angles. The sum of all angles is always 180 degrees! '
                'Equilateral triangle: All 3 sides equal, all angles 60 degrees. '
                'Isosceles triangle: 2 sides equal, 2 angles equal. '
                'Scalene triangle: No sides equal, no angles equal. '
                'Right triangle: One angle is exactly 90 degrees!',
            captions: ['A triangle has 3 sides, 3 angles.', 'Angles always add up to 180°.', 'Equilateral: all sides and angles equal.', 'Right triangle: has one 90° angle.'],
            keyVisualPoints: [KeyVisualPoint(iconName: 'change_history', title: 'Triangle', subtitle: '3 sides, angles sum to 180°', colorValue: 0xFFFF6B6B), KeyVisualPoint(iconName: 'square_foot', title: 'Right Triangle', subtitle: 'Has one 90° angle', colorValue: 0xFF42A5F5)],
            quizQuestions: [QuizQuestion(question: 'What is the sum of angles in a triangle?', options: ['90°', '180°', '270°', '360°'], correctIndex: 1, explanation: 'The sum of all angles in a triangle is always 180 degrees.')],
          ),
        ]),
      ]),
      SubjectData(name: 'Science', iconName: 'science', colorValue: 0xFF4ECDC4, chapters: [
        ChapterData(id: 'c7_sci_ch1', title: 'Acids, Bases & Salts', unitLabel: 'UNIT 1: SCIENCE', lessons: [
          LessonContent(id: 'c7_sci_ch1_l1', title: 'Understanding Acids and Bases', description: 'Learn what makes something an acid or a base.', durationSeconds: 420,
            transcript: 'Acids taste sour! Lemon juice and vinegar are acids. '
                'Bases taste bitter and feel slippery! Soap and baking soda are bases. '
                'We use litmus paper to test: acids turn blue litmus red, bases turn red litmus blue. '
                'When an acid and base mix, they make a salt and water! This is called neutralization.',
            captions: ['Acids taste sour (lemon, vinegar).', 'Bases taste bitter (soap, baking soda).', 'Litmus paper tests: acid=red, base=blue.', 'Acid + Base = Salt + Water (neutralization)!'],
            keyVisualPoints: [KeyVisualPoint(iconName: 'science', title: 'Acids', subtitle: 'Sour taste, turn litmus red', colorValue: 0xFFFF6B6B), KeyVisualPoint(iconName: 'cleaning_services', title: 'Bases', subtitle: 'Bitter taste, turn litmus blue', colorValue: 0xFF42A5F5)],
            quizQuestions: [QuizQuestion(question: 'What happens when an acid and base mix?', options: ['Explosion', 'They form salt and water', 'Nothing', 'They evaporate'], correctIndex: 1, explanation: 'Acids and bases undergo neutralization to form salt and water.')],
          ),
        ]),
      ]),
      SubjectData(name: 'Balbharti', iconName: 'auto_stories', colorValue: 0xFFFFA726, chapters: [
        ChapterData(id: 'c7_bal_ch1', title: 'व्याकरण (Grammar)', unitLabel: 'UNIT 1: BALBHARTI', lessons: [
          LessonContent(id: 'c7_bal_ch1_l1', title: 'विभक्ती (Cases)', description: 'Learn Marathi grammar cases for sentence construction.', durationSeconds: 400,
            transcript: 'Vibhakti are grammatical cases in Marathi that show relationship between words. '
                'प्रथमा: राम (Ram - subject). द्वितीया: रामाला (to Ram). '
                'तृतीया: रामाने (by Ram). चतुर्थी: रामासाठी (for Ram). '
                'Understanding vibhakti is key to proper Marathi sentences!',
            captions: ['Vibhakti = grammatical cases in Marathi.', 'प्रथमा: राम (subject).', 'द्वितीया: रामाला (to).', 'तृतीया: रामाने (by).', 'Key to proper Marathi sentences!'],
            keyVisualPoints: [KeyVisualPoint(iconName: 'format_list_numbered', title: 'Cases', subtitle: '8 vibhakti in Marathi', colorValue: 0xFFFFA726), KeyVisualPoint(iconName: 'translate', title: 'Usage', subtitle: 'Shows word relationships', colorValue: 0xFF42A5F5)],
            quizQuestions: [QuizQuestion(question: 'What do vibhakti show in Marathi?', options: ['Tense', 'Relationship between words', 'Rhyme', 'Spelling'], correctIndex: 1, explanation: 'Vibhakti show the grammatical relationship between words in a sentence.')],
          ),
        ]),
      ]),
    ],
  );

  static const _class8 = ClassData(
    classNumber: 8,
    subjects: [
      SubjectData(name: 'English', iconName: 'menu_book', colorValue: 0xFF667EEA, chapters: [
        ChapterData(id: 'c8_eng_ch1', title: 'Essay & Letter Writing', unitLabel: 'UNIT 1: ENGLISH', lessons: [
          LessonContent(id: 'c8_eng_ch1_l1', title: 'Formal Letter Writing', description: 'Learn the format and language of formal letters.', durationSeconds: 420,
            transcript: 'A formal letter has a specific format. At the top, write your address and date. '
                'Then the recipient\'s address. The salutation is "Dear Sir/Madam". '
                'The body has 3 parts: introduction (why you are writing), main content, and conclusion. '
                'End with "Yours faithfully" if you don\'t know the name, "Yours sincerely" if you do.',
            captions: ['Formal letters have a specific format.', 'Include your address and date at the top.', 'Salutation: Dear Sir/Madam.', 'Body: introduction, content, conclusion.', 'End with Yours faithfully/sincerely.'],
            keyVisualPoints: [KeyVisualPoint(iconName: 'mail', title: 'Format', subtitle: 'Address, date, salutation', colorValue: 0xFF667EEA), KeyVisualPoint(iconName: 'article', title: 'Body', subtitle: 'Intro, content, conclusion', colorValue: 0xFF42A5F5)],
            quizQuestions: [QuizQuestion(question: 'How do you end a formal letter to someone you don\'t know?', options: ['Yours sincerely', 'Yours faithfully', 'Love', 'Thanks'], correctIndex: 1, explanation: 'Use "Yours faithfully" when you don\'t know the recipient\'s name.')],
          ),
        ]),
      ]),
      SubjectData(name: 'Mathematics', iconName: 'calculate', colorValue: 0xFFFF6B6B, chapters: [
        ChapterData(id: 'c8_math_ch1', title: 'Linear Equations', unitLabel: 'UNIT 1: MATHEMATICS', lessons: [
          LessonContent(id: 'c8_math_ch1_l1', title: 'Solving Linear Equations', description: 'Learn to solve equations with one variable.', durationSeconds: 450,
            transcript: 'A linear equation has variables with power 1. Like 2x + 3 = 11. '
                'To solve, we isolate x. Step 1: Move 3 to the other side. 2x = 11 - 3 = 8. '
                'Step 2: Divide both sides by 2. x = 8 ÷ 2 = 4. '
                'Check: 2(4) + 3 = 8 + 3 = 11. Correct! '
                'Always verify your answer by substituting back!',
            captions: ['Linear equations have variables with power 1.', '2x + 3 = 11. Move 3: 2x = 8.', 'Divide by 2: x = 4.', 'Check: 2(4) + 3 = 11. Correct!', 'Always verify by substituting back!'],
            keyVisualPoints: [KeyVisualPoint(iconName: 'functions', title: 'Equation', subtitle: '2x + 3 = 11', colorValue: 0xFFFF6B6B), KeyVisualPoint(iconName: 'check_circle', title: 'Verify', subtitle: 'Always check your answer', colorValue: 0xFF66BB6A)],
            quizQuestions: [QuizQuestion(question: 'Solve: 3x + 6 = 15', options: ['x = 2', 'x = 3', 'x = 4', 'x = 5'], correctIndex: 1, explanation: '3x = 15 - 6 = 9, so x = 9 ÷ 3 = 3.')],
          ),
        ]),
      ]),
      SubjectData(name: 'Science', iconName: 'science', colorValue: 0xFF4ECDC4, chapters: [
        ChapterData(id: 'c8_sci_ch1', title: 'Force & Pressure', unitLabel: 'UNIT 1: SCIENCE', lessons: [
          LessonContent(id: 'c8_sci_ch1_l1', title: 'Understanding Forces', description: 'Learn about force, pressure, and their effects.', durationSeconds: 420,
            transcript: 'Force is a push or pull on an object! Forces can make things move, stop, or change direction. '
                'Pressure is force per unit area. Pressure = Force ÷ Area. '
                'A sharp knife cuts easily because the area is small, so pressure is high! '
                'Atmospheric pressure is the weight of air pressing on everything around us.',
            captions: ['Force is a push or pull.', 'Forces make things move, stop, or change direction.', 'Pressure = Force ÷ Area.', 'Small area = more pressure (sharp knife).', 'Air has atmospheric pressure!'],
            keyVisualPoints: [KeyVisualPoint(iconName: 'push_pin', title: 'Force', subtitle: 'Push or pull on objects', colorValue: 0xFF4ECDC4), KeyVisualPoint(iconName: 'compress', title: 'Pressure', subtitle: 'Force per unit area', colorValue: 0xFFFF6B6B)],
            quizQuestions: [QuizQuestion(question: 'What is the formula for pressure?', options: ['Force × Area', 'Force + Area', 'Force ÷ Area', 'Force - Area'], correctIndex: 2, explanation: 'Pressure = Force ÷ Area.')],
          ),
        ]),
      ]),
      SubjectData(name: 'Balbharti', iconName: 'auto_stories', colorValue: 0xFFFFA726, chapters: [
        ChapterData(id: 'c8_bal_ch1', title: 'गद्य व पद्य (Prose & Poetry)', unitLabel: 'UNIT 1: BALBHARTI', lessons: [
          LessonContent(id: 'c8_bal_ch1_l1', title: 'आत्मकथन (Autobiography)', description: 'Learn to write about yourself in Marathi.', durationSeconds: 380,
            transcript: 'An autobiography tells your own life story. In Marathi, it is called आत्मकथन. '
                'Start with your birth and family. Describe your school and friends. '
                'Write about your hobbies and dreams. Use first person: मी (I). '
                'Express your feelings honestly and describe events clearly.',
            captions: ['Autobiography = your own life story.', 'In Marathi: आत्मकथन.', 'Start with birth and family.', 'Use first person: मी (I).', 'Be honest and descriptive!'],
            keyVisualPoints: [KeyVisualPoint(iconName: 'person', title: 'First Person', subtitle: 'Write using मी (I)', colorValue: 0xFFFFA726), KeyVisualPoint(iconName: 'timeline', title: 'Life Events', subtitle: 'Birth, school, dreams', colorValue: 0xFF42A5F5)],
            quizQuestions: [QuizQuestion(question: 'What is an autobiography called in Marathi?', options: ['चरित्र', 'आत्मकथन', 'कथा', 'कविता'], correctIndex: 1, explanation: 'An autobiography is called आत्मकथन in Marathi.')],
          ),
        ]),
      ]),
    ],
  );

  static const _class9 = ClassData(
    classNumber: 9,
    subjects: [
      SubjectData(name: 'English', iconName: 'menu_book', colorValue: 0xFF667EEA, chapters: [
        ChapterData(id: 'c9_eng_ch1', title: 'Literature', unitLabel: 'UNIT 1: ENGLISH', lessons: [
          LessonContent(id: 'c9_eng_ch1_l1', title: 'Introduction to Literature', description: 'Explore different forms of literature: prose, poetry, and drama.', durationSeconds: 420,
            transcript: 'Literature is the art of writing. It has three main forms. '
                'Prose: Regular writing like stories and essays. Novels are long prose works. '
                'Poetry: Writing with rhythm, rhyme, and imagery. Poems express feelings beautifully. '
                'Drama: Stories meant to be performed on stage. Plays have acts and scenes. '
                'Great literature makes us think, feel, and understand the world better!',
            captions: ['Literature is the art of writing.', 'Prose: stories, essays, novels.', 'Poetry: rhythm, rhyme, imagery.', 'Drama: performed on stage.', 'Literature helps us understand the world!'],
            keyVisualPoints: [KeyVisualPoint(iconName: 'auto_stories', title: 'Prose', subtitle: 'Stories, novels, essays', colorValue: 0xFF667EEA), KeyVisualPoint(iconName: 'music_note', title: 'Poetry', subtitle: 'Rhythm, rhyme, feelings', colorValue: 0xFFFF6B6B), KeyVisualPoint(iconName: 'theater_comedy', title: 'Drama', subtitle: 'Plays performed on stage', colorValue: 0xFFFFA726)],
            quizQuestions: [QuizQuestion(question: 'Which form of literature is meant to be performed on stage?', options: ['Prose', 'Poetry', 'Drama', 'Essay'], correctIndex: 2, explanation: 'Drama (plays) are meant to be performed on stage.')],
          ),
        ]),
      ]),
      SubjectData(name: 'Mathematics', iconName: 'calculate', colorValue: 0xFFFF6B6B, chapters: [
        ChapterData(id: 'c9_math_ch1', title: 'Coordinate Geometry', unitLabel: 'UNIT 1: MATHEMATICS', lessons: [
          LessonContent(id: 'c9_math_ch1_l1', title: 'The Cartesian Plane', description: 'Learn about the coordinate system and plotting points.', durationSeconds: 450,
            transcript: 'The Cartesian plane is like a map for math! It has two axes. '
                'The horizontal line is the x-axis. The vertical line is the y-axis. '
                'They meet at the origin (0,0). Every point has coordinates (x, y). '
                'The point (3, 4) means go 3 right and 4 up from the origin. '
                'The plane has 4 quadrants. Quadrant I: both positive. Quadrant II: x negative, y positive.',
            captions: ['Cartesian plane has x-axis and y-axis.', 'They meet at origin (0,0).', 'Point (3,4) = go 3 right, 4 up.', 'The plane has 4 quadrants.'],
            keyVisualPoints: [KeyVisualPoint(iconName: 'grid_on', title: 'Cartesian Plane', subtitle: 'X-axis and Y-axis grid', colorValue: 0xFFFF6B6B), KeyVisualPoint(iconName: 'place', title: 'Coordinates', subtitle: '(x, y) locates any point', colorValue: 0xFF42A5F5)],
            quizQuestions: [QuizQuestion(question: 'What are the coordinates of the origin?', options: ['(1, 1)', '(0, 1)', '(0, 0)', '(1, 0)'], correctIndex: 2, explanation: 'The origin is at (0, 0) where both axes meet.')],
          ),
        ]),
      ]),
      SubjectData(name: 'Science', iconName: 'science', colorValue: 0xFF4ECDC4, chapters: [
        ChapterData(id: 'c9_sci_ch1', title: 'Atoms & Molecules', unitLabel: 'UNIT 1: SCIENCE', lessons: [
          LessonContent(id: 'c9_sci_ch1_l1', title: 'Structure of an Atom', description: 'Learn about protons, neutrons, electrons, and atomic structure.', durationSeconds: 450,
            transcript: 'Everything is made of atoms! An atom has three parts. '
                'The nucleus is at the center. It contains protons (positive charge) and neutrons (no charge). '
                'Electrons (negative charge) orbit around the nucleus in shells. '
                'Protons and electrons are equal in a neutral atom. '
                'The atomic number equals the number of protons!',
            captions: ['Everything is made of atoms!', 'Nucleus: protons (+) and neutrons (0).', 'Electrons (-) orbit in shells.', 'Neutral atom: protons = electrons.', 'Atomic number = number of protons.'],
            keyVisualPoints: [KeyVisualPoint(iconName: 'blur_on', title: 'Nucleus', subtitle: 'Protons + Neutrons', colorValue: 0xFF4ECDC4), KeyVisualPoint(iconName: 'all_out', title: 'Electrons', subtitle: 'Orbit in shells', colorValue: 0xFFFF6B6B), KeyVisualPoint(iconName: 'tag', title: 'Atomic Number', subtitle: 'Number of protons', colorValue: 0xFF42A5F5)],
            quizQuestions: [QuizQuestion(question: 'What charge does an electron have?', options: ['Positive', 'Negative', 'Neutral', 'Both'], correctIndex: 1, explanation: 'Electrons have a negative charge.'), QuizQuestion(question: 'Where are protons found?', options: ['In shells', 'In the nucleus', 'Outside the atom', 'Nowhere'], correctIndex: 1, explanation: 'Protons are found in the nucleus of an atom.')],
          ),
        ]),
      ]),
      SubjectData(name: 'Balbharti', iconName: 'auto_stories', colorValue: 0xFFFFA726, chapters: [
        ChapterData(id: 'c9_bal_ch1', title: 'साहित्य (Literature)', unitLabel: 'UNIT 1: BALBHARTI', lessons: [
          LessonContent(id: 'c9_bal_ch1_l1', title: 'मराठी साहित्याचा इतिहास', description: 'History and evolution of Marathi literature.', durationSeconds: 420,
            transcript: 'Marathi literature has a rich history spanning over 800 years! '
                'Sant Dnyaneshwar wrote Dnyaneshwari in the 13th century. '
                'Saint Tukaram composed beautiful Abhangas (devotional poems). '
                'Modern Marathi literature includes novels, short stories, and plays. '
                'Vishnu Sakharam Khandekar won the Jnanpith Award for "Yayati".',
            captions: ['Marathi literature: over 800 years of history!', 'Sant Dnyaneshwar: Dnyaneshwari (13th century).', 'Saint Tukaram: Abhangas (devotional poems).', 'V.S. Khandekar won Jnanpith Award for "Yayati".'],
            keyVisualPoints: [KeyVisualPoint(iconName: 'history_edu', title: 'Ancient', subtitle: 'Sant Dnyaneshwar, Tukaram', colorValue: 0xFFFFA726), KeyVisualPoint(iconName: 'emoji_events', title: 'Jnanpith Award', subtitle: 'V.S. Khandekar for Yayati', colorValue: 0xFF42A5F5)],
            quizQuestions: [QuizQuestion(question: 'Who wrote Dnyaneshwari?', options: ['Tukaram', 'Dnyaneshwar', 'Khandekar', 'Ramdas'], correctIndex: 1, explanation: 'Sant Dnyaneshwar wrote Dnyaneshwari in the 13th century.')],
          ),
        ]),
      ]),
    ],
  );

  /// Global sign language dictionary terms across all subjects
  static const List<SignLanguageTerm> signLanguageDictionary = [
    // Common classroom terms
    SignLanguageTerm(term: 'Hello', description: 'A greeting', handshapeDescription: 'Open hand at forehead, move outward like a salute', category: 'Greetings'),
    SignLanguageTerm(term: 'Thank You', description: 'Expressing gratitude', handshapeDescription: 'Flat hand from chin, move forward and down', category: 'Greetings'),
    SignLanguageTerm(term: 'Please', description: 'Polite request', handshapeDescription: 'Flat hand on chest, rub in a circle', category: 'Greetings'),
    SignLanguageTerm(term: 'Yes', description: 'Affirmative', handshapeDescription: 'Make a fist and nod it up and down', category: 'Greetings'),
    SignLanguageTerm(term: 'No', description: 'Negative', handshapeDescription: 'Extend index and middle finger, snap together with thumb', category: 'Greetings'),

    // School terms
    SignLanguageTerm(term: 'School', description: 'Place of learning', handshapeDescription: 'Clap hands twice', category: 'School'),
    SignLanguageTerm(term: 'Teacher', description: 'A person who teaches', handshapeDescription: 'Both hands at temples, move forward', category: 'School'),
    SignLanguageTerm(term: 'Student', description: 'A person who learns', handshapeDescription: 'Flat hand from forehead to open palm of other hand', category: 'School'),
    SignLanguageTerm(term: 'Book', description: 'Written pages bound together', handshapeDescription: 'Open and close flat hands like opening a book', category: 'School'),
    SignLanguageTerm(term: 'Learn', description: 'To gain knowledge', handshapeDescription: 'Grab knowledge (fingers) from open palm and bring to forehead', category: 'School'),
    SignLanguageTerm(term: 'Read', description: 'To look at and understand written words', handshapeDescription: 'V-hand (like eyes) move down open palm (like a page)', category: 'School'),
    SignLanguageTerm(term: 'Write', description: 'To form letters or words', handshapeDescription: 'Pretend to hold a pen and write on open palm', category: 'School'),
    SignLanguageTerm(term: 'Question', description: 'Something asked', handshapeDescription: 'Draw a question mark shape in the air with index finger', category: 'School'),
    SignLanguageTerm(term: 'Answer', description: 'A response to a question', handshapeDescription: 'Both index fingers at mouth, move forward together', category: 'School'),

    // Science terms
    SignLanguageTerm(term: 'Science', description: 'Study of the natural world', handshapeDescription: 'Alternate pouring from two imaginary test tubes', category: 'Science'),
    SignLanguageTerm(term: 'Water', description: 'H2O, essential for life', handshapeDescription: 'W-hand shape, tap chin twice', category: 'Science'),
    SignLanguageTerm(term: 'Plant', description: 'A living green organism', handshapeDescription: 'Push one hand up through the other flat hand', category: 'Science'),
    SignLanguageTerm(term: 'Animal', description: 'A living creature', handshapeDescription: 'Both hands on chest, rock back and forth (like breathing)', category: 'Science'),
    SignLanguageTerm(term: 'Earth', description: 'Our planet', handshapeDescription: 'Rock hand (like holding a ball) back and forth', category: 'Science'),
    SignLanguageTerm(term: 'Light', description: 'Electromagnetic radiation we can see', handshapeDescription: 'Flick middle finger off thumb upward (like a flash)', category: 'Science'),

    // Math terms
    SignLanguageTerm(term: 'Number', description: 'A mathematical value', handshapeDescription: 'Touch fingertips of both hands together, twist', category: 'Math'),
    SignLanguageTerm(term: 'Add', description: 'To combine values', handshapeDescription: 'Bring both open hands together, fingertips touching', category: 'Math'),
    SignLanguageTerm(term: 'Subtract', description: 'To take away', handshapeDescription: 'Draw fingers across open palm and pull away', category: 'Math'),
    SignLanguageTerm(term: 'Multiply', description: 'To increase by a factor', handshapeDescription: 'Cross V-hands in front', category: 'Math'),
    SignLanguageTerm(term: 'Equal', description: 'The same value', handshapeDescription: 'Both flat hands move together in parallel', category: 'Math'),

    // Everyday terms
    SignLanguageTerm(term: 'Help', description: 'To assist someone', handshapeDescription: 'Fist on open palm, lift both up together', category: 'Everyday'),
    SignLanguageTerm(term: 'Good', description: 'Positive quality', handshapeDescription: 'Flat hand from chin forward and down to open palm', category: 'Everyday'),
    SignLanguageTerm(term: 'Bad', description: 'Negative quality', handshapeDescription: 'Flat hand from chin, flip to palm down', category: 'Everyday'),
    SignLanguageTerm(term: 'Happy', description: 'Feeling joy', handshapeDescription: 'Flat hands circle upward on chest repeatedly', category: 'Everyday'),
    SignLanguageTerm(term: 'Sad', description: 'Feeling unhappy', handshapeDescription: 'Both open hands in front of face, move down slowly', category: 'Everyday'),
    SignLanguageTerm(term: 'Friend', description: 'Someone you care about', handshapeDescription: 'Hook index fingers together, switch positions', category: 'Everyday'),
    SignLanguageTerm(term: 'Family', description: 'People you live with', handshapeDescription: 'Both F-hands, circle out from center and back', category: 'Everyday'),
    SignLanguageTerm(term: 'Home', description: 'Where you live', handshapeDescription: 'Flat O-hand at mouth, then at cheek', category: 'Everyday'),
    SignLanguageTerm(term: 'Food', description: 'Things we eat', handshapeDescription: 'Flat O-hand to mouth repeatedly', category: 'Everyday'),
    SignLanguageTerm(term: 'Emergency', description: 'A serious, urgent situation', handshapeDescription: 'E-hand shaking back and forth', category: 'Everyday'),
  ];
}
