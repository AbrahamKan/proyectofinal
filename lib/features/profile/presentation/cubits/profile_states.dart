/*

PROFILE STATES

 */

import 'package:proyectofinal/features/profile/domain/entities/profile_user.dart';
abstract class ProfileState {}

//initial
class ProfileInitial extends ProfileState{}

// loading...
class ProfileLoading extends ProfileState {}

//loaded
class ProfileLoaded extends ProfileState {
  final ProfileUser profileUser; // ✅ CORRECTO
  ProfileLoaded(this.profileUser);
}

//error
class ProfileError extends ProfileState{
  final String message;
  ProfileError (this.message);
}

