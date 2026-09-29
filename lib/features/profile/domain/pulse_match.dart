import 'dart:math' as math;

/// Núcleo determinístico descrito em docs/03-mvp-e-requisitos.md, seção 6.
/// A UI só deve exibir percentual quando houver outro perfil real e contexto
/// para explicar gêneros concordantes/divergentes e títulos em comum.
class PulseMatchResult {
  const PulseMatchResult({
    required this.commonKeys,
    required this.overlap,
    required this.averageDivergence,
    required this.agreement,
    required this.percentage,
  });

  final List<String> commonKeys;
  final double overlap;
  final double averageDivergence;
  final double agreement;
  final int? percentage;

  bool get hasEnoughData => commonKeys.length >= 5;
}

PulseMatchResult calculatePulseMatch(
  Map<String, double> ratingsA,
  Map<String, double> ratingsB,
) {
  final common = ratingsA.keys.where(ratingsB.containsKey).toList()..sort();
  if (common.length < 5) {
    return PulseMatchResult(
      commonKeys: common,
      overlap: 0,
      averageDivergence: 0,
      agreement: 0,
      percentage: null,
    );
  }
  final overlap = math.min(1.0, common.length / 30);
  final divergence =
      common
          .map((key) => (ratingsA[key]! - ratingsB[key]!).abs())
          .reduce((a, b) => a + b) /
      common.length;
  final agreement = (1 - divergence / 4.5).clamp(0.0, 1.0);
  final percentage = (100 * (0.35 * overlap + 0.65 * agreement)).round();
  return PulseMatchResult(
    commonKeys: common,
    overlap: overlap,
    averageDivergence: divergence,
    agreement: agreement,
    percentage: percentage,
  );
}
