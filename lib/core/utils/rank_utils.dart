import '../../l10n/app_localizations.dart';

const _rankThresholds = [
  (10000, 'Master Chanter'),
  (5000, 'Elder Devotee'),
  (2500, 'Noble Chanter'),
  (1000, 'Senior Devotee'),
  (500, 'Venerable Chanter'),
  (250, 'Faithful Reciter'),
  (100, 'Devoted Chanter'),
  (50, 'Steady Practitioner'),
  (10, 'Aspiring Devotee'),
];

String rankForRounds(int totalRounds) {
  for (final (threshold, title) in _rankThresholds) {
    if (totalRounds >= threshold) return title;
  }
  return 'Novice Chanter';
}

String localizedRankTitle(AppLocalizations l10n, String englishRank) {
  return switch (englishRank) {
    'Novice Chanter' => l10n.rankNoviceChanter,
    'Aspiring Devotee' => l10n.rankAspiringDevotee,
    'Steady Practitioner' => l10n.rankSteadyPractitioner,
    'Devoted Chanter' => l10n.rankDevotedChanter,
    'Faithful Reciter' => l10n.rankFaithfulReciter,
    'Venerable Chanter' => l10n.rankVenerableChanter,
    'Senior Devotee' => l10n.rankSeniorDevotee,
    'Noble Chanter' => l10n.rankNobleChanter,
    'Elder Devotee' => l10n.rankElderDevotee,
    'Master Chanter' => l10n.rankMasterChanter,
    _ => englishRank,
  };
}
