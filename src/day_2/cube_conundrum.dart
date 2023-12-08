import 'package:collection/collection.dart';
import '../day.dart';

enum Color {
  red,
  green,
  blue
}

class Cube {
  final int count;
  final Color color;

  static isValidColor(String color) {
    return Color.values.any((c) => c.toString().split('.').last == color);
  }

  static Cube create(String count, String color) {
    if (isValidColor(color)) {
      return Cube(int.parse(count), Color.values.byName(color));
    } else {
      throw Exception('Invalid color: $color');
    }
  }

  Cube(this.count, this.color);
}

class Day02 extends Day {
  Day02() : super(2);

  @override
  List<String> parseInput() {
    return input.getPerLine();
  }

  @override
  int solvePart1() {
    final List<Cube> existingCubes = [
      Cube(12, Color.red),
      Cube(13, Color.green),
      Cube(14, Color.blue),
    ];

    final sumPossibleGameIds = parseInput().fold(0, (acc, line) {
      final gameId = _getGameId(line);
      final cubes = _getCubes(line);

      final isPossible = cubes.every((cube) {
        final existingCube = existingCubes.firstWhere((existingCube) => existingCube.color == cube.color);
        return cube.count <= existingCube.count;
      });

      if (isPossible) {
        return acc + gameId;
      } else {
        return acc;
      }
    });

    return sumPossibleGameIds;
  }

  @override
  int solvePart2() {
    final sumPowerOfMinCubesPerGame = parseInput().fold(0, (acc, line) {
      final cubes = _getCubes(line);

      final powerOfMinCubeCount = cubes.fold<List<Cube>>([], (acc, cube) {
        final existingCube = acc.firstWhereOrNull((existingCube) => existingCube.color == cube.color);
        if (existingCube == null) {
          acc.add(cube);
        } else if (cube.count > existingCube.count) {
          acc[acc.indexOf(existingCube)] = cube;
        }

        return acc;
      }).fold(1, (acc, cube) {
        return acc * cube.count;
      });

      return acc + powerOfMinCubeCount;
    });

    return sumPowerOfMinCubesPerGame;
  }

  int _getGameId(String line) {
    return int.parse(line.substring(5).split(":")[0]);
  }

  List<Cube> _getCubes(String line) {
    return line.substring(5).split(":")[1].split(RegExp(r'[,;]')).map((value) {
      final parts = value.trim().split(" ");

      if (parts.length == 2) {
        final [
          count,
          color
        ] = parts;

        return Cube.create(count, color);
      } else {
        throw Exception('Invalid cube format: $value');
      }
    }).toList();
  }
}
