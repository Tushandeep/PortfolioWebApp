import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/dashboard_controller.dart';
import '../../../constants/constants.dart';

const Duration _duration = Duration(milliseconds: 550);

class AboutPage extends StatefulWidget {
  const AboutPage({
    super.key,
    required ScrollController controller,
  }) : _controller = controller;

  final ScrollController _controller;

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> with TickerProviderStateMixin {
  late Size _size;
  late ThemeData _theme;

  late DashBoardController _dashBoardController;
  late AnimationController _animationControllerAboutMeLabel;
  late AnimationController _animationControllerAboutMeValue;

  late Animation<Offset> _slideAnimation;
  late Animation<double> _opacityAnimation;

  late Animation<double> _opacityAnimationValue;

  late int age;
  late double maxWidth, start, stop, height = 311;

  bool animating = true;

  double get offset =>
      widget._controller.hasClients ? widget._controller.offset : 0;

  @override
  void initState() {
    super.initState();

    _dashBoardController = Get.find<DashBoardController>();

    maxWidth = _dashBoardController.maxScreenWidth.value;

    _animationControllerAboutMeLabel = AnimationController(
      vsync: this,
      duration: _duration,
    );

    _animationControllerAboutMeValue = AnimationController(
      vsync: this,
      duration: _duration,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 20),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationControllerAboutMeLabel,
        curve: Curves.ease,
      ),
    );

    _opacityAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _animationControllerAboutMeLabel,
        curve: Curves.ease,
      ),
    );

    _opacityAnimationValue = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _animationControllerAboutMeValue,
        curve: Curves.ease,
      ),
    );

    final int year = DateTime.now().year - 2001;
    if (DateTime.now().month <= 10) {
      if (DateTime.now().day < 8) {
        age = year - 1;
      } else {
        age = year;
      }
    } else {
      age = year;
    }

    start = _dashBoardController.maxScreenWidth.value *
        _dashBoardController.factor.value;

    stop = _dashBoardController.maxScreenWidth.value *
        (_dashBoardController.factor.value + 1);

    _dashBoardController.currPosOffset.listen((val) {
      if (val >= maxWidth - 200 && animating) {
        _animationControllerAboutMeLabel.forward();
        animating = false;
      } else if (val < maxWidth) {
        _animationControllerAboutMeLabel.reverse();
        animating = true;
      }
    });
  }

  double get setOpacity {
    if (offset < start) {
      return 0;
    } else if (offset > stop) {
      return 1;
    }
    return (offset - start) / (stop - start);
  }

  double get setOffset {
    if (offset < start) {
      return -1;
    } else if (offset > stop) {
      return 0;
    }
    return -1.0 + ((offset - start) / (stop - start));
  }

  double get setContainerHeight {
    if (offset - 40 < start) {
      return 0;
    } else if (offset - 40 > stop) {
      return height;
    }
    var containerHeight = height * ((offset - 40 - start) / (stop - start));
    if (containerHeight >= 250) {
      _animationControllerAboutMeValue.forward();
    } else if (containerHeight < 100) {
      _animationControllerAboutMeValue.reverse();
    }
    return containerHeight;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _size = MediaQuery.of(context).size;
    _theme = Theme.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _size.height - kAppHeight,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedBuilder(
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
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
                right: 120,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  AnimatedBuilder(
                    animation: _animationControllerAboutMeLabel,
                    builder: (context, _) {
                      return AnimatedOpacity(
                        opacity: _opacityAnimation.value,
                        duration: _duration,
                        child: Transform.translate(
                          offset: _slideAnimation.value,
                          child: Text(
                            "About Me",
                            style: TextStyle(
                              fontSize: 40,
                              color: _theme.colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 30),
                  AnimatedBuilder(
                    animation: widget._controller,
                    builder: (context, _) {
                      return AnimatedContainer(
                        height: setContainerHeight,
                        curve: Curves.ease,
                        padding: const EdgeInsets.only(left: 10),
                        duration: Duration.zero,
                        decoration: BoxDecoration(
                          border: Border(
                            left: BorderSide(
                              color: _theme.colorScheme.primary,
                              width: 3,
                            ),
                          ),
                        ),
                        child: AnimatedOpacity(
                          opacity: _opacityAnimationValue.value,
                          duration: _duration,
                          child: Text(
                            "My name is Tushandeep Singh and I'm $age years old. I'm passionate about developing Hybrid Mobile Applications using Flutter SDK and Dart, looking for opportunities as a App Developer with a team of developers that can enrich my knowledge in Flutter & Dart. I love to solve problems using technology that improves user's life on a major scale. Over the last several years, I have been developing and leading various mobile apps in different areas. ",
                            style: const TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
