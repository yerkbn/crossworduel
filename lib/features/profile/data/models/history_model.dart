import 'package:crossworduel/features/profile/data/models/user_model.dart';
import 'package:crossworduel/features/profile/domain/entities/history_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'history_model.g.dart';

@JsonSerializable(includeIfNull: true)
class HistoryModel extends HistoryEntity {
  @override
  final UserModel opponent;

  const HistoryModel({
    required super.id,
    required super.leading,
    required super.meDelta,
    required this.opponent,
    required super.opponentDelta,
    super.hasOpened = false,
  }) : super(opponent: opponent);

  static List<HistoryModel> fromJsonList(List jsons) => jsons
      .map((e) => HistoryModel.fromJson(e as Map<String, dynamic>))
      .toList();

  factory HistoryModel.fromJson(Map<String, dynamic> json) =>
      _$HistoryModelFromJson(json);

  factory HistoryModel.fromEntity(HistoryEntity entity) {
    return HistoryModel(
      id: entity.id,
      leading: entity.leading,
      meDelta: entity.meDelta,
      opponent: UserModel.fromEntity(entity.opponent),
      opponentDelta: entity.opponentDelta,
    );
  }

  Map<String, dynamic> toJson() => _$HistoryModelToJson(this);

  @override
  List<Object?> get props => [id, leading, meDelta, opponent, opponentDelta];
}
