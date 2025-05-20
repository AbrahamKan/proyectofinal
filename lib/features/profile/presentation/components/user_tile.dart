import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:proyectofinal/features/profile/domain/entities/profile_user.dart';

class UserTile extends StatelessWidget {
  final ProfileUser user;
  const UserTile({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(user.name),
      subtitle: Text(user.email),
      subtitleTextStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
    );
  }
}