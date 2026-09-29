import 'package:cinepulse/features/catalog/data/models/rating_entry.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('PulseScore usa somente critérios preenchidos', () {
    const score = PulseScore(story: 4, visual: 5);
    expect(score.averageFive, 4.5);
    expect(score.averageTen, 9);
    expect(score.acting, isNull);
    expect(score.soundtrack, isNull);
  });

  test('PulseScore sem critérios não inventa média', () {
    const score = PulseScore();
    expect(score.isEmpty, isTrue);
    expect(score.averageFive, isNull);
    expect(score.averageTen, isNull);
  });
}
