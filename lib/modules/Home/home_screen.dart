import 'package:flutter/material.dart';
import 'package:masrof/modules/MainLayout/main_layout.dart';
import 'package:masrof/utilites/extensions.dart';

class HomeScreen extends StatefulWidget {
  static const String routerName='homeScreen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(child: const Text("home").center,);
  }
}