import 'package:crossworduel/game/core/shedule/shedule.dart';

/// This will organize shedule Queue
/// where each queue item will be executed one buy one
/// and will be wait till previous is finish execution and
/// wait specific duration
class QueueShedule extends Shedule {
  QueueShedule({required super.id, required super.defaultDuration});

  @override
  void push(SheduleItem item) {
    queue.insert(0, item);
    worker();
  }

  @override
  Future<void> worker({SheduleItem? item}) async {
    if (isWorking || queue.isEmpty) return;
    isWorking = true;
    while (queue.isNotEmpty) {
      final SheduleItem item = queue.last;
      item.func();
      queue.removeAt(queue.length - 1);
      if (item.isDurationDefault) {
        await Future.delayed(Duration(milliseconds: defaultDuration));
      } else if (!item.isInstant) {
        await Future.delayed(Duration(milliseconds: item.duration!));
      }
    }
    isWorking = false;
  }
}
