import 'package:blog_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  AuthBloc({
    required UserSignUp userSigngUp,
  })  : _userSignUp = userSigngUp,
        super(AuthInitial()) {
    on<AuthSignUp>((event, emit) async {
      final res = await _userSignUp.call(UserSignUpParams(
        name: event.name,
        email: event.email,
        password: event.password,
      ));

      res.fold((failure) => emit(AuthFailure(failure.message)),
          (uid) => emit(AuthSuccess(uid)));
    });
  }
}
