import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:crossworduel/features/profile/domain/usecases/check_username_usecase.dart';

part 'username_checker_event.dart';
part 'username_checker_state.dart';

class UsernameCheckerBloc
    extends Bloc<UsernameCheckerEvent, UsernameCheckerState> {
  final CheckUsernameUsecase checkUsernameUsecase;
  UsernameCheckerBloc({required this.checkUsernameUsecase})
      : super(UsernameCheckerInitial()) {
    on<CheckUsernameEvent>((event, emit) async {
      emit(CheckingUsernameState());
      try {
        checkUsername(event.username);
        final res = await checkUsernameUsecase(UsernameParams(event.username));
        res.fold(
          (l) {
            print("3. LEFT $l ");
            emit(
                const FailureUsernameState(message: "username already exists"));
          },
          (r) {
            emit(SuccessUsernameState());
          },
        );
      } catch (e) {
        emit(FailureUsernameState(message: e.toString()));
      }
    });
  }

  void checkUsername(String username) {
    if (username.length < 4) {
      throw "username is too short, minimum 5 characters";
    } else if (username.length > 12) {
      throw "max username length is 12";
    } else if (username.contains(RegExp('[0-9]'))) {
      throw "username shouldn't contain numbers";
    } else if (username.contains(RegExp('[^a-zA-Z0-9_]'))) {
      throw "username shouldn't contain special characters";
    } else if (username[0] == '_' || username[username.length - 1] == '_') {
      throw "username shouldn't start or end with _";
    }
  }
}
