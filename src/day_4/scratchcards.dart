import 'package:collection/collection.dart';
import '../day.dart';

class Scratchcard {
  final int cardNumber;
  final Iterable<int> winningNumbers;
  final Iterable<int> selectedNumbers;
  final int matchingNumbersCount;
  final int earnedPoints;

  Scratchcard(this.cardNumber, this.winningNumbers, this.selectedNumbers, this.matchingNumbersCount, this.earnedPoints);

  factory Scratchcard.create(String input) {
    final numberRegex = RegExp(r'\d+');
    final cardInfo = input.split(':');
    final separatedNumbers = cardInfo[1].split('|');
    final cardNumber = int.parse(numberRegex.firstMatch(cardInfo[0])!.group(0)!) - 1;
    final winningNumbers = numberRegex.allMatches(separatedNumbers[0]).map((match) => int.parse(match.group(0)!));
    final selectedNumbers = numberRegex.allMatches(separatedNumbers[1]).map((match) => int.parse(match.group(0)!));
    final matchingNumbersCount = winningNumbers.where((winningNumber) => selectedNumbers.contains(winningNumber)).length;
    final earnedPoints = matchingNumbersCount <= 1 ? matchingNumbersCount : matchingNumbersCount * 2;

    return Scratchcard(cardNumber, winningNumbers, selectedNumbers, matchingNumbersCount, earnedPoints);
  }
}

class Day04 extends Day {
  Day04() : super(4);

  @override
  List<String> parseInput() {
    return input.getPerLine();
  }

  @override
  int solvePart1() {
    final scratchcards = parseInput().map((input) => Scratchcard.create(input));
    final sumOfScratchcardPoints = scratchcards.fold<int>(0, (acc, scratchcard) => acc + scratchcard.earnedPoints);
    return sumOfScratchcardPoints;
  }

  @override
  int solvePart2() {
    final scratchcards = parseInput().map((input) => Scratchcard.create(input));
    final wonScratchcardCopiesCount = _wonScratchcardCopiesCount(scratchcards.toList(), scratchcards.toList());
    return scratchcards.length + wonScratchcardCopiesCount;
  }

  int _wonScratchcardCopiesCount(Iterable<Scratchcard> originalScratchcards, Iterable<Scratchcard?> scratchcards) {
    return scratchcards.fold(0, (acc, curr) {
      if (curr == null) {
        return acc;
      }

      final wonScratchcards = Iterable.generate(curr.matchingNumbersCount, (i) => originalScratchcards.elementAtOrNull(curr.cardNumber + i + 1));
      return acc + curr.matchingNumbersCount + _wonScratchcardCopiesCount(originalScratchcards, wonScratchcards);
    });
  }
}
