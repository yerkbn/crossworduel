import 'package:crossworduel/game/core/crossword/crossword_solver.dart';
import 'package:crossworduel/game/core/crossword/entity/grid_entity.dart';
import 'package:crossworduel/game/core/crossword/library_manager.dart';
import 'package:crossworduel/game/core/crossword/patterns_manager.dart';

class CrosswordGenerator {
  static Future<Map<String, dynamic>> crosswordGenerate(
      {int leftSec = 300}) async {
    final PatternsManager patterns = PatternsManager();
    final GridEntity grid =
        GridEntity(matrix: patterns.size10Bloc44(), spans: []);
    grid.init();
    final LibraryManager lib = LibraryManager();
    await lib.init(size: grid.getMaxSpanLength);
    final CrosswordSolver solver = CrosswordSolver(grid: grid, lib: lib);
    solver.solve();
    return {};
  }
}
