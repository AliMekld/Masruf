import 'package:flutter/material.dart';
import 'package:masrof/utilites/extensions.dart';

class ProfileScreen extends StatefulWidget {
  static const String routerName = 'ProfileScreen';
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Text("Profile").center,
    );
  }
}
