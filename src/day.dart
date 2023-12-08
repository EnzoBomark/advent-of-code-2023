import 'dart:io';
import 'package:timing/timing.dart';

abstract class Day {
  Day(this.day) : input = InputUtil(day);
  InputUtil input;
  final int day;

  dynamic parseInput();
  int solvePart1();
  int solvePart2();

  void printSolutions() {
    print('-------------------------');
    print('Day $day');
    print('Solution one: ${_solveAndTrackTime(solvePart1)}');
    print('Solution two: ${_solveAndTrackTime(solvePart2)}');
    print('\n');
  }

  String _solveAndTrackTime(int Function() solve) {
    final tracker = SyncTimeTracker();
    late final int solution;
    tracker.track(() => solution = solve());
    return '$solution - Took ${tracker.duration.inMilliseconds} milliseconds';
  }
}

class InputUtil {
  InputUtil(int day)
      : _inputAsString = _readInputDay(day),
        _inputAsList = _readInputDayAsList(day);

  InputUtil.fromMultiLineString(String input)
      : _inputAsString = input,
        _inputAsList = input.split('\n');

  final String _inputAsString;
  final List<String> _inputAsList;

  static String _createInputPath(int day) {
    return './src/day_$day/input.txt';
  }

  static String _readInputDay(int day) {
    return _readInput(_createInputPath(day));
  }

  static String _readInput(String input) {
    return File(input).readAsStringSync();
  }

  static List<String> _readInputDayAsList(int day) {
    return _readInputAsList(_createInputPath(day));
  }

  static List<String> _readInputAsList(String input) {
    return File(input).readAsLinesSync();
  }

  /// Returns input as one String.
  String get asString => _inputAsString;

  /// Reads the entire input contents as lines of text.
  List<String> getPerLine() => _inputAsList;

  /// Splits the input String by `whitespace` and `newline`.
  List<String> getPerWhitespace() {
    return _inputAsString.split(RegExp(r'\s\n'));
  }

  /// Splits the input String by given pattern.
  List<String> getBy(String pattern) {
    return _inputAsString.split(pattern);
  }
}
