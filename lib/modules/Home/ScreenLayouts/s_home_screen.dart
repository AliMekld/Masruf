import 'package:flutter/material.dart';
import 'package:masrof/modules/Home/home_controller.dart';
import 'package:state_extended/state_extended.dart';

class SmallHomeScreen extends StatefulWidget {
  const SmallHomeScreen({super.key});

  @override
  StateX<SmallHomeScreen> createState() => _SmallHomeScreenState();
}

class _SmallHomeScreenState extends StateX<SmallHomeScreen> {
  _SmallHomeScreenState() : super(controller: HomeController()) {
    con = HomeController();
  }
  late HomeController con;
  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}
