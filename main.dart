import 'src/day_1/trebuchet.dart';
import 'src/day_2/cube_conundrum.dart';

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
      default:
        print("Day $day does not exist");
        break;
    }
  } else {
    print("No day specified. Here are the answers");
    Day01().printSolutions();
    Day02().printSolutions();
    print("Done 🎉");
  }

  print("Elapsed time: ${stopwatch.elapsedMilliseconds / 1000} seconds");
}
