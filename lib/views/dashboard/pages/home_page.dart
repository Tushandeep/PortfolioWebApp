import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/constants.dart';
import '../../../controllers/dashboard_controller.dart';

const Duration _duration = Duration(milliseconds: 550);
const Duration _startDuration = Duration(seconds: 1);

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required ScrollController controller,
  }) : _controller = controller;

  final ScrollController _controller;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late ThemeData _theme;
  late Size _size;
  late DashBoardController _dashBoardController;

  late Animation<Offset> _slideAnimation;
  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;

  late double start, stop;

  double get offset =>
      widget._controller.hasClients ? widget._controller.offset : 0;

  @override
  void initState() {
    super.initState();

    _dashBoardController = Get.find<DashBoardController>();

    start = _dashBoardController.maxScreenHeight.value *
        _dashBoardController.factor.value;

    stop = _dashBoardController.maxScreenHeight.value *
        (_dashBoardController.factor.value + 1);

    _animationController = AnimationController(
      vsync: this,
      duration: _startDuration,
      reverseDuration: _startDuration,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(400, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _opacityAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );

    _animationController.forward();
  }

  double get setOpacity {
    if (offset < start) {
      return 0;
    } else if (offset > stop) {
      return 1;
    }
    return 1 - (offset - start) / (stop - start);
  }

  double get setOffset {
    if (offset < start) {
      return -1;
    } else if (offset > stop) {
      return 0;
    }
    return 1.0 - ((offset - start) / (stop - start));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _theme = Theme.of(context);
    _size = MediaQuery.of(context).size;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _size.height - kAppHeight,
      child: Row(
        children: <Widget>[
          SizedBox(
            width: _size.width * 0.5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    MyNameWidget(
                      theme: _theme,
                      controller: _animationController,
                    ),
                    const SizedBox(height: 14),
                    DescriptionWidget(
                      controller: _animationController,
                    ),
                    const SizedBox(height: 30),
                    ContactMeButton(
                      controller: _animationController,
                    ),
                  ],
                ),
                const Spacer(),
              ],
            ),
          ),
          SizedBox(
            width: _size.width * 0.5,
            child: Row(
              children: [
                AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, _) {
                    return Transform.translate(
                      offset: _slideAnimation.value,
                      child: AnimatedOpacity(
                        opacity: _opacityAnimation.value,
                        duration: _startDuration,
                        child: AnimatedBuilder(
                          animation: widget._controller,
                          builder: (context, _) {
                            return AnimatedOpacity(
                              opacity: setOpacity,
                              duration: _duration,
                              child: Transform.scale(
                                scale: setOpacity,
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
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
                const Spacer(),
              ],
            ),
          ),
          // const Spacer(flex: 2),
        ],
      ),
    );
  }
}

class DescriptionWidget extends StatefulWidget {
  const DescriptionWidget({
    super.key,
    required AnimationController controller,
  }) : _controller = controller;

  final AnimationController _controller;

  @override
  State<DescriptionWidget> createState() => _DescriptionWidgetState();
}

class _DescriptionWidgetState extends State<DescriptionWidget> {
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _opacityAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: widget._controller,
        curve: Curves.ease,
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 20),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: widget._controller,
        curve: Curves.ease,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget._controller,
      builder: (context, _) {
        return Transform.translate(
          offset: _slideAnimation.value,
          child: AnimatedOpacity(
            opacity: _opacityAnimation.value,
            duration: _startDuration,
            child: const Text(
              "Hybrid App Developer,\nFlutter & Dart",
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }
}

class MyNameWidget extends StatefulWidget {
  const MyNameWidget({
    super.key,
    required ThemeData theme,
    required AnimationController controller,
  })  : _theme = theme,
        _controller = controller;

  final ThemeData _theme;
  final AnimationController _controller;

  @override
  State<MyNameWidget> createState() => _MyNameWidgetState();
}

class _MyNameWidgetState extends State<MyNameWidget> {
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _slideAnimation;

  // Code about the Typing Effect in of my name "Tushandeep Singh"....

  @override
  void initState() {
    super.initState();

    _opacityAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: widget._controller,
        curve: Curves.easeInOut,
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 20.0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: widget._controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AnimatedBuilder(
          animation: widget._controller,
          builder: (context, _) {
            return AnimatedOpacity(
              opacity: _opacityAnimation.value,
              duration: _startDuration,
              child: Transform.translate(
                offset: _slideAnimation.value,
                child: const Text(
                  "I' m  ",
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
              ),
            );
          },
        ),
        MyNameTypingEffect(theme: widget._theme),
      ],
    );
  }
}

class MyNameTypingEffect extends StatefulWidget {
  const MyNameTypingEffect({super.key, required ThemeData theme})
      : _theme = theme;

  final ThemeData _theme;

  @override
  State<MyNameTypingEffect> createState() => _MyNameTypingEffectState();
}

class _MyNameTypingEffectState extends State<MyNameTypingEffect> {
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
  Widget build(BuildContext context) {
    return Obx(
      () => SizedBox(
        width: 420,
        child: Row(
          children: [
            Text(
              _name1,
              style: TextStyle(
                color: widget._theme.colorScheme.primary,
                fontWeight: FontWeight.bold,
                fontSize: 50,
              ),
            ),
            Container(
              height: 60,
              decoration: BoxDecoration(
                border: Border.all(
                  color: (_dashBoardController.blinking.value)
                      ? widget._theme.colorScheme.primary
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
  const ContactMeButton({super.key, required AnimationController controller})
      : _controller = controller;

  final AnimationController _controller;

  @override
  State<ContactMeButton> createState() => _ContactMeButtonState();
}

class _ContactMeButtonState extends State<ContactMeButton> {
  late ThemeData _theme;

  bool _onHover = false;

  late Animation<double> _opacityAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _opacityAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: widget._controller,
        curve: Curves.ease,
      ),
    );

    _scaleAnimation = Tween<double>(
      begin: 3,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: widget._controller,
        curve: Curves.ease,
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _theme = Theme.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget._controller,
      builder: (context, _) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: AnimatedOpacity(
            opacity: _opacityAnimation.value,
            duration: _startDuration,
            child: MouseRegion(
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
                onPressed: () {},
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
                    color:
                        (_onHover) ? Colors.white : _theme.colorScheme.primary,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
