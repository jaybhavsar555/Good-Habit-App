import 'dart:ffi';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_habit_app/feature/auth/domain/entities/user_entity.dart';

import '../../domain/repositories/auth_repository.dart';
import '../../domain/use_cases/auth_sign_in_usecase.dart';
import '../../domain/use_cases/auth_sign_up_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc(this.authRepository) : super(AuthInitial()) {
    on<SignUpEvent>((event, emit) async {
      try {
        emit(AuthLoading());

        final user = await SignUpUseCase(authRepository).execute(event.email,
            event.password, event.username, event.gender, event.dateOfBirth);

        emit(AuthSuccess(user.uid as UserEntity));
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });

    on<SignInEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await SignInUseCase(authRepository)
            .execute(event.email, event.password);
        if (user != null) {
          emit(AuthSuccess(user));
        } else {
          emit(AuthFailure("Invalid email or password"));
        }
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });
  }
}
