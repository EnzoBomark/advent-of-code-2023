import 'package:collection/collection.dart';

import '../day.dart';

class Symbol {
  final String char;
  final int lineNumber;
  final int position;

  Symbol(this.char, this.lineNumber, this.position);

  bool isAdjacentToEnginePart(EnginePart enginePart) {
    final isWithinStartPosition = position >= enginePart.startPosition - 1;

    final isWithinEndPosition = position <= enginePart.endPosition + 1;

    final isWithinLineSpan = {
      lineNumber - 1,
      lineNumber,
      lineNumber + 1
    }.contains(enginePart.lineNumber);

    return isWithinLineSpan && isWithinStartPosition && isWithinEndPosition;
  }
}

class EnginePart {
  final int number;
  final int lineNumber;
  final int startPosition;
  final int endPosition;

  EnginePart(this.number, this.lineNumber, this.startPosition, this.endPosition);
}

class EngineSchematic {
  final List<EnginePart> engineParts;
  final List<Symbol> symbols;

  static EngineSchematic empty() {
    return EngineSchematic([], []);
  }

  EngineSchematic(this.engineParts, this.symbols);
}

class Day03 extends Day {
  Day03() : super(3);

  @override
  List<String> parseInput() {
    return input.getPerLine();
  }

  @override
  int solvePart1() {
    final engineSchematic = _parseEngineSchematic();

    final sumOfEnginePartNumbersThatAreAdjacentToASymbol = engineSchematic.symbols.fold(0, (acc, entry) {
      final adjacentEnginePart = engineSchematic.engineParts.firstWhereOrNull((enginePart) => entry.isAdjacentToEnginePart(enginePart));
      final isAdjacentToSymbol = adjacentEnginePart != null;

      if (isAdjacentToSymbol) {
        return acc + adjacentEnginePart.number;
      } else {
        return acc;
      }
    });

    return sumOfEnginePartNumbersThatAreAdjacentToASymbol;
  }

  @override
  int solvePart2() {
    final engineSchematic = _parseEngineSchematic();

    final sumOfAllGearRatios = engineSchematic.symbols.fold(0, (acc, entry) {
      final adjacentEngineParts = engineSchematic.engineParts.where((enginePart) => entry.isAdjacentToEnginePart(enginePart));
      final isAdjacentToMultipleEngineParts = adjacentEngineParts.length > 1;
      final isGear = isAdjacentToMultipleEngineParts && entry.char == '*';

      if (isGear) {
        return acc + adjacentEngineParts.fold(1, (acc, entry) => acc * entry.number);
      } else {
        return acc;
      }
    });

    return sumOfAllGearRatios;
  }

  EngineSchematic _parseEngineSchematic() {
    final enginePartRegex = RegExp(r'\d+');
    final symbolRegex = RegExp(r'[^\d\s.]');

    return parseInput().foldIndexed(EngineSchematic.empty(), (index, acc, line) {
      final enginePartMatches = enginePartRegex.allMatches(line).toList();
      final symbolMatches = symbolRegex.allMatches(line).toList();

      enginePartMatches.forEach((match) {
        final number = int.parse(match.group(0)!);
        final startPosition = match.start;
        final endPosition = match.end - 1;
        final enginePart = EnginePart(number, index, startPosition, endPosition);
        acc.engineParts.add(enginePart);
      });

      symbolMatches.forEach((match) {
        final char = match.group(0)!;
        final position = match.start;
        final symbol = Symbol(char, index, position);
        acc.symbols.add(symbol);
      });

      return acc;
    });
  }
}
