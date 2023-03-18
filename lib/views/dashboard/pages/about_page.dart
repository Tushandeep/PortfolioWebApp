import 'dart:math';

import 'package:flutter/material.dart';

import '../../../constants/constants.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({
    super.key,
  });

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> with TickerProviderStateMixin {
  late Size _size;
  late ThemeData _theme;

  late int _age;

  @override
  void initState() {
    super.initState();

    final int year = DateTime.now().year - 2001;
    if (DateTime.now().month <= 10) {
      if (DateTime.now().day < 8) {
        _age = year - 1;
      } else {
        _age = year;
      }
    } else {
      _age = year;
    }
  }

  List<Widget> _children() => <Widget>[
        Expanded(
          child: Stack(
            alignment: Alignment.center,
            children: [
              FittedBox(
                fit: BoxFit.cover,
                child: Container(
                  height: 500,
                  width: 500,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(400),
                    child: Image.asset(
                      "assets/images/my_image.png",
                      fit: BoxFit.cover,
                      height: 460,
                      width: 460,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 50,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "About Me",
                  style: TextStyle(
                    fontSize: 40,
                    color: _theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  padding: const EdgeInsets.only(
                    left: 10,
                    top: 10,
                    bottom: 10,
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      left: BorderSide(
                        color: _theme.colorScheme.primary,
                        width: 3,
                      ),
                    ),
                  ),
                  child: Text(
                    "My name is Tushandeep Singh and I'm $_age years old. I'm passionate about developing Hybrid Mobile Applications using Flutter SDK and Dart, looking for opportunities as a App Developer with a team of developers that can enrich my knowledge in Flutter & Dart. I love to solve problems using technology that improves user's life on a major scale. Over the last several years, I have been developing and leading various mobile apps in different areas. ",
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _size = MediaQuery.of(context).size;
    _theme = Theme.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: max(kMinHeight, _size.height - kAppHeight),
      width: double.maxFinite,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth < kMobileWidth || constraints.maxWidth < 690) {
          return Column(
            children: [_children().last],
          );
        }
        return Row(children: _children());
      }),
    );
  }
}
