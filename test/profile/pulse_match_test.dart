import 'package:cinepulse/features/profile/domain/pulse_match.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('menos de cinco títulos em comum é insuficiente', () {
    final result = calculatePulseMatch(
      {'movie_1': 4, 'movie_2': 3},
      {'movie_1': 4, 'movie_2': 3},
    );
    expect(result.hasEnoughData, isFalse);
    expect(result.percentage, isNull);
  });

  test('fórmula do documento produz resultado determinístico', () {
    final a = {for (var i = 1; i <= 5; i++) 'movie_$i': 5.0};
    final b = {for (var i = 1; i <= 5; i++) 'movie_$i': 4.0};
    final result = calculatePulseMatch(a, b);
    expect(result.hasEnoughData, isTrue);
    expect(result.commonKeys.length, 5);
    expect(result.overlap, closeTo(5 / 30, 0.00001));
    expect(result.averageDivergence, 1);
    expect(result.agreement, closeTo(1 - 1 / 4.5, 0.00001));
    expect(result.percentage, 56);
    expect(calculatePulseMatch(b, a).percentage, result.percentage);
  });

  test('sobreposição satura em trinta títulos', () {
    final values = {for (var i = 1; i <= 32; i++) 'tv_$i': 4.0};
    final result = calculatePulseMatch(values, values);
    expect(result.overlap, 1);
    expect(result.percentage, 100);
  });
}
