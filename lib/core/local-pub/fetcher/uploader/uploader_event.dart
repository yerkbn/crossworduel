part of 'uploader_bloc.dart';

@immutable
abstract class UploaderEvent extends Equatable {}

class UploadUploaderEvent extends UploaderEvent {
  final ParamsParent params;

  UploadUploaderEvent({required this.params});

  @override
  List<Object> get props => [params];
}
