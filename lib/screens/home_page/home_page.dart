import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {

  const HomePage({Key? key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(83, 0, 90, 1.0),
        // Remove the title
        title: null,
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: IconButton(
              icon: const Icon(Icons.search, size: 30, color: Colors.white,),
              onPressed: () {
              },
            ),
          ),
          const Spacer(),

          // Padding(
          //   padding: const EdgeInsets.only(right: 20.0),
          //   child:  Container(
          //     height: 40,
          //     width: 40,
          //     decoration: BoxDecoration(
          //       color: Colors.white,
          //       borderRadius: BorderRadius.circular(20),
          //     ),
          //     clipBehavior: Clip.antiAlias,
          //     child: Image.asset('assets/images/7.png', fit: BoxFit.contain,),
          //   ),
          // ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(83, 0, 90, 1.0), // Hex value for deep purple
              Color.fromRGBO(30, 0, 61, 1), // RGB values for purple
            ],
          ),
        ),
        child: const Padding(
          padding: EdgeInsets.only(left: 24.0, right: 24.0, bottom: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Radio Station',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.normal, color: Colors.white),
              ),
              SizedBox(height: 10),

            ],
          ),
        ),
      ),
    );
  }
}