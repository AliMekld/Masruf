import 'package:flutter/material.dart';
import 'package:masrof/utilites/extensions.dart';

class WalletScreen extends StatefulWidget {
  static const String routerName='WalletScreen';
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
     return Container(child: const Text("WalletScreen").center,);

  }
}