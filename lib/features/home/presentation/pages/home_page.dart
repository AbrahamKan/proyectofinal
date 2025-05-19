import 'package:flutter/material.dart';
import 'package:proyectofinal/features/home/presentation/components/my_drawer.dart';

import '../../../post/presentation/pages/upload_post_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //BUILD UI
  @override
  Widget build(BuildContext context) {

    //SCAFFOLD
    return Scaffold(

      //APP BAR
      appBar: AppBar(
        title: const Center(child: Text("Home")),
        foregroundColor: Theme.of(context).colorScheme.primary,
        actions: [
          //upload new post button
          IconButton(onPressed: () => Navigator.push(
            context, 
            MaterialPageRoute(
              builder: (context) => const UploadPostPage(),
              ),
            ), 
          icon: const Icon(Icons.add),
          )
        ],
      ),

      //DRAWER
      drawer: const MyDrawer(),
    );
  }
}