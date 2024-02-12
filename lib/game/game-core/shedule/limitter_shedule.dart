import 'package:crossworduel/game/game-core/shedule/shedule.dart';

/// This class is used to limmit user request
/// for instance to avoid problems like
/// to many emeojie flood
class LimiterShedule extends Shedule {
  LimiterShedule({required super.id, required super.defaultDuration});

  @override
  void push(SheduleItem item) {
    if (queue.isEmpty) {
      worker(item: item);
    }
  }

  @override
  Future<void> worker({SheduleItem? item}) async {
    if (isWorking || item == null) return;
    isWorking = true;
    item.func();
    if (item.isDurationDefault) {
      await Future.delayed(Duration(milliseconds: defaultDuration));
    } else if (!item.isInstant) {
      await Future.delayed(Duration(milliseconds: item.duration!));
    }
    isWorking = false;
  }
}
