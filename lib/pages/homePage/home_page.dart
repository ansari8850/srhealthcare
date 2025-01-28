import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
return Scaffold(
  appBar: AppBar(
    toolbarHeight: MediaQuery.of(context).size.height/4.5,
    flexibleSpace: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
           end: Alignment.centerRight,
           begin: Alignment.bottomLeft,
          colors: [
          const Color.fromARGB(255, 48, 8, 159),
          const Color.fromARGB(255, 76, 35, 146).withOpacity(.6)
        ]),

        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10) , bottomRight: Radius.circular(10))
      ),
    ),
  ),
);
 }
}