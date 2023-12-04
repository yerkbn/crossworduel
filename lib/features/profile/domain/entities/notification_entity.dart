import 'package:equatable/equatable.dart';

class NotificationEntity extends Equatable {
  final String id;
  final String type;
  final String title;
  final String body;
  final String createDate;
  final bool isRead;

  const NotificationEntity({
    required this.id,
    required this.type,
    required this.title,
    required this.body,
    required this.createDate,
    required this.isRead,
  });

  @override
  List<Object?> get props => [
        id,
        type,
        title,
        body,
        createDate,
        isRead,
      ];
}
