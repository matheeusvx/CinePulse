enum MoodTag { tenso, leve, reflexivo, epico, emocionante }

extension MoodTagLabel on MoodTag {
  String get label => switch (this) {
    MoodTag.tenso => 'Tenso',
    MoodTag.leve => 'Leve',
    MoodTag.reflexivo => 'Reflexivo',
    MoodTag.epico => 'Épico',
    MoodTag.emocionante => 'Emocionante',
  };
}
