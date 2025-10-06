import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:roadmap_ai/features/auth/presentation/screens/auth_page.dart';
import 'package:roadmap_ai/features/auth/presentation/widgets/log_in_card.dart';
import 'package:roadmap_ai/features/auth/presentation/widgets/sign_up_card.dart';

void main() {
  Widget createTestWidget() {
    return const ProviderScope(
      child: MaterialApp(
        home: AuthPage(),
      ),
    );
  }

  testWidgets('AuthPage shows Roadmap branding', (tester) async {
    await tester.pumpWidget(createTestWidget());

    // Check if "Roadmap" text is present
    expect(find.textContaining('Roadmap'), findsOneWidget);
  });

  testWidgets('AuthPage shows login card by default', (tester) async {
    await tester.pumpWidget(createTestWidget());

    // Check for LogInCard widget
    expect(find.byType(LogInCard), findsOneWidget);
    expect(find.byType(SignUpCard), findsNothing);
  });
}
