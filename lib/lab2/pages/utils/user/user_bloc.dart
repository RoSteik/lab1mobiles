import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_project/lab2/logic/model/user.dart';
import 'package:my_project/lab2/logic/service/auth/auth_service.dart';
import 'package:my_project/lab2/pages/utils/user/user_events.dart';
import 'package:my_project/lab2/pages/utils/user/user_states.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final AuthService _authService;

  UserBloc(this._authService) : super(UserInitial()) {
    on<LoadUser>((event, emit) async {
      emit(UserLoading());
      try {
        final User? user = await _authService.getUser();
        if (user != null) {
          emit(UserLoaded(user));
        } else {
          emit(UserError('User not found'));
        }
      } catch (e) {
        emit(UserError(e.toString()));
      }
    });

    on<Logout>((event, emit) async {
      await _authService.logout();
      emit(UserInitial());
    });

  }
}
