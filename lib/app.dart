import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyectofinal/features/auth/data/firebase_auth_repo.dart';
import 'package:proyectofinal/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:proyectofinal/features/auth/presentation/cubits/auth_states.dart';
import 'package:proyectofinal/features/post/data/firebase_post_repo.dart';
import 'package:proyectofinal/features/post/presentation/cubits/post_cubit.dart';
import 'package:proyectofinal/features/profile/data/firebase_profile_repo.dart';
import 'package:proyectofinal/features/profile/presentation/cubits/profile_cubit.dart';
import 'package:proyectofinal/features/search/data/firebase_search_repo.dart';
import 'package:proyectofinal/features/search/presentation/cubits/search_cubit.dart';
import 'package:proyectofinal/features/storage/data/firebase_storage_repo.dart';
import 'features/auth/presentation/pages/auth_page.dart';
import 'features/home/presentation/pages/home_page.dart';
import 'themes/light_mode.dart';

/*

APP - Root level

*/



class MyApp extends StatelessWidget {

  //auth repo
  final firebaseAuthRepo = FirebaseAuthRepo();

  //profile repo
  final firebaseProfileRepo = FirebaseProfileRepo();

  // storage repo
  final firebaseStorageRepo = FirebaseStorageRepo();

  //post repo
  final firebasePostRepo = FirebasePostRepo();

  //search repo
  final firebaseSearchRepo = FirebaseSearchRepo();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //provide cubits to app
    return MultiBlocProvider(
      providers: [
        //auth cubit
          BlocProvider<AuthCubit>(
            create: (context) => AuthCubit(authRepo: firebaseAuthRepo)..checkAuth(),
          ),

        //profile cubit
        BlocProvider<ProfileCubit>(
          create: (context) => ProfileCubit(
            profileRepo: firebaseProfileRepo,
            storageRepo: firebaseStorageRepo,
          ),
        ),

        //post cubit
        BlocProvider<PostCubit>(create: (context) => PostCubit(
          postRepo: firebasePostRepo, storageRepo: firebaseStorageRepo,
          ),
        ),

        //search cubit
        BlocProvider<SearchCubit>(
          create: (context) => SearchCubit(searchRepo: firebaseSearchRepo),
        ),
      ],
      child: MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightMode,
      home: BlocConsumer<AuthCubit, AuthState>(
        builder: (context, authState) {
          print(authState);

          // unauthenticated
          if (authState is Unauthenticated){
            return const AuthPage();
          }

          //authenticaded
          if(authState is Authenticated){
            return const HomePage();
          }
          //loading...
          else {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
                ),
            );
          }
        },

        //Listener for errors..
        listener: (context, state) {
          if(state is AuthError){
            ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
          }
         },
       ),
      ),
    );
  }
}

