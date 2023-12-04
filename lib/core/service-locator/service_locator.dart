import 'package:get_it/get_it.dart';

abstract class ServiceLocator {
  Future<void> call(GetIt sl);
}
