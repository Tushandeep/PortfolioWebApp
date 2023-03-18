import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import './constants/theme.dart';
import './views/dashboard/dashboard.dart';
import './controllers/dashboard_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Size _size;
  late DashBoardController _controller;

  void _initControllers() {
    _controller = Get.put<DashBoardController>(DashBoardController());
  }

  @override
  void initState() {
    super.initState();

    _initControllers();

    final size = window.physicalSize;
    print("ASDASD");
    print(size.height);
    print(size.width);
    print("QWQWEQWEQWE");
    _controller.maxScreenHeight(size.height);
    _controller.maxScreenWidth(size.width);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _size = MediaQuery.of(context).size;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tushandeep Singh',
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: Stack(
        alignment: Alignment.center,
        children: [
          DashBoardScreen(size: _size),
        ],
      ),
      // home: const TempScreen(),
    );
  }
}
