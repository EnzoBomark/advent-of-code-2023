import 'src/day_1/trebuchet.dart';
import 'src/day_2/cube_conundrum.dart';
import 'src/day_3/gear_ratios.dart';
import 'src/day_4/scratchcards.dart';
import 'src/day_9/mirage_maintenance.dart';

void main(List<String> arguments) {
  final Stopwatch stopwatch = Stopwatch()..start();

  if (arguments.length > 0) {
    final day = arguments[0];

    switch (day) {
      case "01":
        Day01().printSolutions();
        break;
      case "02":
        Day02().printSolutions();
        break;
      case "03":
        Day03().printSolutions();
        break;
      case "04":
        Day04().printSolutions();
        break;
      case "09":
        Day09().printSolutions();
        break;
      default:
        print("Day $day does not exist");
        break;
    }
  } else {
    print("No day specified. Here are the answers");
    Day01().printSolutions();
    Day02().printSolutions();
    Day03().printSolutions();
    Day04().printSolutions();
    Day09().printSolutions();
    print("Done 🎉");
  }

  print("Elapsed time: ${stopwatch.elapsedMilliseconds / 1000} seconds");
}
