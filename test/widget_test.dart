import 'package:cinepulse/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('CinePulse abre na tela principal', (tester) async {
    await tester.pumpWidget(const CinePulseApp());

    expect(find.text('CinePulse'), findsOneWidget);
    expect(find.text('Descobrir'), findsOneWidget);
    expect(find.text('Diário'), findsOneWidget);
  });
}
