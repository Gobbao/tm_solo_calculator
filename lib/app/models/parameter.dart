class Parameter {
  final String capitalizedName;
  final String measureUnit;
  final int initialLevel;
  final int finalLevel;
  final int totalLevels;
  final int _levelMultiplier;
  final bool _enablePlusSignalOnFormatting;

  int _currentLevel = 0;

  Parameter({
    this.capitalizedName,
    this.measureUnit,
    this.initialLevel,
    this.totalLevels,
    int levelMultiplier = 1,
    bool enablePlusSignalOnFormatting = false,
  })
    : _levelMultiplier = levelMultiplier,
      _enablePlusSignalOnFormatting = enablePlusSignalOnFormatting,
      finalLevel = initialLevel + (totalLevels * levelMultiplier);

  int get currentLevel {
    return initialLevel + (_currentLevel * _levelMultiplier);
  }

  set currentLevel(int multipliedLevel) {
    _currentLevel = multipliedLevel <= initialLevel
      ? 0
      : multipliedLevel >= finalLevel
        ? totalLevels
        : (multipliedLevel - initialLevel) ~/ _levelMultiplier;
  }

  String get formatedCurrentLevel {
    String formated = '$currentLevel';

    if (_enablePlusSignalOnFormatting && currentLevel > 0) {
      formated = '+$formated';
    }

    if (measureUnit != null) {
      formated = '$formated $measureUnit';
    }

    return formated;
  }

  int get remainingLevels {
    return totalLevels - _currentLevel;
  }

  bool get isFirstLevel {
    return _currentLevel == 0;
  }

  bool get isLastLevel {
    return _currentLevel == totalLevels;
  }

  void incrementLevel() {
    currentLevel += _levelMultiplier;
  }

  void decrementLevel() {
    currentLevel -= _levelMultiplier;
  }
}
