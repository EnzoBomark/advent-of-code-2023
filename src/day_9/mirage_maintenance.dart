import 'package:collection/collection.dart';

import '../day.dart';

class History {
  final List<List<int>> sequences;

  History(this.sequences);

  factory History.create(String input) {
    final initialSequence = input.split(' ').map((number) => int.parse(number)).toList();
    List<List<int>> sequences = [
      initialSequence
    ];

    while (!sequences.last.every((number) => number == 0)) {
      final prevSequence = sequences.last;
      final newSequence = prevSequence.skip(1).mapIndexed((index, number) => number - prevSequence.elementAt(index)).toList();
      sequences.add(newSequence);
    }

    return History(sequences);
  }
}

class Day09 extends Day {
  Day09() : super(9);

  @override
  List<String> parseInput() {
    return input.getPerLine();
  }

  @override
  int solvePart1() {
    final histories = parseInput().map((input) => History.create(input));

    final sumOfHistoriesLastContinueSequenceNumber = histories.fold(0, (acc, history) {
      final continuedSequences = history.sequences.reversed.toList();

      continuedSequences.forEachIndexed((index, sequence) {
        if (index - 1 < 0) {
          sequence.add(sequence.last);
        } else {
          final prevSequence = continuedSequences.elementAt(index - 1);
          final lastPrevSequenceNumber = prevSequence.last;
          final newLastSequenceNumber = sequence.last + lastPrevSequenceNumber;
          sequence.add(newLastSequenceNumber);
        }
      });

      return acc + continuedSequences.reversed.first.last;
    });

    return sumOfHistoriesLastContinueSequenceNumber;
  }

  @override
  int solvePart2() {
    final histories = parseInput().map((input) => History.create(input));

    final sumOfHistoriesFirstPreviousSequenceNumber = histories.fold(0, (acc, history) {
      final continuedSequences = history.sequences.reversed.toList();

      continuedSequences.forEachIndexed((index, sequence) {
        if (index - 1 < 0) {
          sequence.insert(0, sequence.first);
        } else {
          final prevSequence = continuedSequences.elementAt(index - 1);
          final firstPrevSequenceNumber = prevSequence.first;
          final newFirstSequenceNumber = sequence.first - firstPrevSequenceNumber;
          sequence.insert(0, newFirstSequenceNumber);
        }
      });

      return acc + continuedSequences.reversed.first.first;
    });

    return sumOfHistoriesFirstPreviousSequenceNumber;
  }
}
