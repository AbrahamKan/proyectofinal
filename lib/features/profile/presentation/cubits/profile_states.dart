/*

PROFILE STATES

 */

abstract class ProfileState {}

//initial
class ProfileInitial extends ProfileState{}

// loading...
class ProfileLoading extends ProfileState {}

//loaded
class ProfileLoaded extends ProfileState {
  final ProfileError profileUser;
  ProfileLoaded(this.profileUser);
}

//error
class ProfileError extends ProfileState{
  final String message;
  ProfileError (this.message);
}

