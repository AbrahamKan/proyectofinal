/*

Auth Cubit: State Management

*/
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyectofinal/features/auth/domain/entities/app_user.dart';
import 'package:proyectofinal/features/auth/domain/repos/auth_repo.dart';
import 'package:proyectofinal/features/auth/presentation/cubits/auth_states.dart';

import '../../domain/entities/app_user.dart';
import 'auth_states.dart';

class AuthCubit extends Cubit<AuthState>{
  final AuthRepo authRepo;
  AppUser? _currentUser;

  AuthCubit({required this.authRepo}) :super (AuthInitial());

  // check if user is already authenticated
  void checkAuth() async {
    final AppUser? user = await authRepo.getCurrentUser();

    if (user != null){
      _currentUser = user;
      emit(authenticated(user));
    } else {
      emit(Unauthenticated());
    }
  }


  // get current user
  AppUser? get currentUser => _currentUser ;

  // login with email + pw
  Future<void> login(String email, String pw) async {
    try {
      emit(AuthLoading());
      final user = await authRepo.loginWithEmailPassword(email, pw);

      if (user != null) {
        _currentUser = user;
        emit(authenticated(user));
      } else {
        emit(Unauthenticated());
      }
    } catch (e) {
      emit(AuthError(e.toString()));
      emit(Unauthenticated());

    }
  }
  // register withh email + pw
  Future<void> register(String name, String email, String pw) async {
    try {
      emit(AuthLoading());
      final user = await authRepo.registerWithEmailPassword(name, email, pw);

      if (user != null) {
        _currentUser = user;
        emit(authenticated(user));
      } else {
        emit(Unauthenticated());
      }
    } catch (e) {
      emit(AuthError(e.toString()));
      emit(Unauthenticated());

    }
  }


  // logout

  Future<void> logout() async {
    authRepo.logout();
    emit(Unauthenticated());
  }
}