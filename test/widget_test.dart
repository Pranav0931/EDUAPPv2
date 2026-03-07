import 'package:flutter_test/flutter_test.dart';
import 'package:edu_app/main.dart';

void main() {
  testWidgets('EduApp renders splash screen', (WidgetTester tester) async {
    await tester.pumpWidget(const EduApp());
    expect(find.text('EduApp'), findsOneWidget);
  });
}
