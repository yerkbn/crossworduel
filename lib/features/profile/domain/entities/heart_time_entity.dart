import 'package:equatable/equatable.dart';

class HeartTimeEntity extends Equatable {
  final int secondsTillFull;
  final String fullAt;

  const HeartTimeEntity({
    required this.secondsTillFull,
    required this.fullAt,
  });

  @override
  List<Object?> get props => [secondsTillFull, fullAt];
}
