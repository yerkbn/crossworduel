import 'package:equatable/equatable.dart';

class CellEntity extends Equatable {
  final int index;
  final String value;
  final bool isHide;
  final bool isCurrent;

  const CellEntity({
    required this.index,
    required this.value,
    this.isHide = false,
    this.isCurrent = false,
  });

  CellEntity copyWith({bool? isHide, bool? isCurrent}) {
    return CellEntity(
        index: index,
        value: value,
        isHide: isHide ?? this.isHide,
        isCurrent: isCurrent ?? this.isCurrent);
  }

  @override
  List<Object?> get props => [index, value, isHide, isCurrent];
}
