/*

      LOGIN PAGE

*/

import 'package:flutter/material.dart';
import 'package:proyectofinal/features/auth/presentation/components/my_button.dart';
import 'package:proyectofinal/features/auth/presentation/components/my_text_field.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  //Text controller
  final emailController = TextEditingController();
  final pwController = TextEditingController();


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
                  onTap: () {},
                  text: "Login"
                  ),

                const SizedBox(height: 50),
                //not a member? regirter now
                Text("Not a member? regirter now", 
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}