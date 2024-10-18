import 'package:flutter/material.dart';

class MainLayout extends StatefulWidget {
  final String routeName;
  final Widget child;
  const MainLayout({
    super.key,
    required this.routeName,
    required this.child,
  });

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      // bottomNavigationBar: Butt,
    );
  }
}
