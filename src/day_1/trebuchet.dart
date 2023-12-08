import '../day.dart';

class Day01 extends Day {
  Day01() : super(1);

  @override
  List<String> parseInput() {
    return input.getPerLine();
  }

  @override
  int solvePart1() {
    final totalSum = parseInput().fold<int>(0, (acc, line) {
      final numbers = _combineBorderDigits(_toDigits(line));
      return acc + numbers;
    });

    return totalSum;
  }

  @override
  int solvePart2() {
    final totalSum = parseInput().fold<int>(0, (acc, line) {
      final numbers = _combineBorderDigits(_toDigits(_stringDigitToDigits(line)));
      return acc + numbers;
    });

    return totalSum;
  }

  String _toDigits(String string) {
    return string.replaceAll(RegExp(r'[^\d]+'), '');
  }

  String _stringDigitToDigits(String string) {
    const replacements = {
      'zero': 'zero0zero',
      'one': 'one1one',
      'two': 'two2two',
      'three': 'three3three',
      'four': 'four4four',
      'five': 'five5five',
      'six': 'six6six',
      'seven': 'seven7seven',
      'eight': 'eight8eight',
      'nine': 'nine9nine',
    };

    return replacements.entries.fold(string, (acc, entry) {
      return acc.replaceAll(entry.key, entry.value);
    });
  }

  int _combineBorderDigits(String string) {
    if (string.isNotEmpty) {
      return int.parse(string[0] + string[string.length - 1]);
    } else {
      return 0;
    }
  }
}
