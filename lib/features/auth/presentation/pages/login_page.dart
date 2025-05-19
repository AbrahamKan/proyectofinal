/*

      LOGIN PAGE

*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyectofinal/features/auth/presentation/components/my_button.dart';
import 'package:proyectofinal/features/auth/presentation/components/my_text_field.dart';
import 'package:proyectofinal/features/auth/presentation/cubits/auth_cubit.dart';


class LoginPage extends StatefulWidget {
  final void Function()? togglePages;

  const LoginPage({super.key, required this.togglePages,});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  //Text controller
  final emailController = TextEditingController();
  final pwController = TextEditingController();

  // login button pressed
  void login() {
    //prepare email & pw
    final String email = emailController.text;
    final String pw = pwController.text;

    //auth cubit
    final authCubit = context.read<AuthCubit>();

    //ensure that the email & pw fiels are not empty
    if (email.isNotEmpty && pw.isNotEmpty){
      //login:
      authCubit.login(email, pw);
    }

    //display error if some fields are empty
    else{
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please enter both email and password')));
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    pwController.dispose();
    super.dispose();
  }

  //build UI
  @override
  Widget build(BuildContext context) {

    //SCAFFOLD
    return Scaffold(

      //BODY
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                // LOGO
              Icon(
                Icons.lock_open_rounded,
                size: 80,
                color: Theme.of(context).colorScheme.primary,
                ),

                const SizedBox(height: 50),

                // WELCOME BACK MSG
                Text("Welcome back, you've been missed!",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 25),
                //EMAIL TEXTFIELD
                MyTextField(
                  controller: emailController,
                  hintText: "Email",
                  obscureText: false,
                ),


                const SizedBox(height: 10),
                //PW TEXTFIELD
                MyTextField(
                  controller: pwController,
                  hintText: "Password",
                  obscureText: true,
                ),


                const SizedBox(height: 25),
                //LOGIN BUTTON
                MyButton(
                  onTap: login,
                  text: "Login"
                  ),

                const SizedBox(height: 50),
                //not a member? regirter now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Not a member?",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary),
                    ),
                    GestureDetector(
                      onTap: widget.togglePages,
                      child: Text(" regirter now",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary,
                        fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}