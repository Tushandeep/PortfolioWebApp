import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/constants.dart';
import '../../../controllers/dashboard_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Size _size;

  final List<Widget> _children = <Widget>[
    const Expanded(
      child: Stack(
        alignment: Alignment.center,
        children: [
          FittedBox(
            fit: BoxFit.cover,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                MyNameWidget(),
                SizedBox(height: 14),
                DescriptionWidget(),
                SizedBox(height: 30),
                ContactMeButton(),
              ],
            ),
          ),
        ],
      ),
    ),
    Expanded(
      child: Stack(
        alignment: Alignment.centerLeft,
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
  ];
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _size = MediaQuery.of(context).size;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: max(kMinHeight, _size.height - kAppHeight),
      width: double.maxFinite,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < kMobileWidth) {
            return Column(
              children: _children.reversed.toList(),
            );
          }
          return Row(children: _children);
        },
      ),
    );
  }
}

class DescriptionWidget extends StatefulWidget {
  const DescriptionWidget({
    super.key,
  });

  @override
  State<DescriptionWidget> createState() => _DescriptionWidgetState();
}

class _DescriptionWidgetState extends State<DescriptionWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Text(
      "Hybrid App Developer,\nFlutter & Dart",
      style: TextStyle(
        fontSize: 30,
        color: Colors.white,
      ),
    );
  }
}

class MyNameWidget extends StatefulWidget {
  const MyNameWidget({
    super.key,
  });

  @override
  State<MyNameWidget> createState() => _MyNameWidgetState();
}

class _MyNameWidgetState extends State<MyNameWidget> {
  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Text(
          "I' m  ",
          style: TextStyle(
            fontSize: 30,
            color: Colors.white,
          ),
        ),
        MyNameTypingEffect(),
      ],
    );
  }
}

class MyNameTypingEffect extends StatefulWidget {
  const MyNameTypingEffect({super.key});

  @override
  State<MyNameTypingEffect> createState() => _MyNameTypingEffectState();
}

class _MyNameTypingEffectState extends State<MyNameTypingEffect> {
  late ThemeData _theme;

  late DashBoardController _dashBoardController;
  late List<Widget> nameList;

  int index = 0;

  final String _name = "Tushandeep Singh";
  String _name1 = "";

  bool blink = false;

  @override
  void initState() {
    super.initState();

    _dashBoardController = Get.find<DashBoardController>();

    nameList = <Widget>[];

    _dashBoardController.blinking.listen(
      (val) {
        Future.delayed(
          const Duration(milliseconds: 200),
          () {
            if (_name == _name1) {
              _dashBoardController.blinking(false);
            } else {
              _dashBoardController.blinking(!val);
              _name1 += _name[index++];
            }
          },
        );
      },
    );

    Future.delayed(const Duration(milliseconds: 1500), () {
      _dashBoardController.blinking(true);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _theme = Theme.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SizedBox(
        width: 420,
        child: Row(
          children: [
            Text(
              _name1,
              style: TextStyle(
                color: _theme.colorScheme.primary,
                fontWeight: FontWeight.bold,
                fontSize: 50,
              ),
            ),
            Container(
              height: 60,
              decoration: BoxDecoration(
                border: Border.all(
                  color: (_dashBoardController.blinking.value)
                      ? _theme.colorScheme.primary
                      : Colors.transparent,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ContactMeButton extends StatefulWidget {
  const ContactMeButton({
    super.key,
  });

  @override
  State<ContactMeButton> createState() => _ContactMeButtonState();
}

class _ContactMeButtonState extends State<ContactMeButton> {
  late ThemeData _theme;

  bool _onHover = false;

  late DashBoardController _dashBoardController;

  @override
  void initState() {
    super.initState();

    _dashBoardController = Get.find<DashBoardController>();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _theme = Theme.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) {
        setState(() {
          _onHover = true;
        });
      },
      onExit: (_) {
        setState(() {
          _onHover = false;
        });
      },
      child: MaterialButton(
        onPressed: () {
          _dashBoardController.factor(4);
        },
        splashColor: _theme.colorScheme.primary.withOpacity(0.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: _theme.colorScheme.primary,
            width: 4,
          ),
        ),
        color: (_onHover)
            ? _theme.colorScheme.primary
            : _theme.scaffoldBackgroundColor,
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 32,
        ),
        child: Text(
          "Contact Me",
          style: TextStyle(
            color: (_onHover) ? Colors.white : _theme.colorScheme.primary,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
