/// each executible item will
/// be passed inside this bullet
class SheduleItem {
  final void Function() func;
  final int? duration;

  bool get isInstant => duration != null && duration == 0;
  bool get isDurationDefault => duration == null;

  SheduleItem(this.func, this.duration);
}

/// Interface for sheduling tasks
abstract class Shedule {
  final String id;
  // [SheduleItem] duraiton is null it will be called
  final int defaultDuration;
  final List<SheduleItem> queue = [];
  bool isWorking = false;

  Shedule({required this.id, required this.defaultDuration});

  /// New tasks will be pushed here
  void push(SheduleItem item);

  /// Shedule different implementation will be here
  /// implemented
  void worker({SheduleItem item});

  void clear() {
    queue.clear();
  }
}

/// Shedule Manager if we have multiple
/// [Shedule] with similar applicaltion
abstract class SheduleManager<T extends Shedule> {
  void push({required String id, required SheduleItem item});

  T findByidOrCreate(String id);

  T createShedule(String id);

  void clear();
}

/// Simple SheduleManager implementation
/// for future use in simple and default cases
///
/// It hold multiple simple shedule
/// and differentiate them by id like (user id)
/// with this code we reach to instant releasing multiple
/// items seperated by id
///
/// For instance Each user can release emojie
/// and each user do it independently
/// for instance Asik release 5 emojie
/// where Den 3 of them and their emojies will be
/// sheduled seperately
class SimpleSheduleManager<T extends Shedule> implements SheduleManager<T> {
  final T Function(String id) createSheduleImpl;

  /// Warning here might be memmory leek
  /// because array [_shedules] will only rise
  final List<T> _shedules = [];

  SimpleSheduleManager(this.createSheduleImpl);

  @override
  void push({required String id, required SheduleItem item}) {
    T shedule = findByidOrCreate(id);
    shedule.push(item);
  }

  @override
  T findByidOrCreate(String id) {
    for (T element in _shedules) {
      if (element.id == id) return element;
    }
    T newShedule = createShedule(id);
    _shedules.add(newShedule);
    return newShedule;
  }

  @override
  T createShedule(String id) {
    return this.createSheduleImpl(id);
  }

  @override
  void clear() {
    _shedules.clear();
  }
}
