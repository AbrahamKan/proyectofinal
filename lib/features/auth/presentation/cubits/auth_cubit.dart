/*

Auth Cubit: State Management

*/
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyectofinal/features/auth/domain/entities/app_user.dart';
import 'package:proyectofinal/features/auth/domain/repos/auth_repo.dart';
import 'package:proyectofinal/features/auth/presentation/cubits/auth_states.dart';

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
  
  
  // login with email + pw

  // register withh email + pw

  // logout
}