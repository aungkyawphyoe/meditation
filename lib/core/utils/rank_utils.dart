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
