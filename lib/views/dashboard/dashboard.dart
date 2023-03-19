import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

import '../../constants/constants.dart';
import '../../controllers/dashboard_controller.dart';
import '../../models/nav_item_model.dart';
import './pages/pages.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({
    super.key,
    required Size size,
  }) : _size = size;

  final Size _size;

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  late ThemeData _theme;
  late DashBoardController _controller;
  late ScrollController _scrollController;

  static final Map<int, GlobalKey> _keys = {
    0: GlobalKey(),
    1: GlobalKey(),
    2: GlobalKey(),
    3: GlobalKey(),
    4: GlobalKey(),
  };

  @override
  void initState() {
    super.initState();

    _controller = Get.find<DashBoardController>()
      ..maxScreenHeight(widget._size.height - kAppHeight);

    _controller.currPosOffset.listen((value) {
      if (value >= _controller.maxScreenHeight.value) {
        _controller.showSocials(false);
      } else if (value < _controller.maxScreenHeight.value / 2) {
        _controller.showSocials(true);
      }
    });

    _controller.factor.listen(
      (f) async {
        _controller.isScrolling(false);
        _controller.currPosOffset(
          _controller.maxScreenHeight.value * _controller.factor.value,
        );

        final BuildContext pageContext =
            _keys[_controller.factor.value]!.currentContext!;

        await Scrollable.ensureVisible(
          pageContext,
          alignment: 0.1,
          duration: const Duration(seconds: 1),
        );

        _controller.isScrolling(true);
      },
    );

    _scrollController = ScrollController()
      ..addListener(
        () {
          _controller.currPosOffset(_scrollController.offset);
          if (_controller.isScrolling.value) {
            final double height = _controller.maxScreenHeight.value;
            final double currPos = _controller.currPosOffset.value;

            if (currPos >= 0 && currPos < height) {
              _controller.factor(0);
              _controller.currPosOffset(0 * height);
            } else if (currPos >= height && currPos < height * 2) {
              _controller.factor(1);
              _controller.currPosOffset(1 * height);
            } else if (currPos >= height * 2 && currPos < height * 3) {
              _controller.factor(2);
              _controller.currPosOffset(2 * height);
            } else if (currPos >= height * 3 && currPos < height * 4) {
              _controller.factor(3);
              _controller.currPosOffset(3 * height);
            } else if (currPos >= height * 4 && currPos < height * 5) {
              _controller.factor(4);
              _controller.currPosOffset(4 * height);
            }
          }
        },
      );
  }

  final List<Widget> sections = <Widget>[
    HomePage(key: _keys[0]),
    AboutPage(key: _keys[1]),
    SkillsPage(key: _keys[2]),
    ExperiencePage(key: _keys[3]),
    ContactPage(key: _keys[4]),
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _theme = Theme.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          _controller.maxScreenHeight(
            max(kMinHeight, constraints.maxHeight - kAppHeight),
          );
          return Column(
            children: [
              _AppBar(
                controller: _controller,
                theme: _theme,
              ),
              Expanded(
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      controller: _scrollController,
                      child: Column(
                        children: List.generate(
                          sections.length,
                          (index) => sections[index],
                        ),
                      ),
                    ),
                    Obx(
                      () => AnimatedPositioned(
                        right: (_controller.showSocials.value) ? 30 : -60,
                        bottom: 30,
                        duration: const Duration(milliseconds: 700),
                        child: Column(
                          children: List.generate(
                            socials.length - 1,
                            (index) => buildSocialTile(socials[index]),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget buildSocialTile(SocialMedia social) {
    return GestureDetector(
      onTap: social.onPress,
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Container(
            height: 40,
            width: 40,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.transparent,
            ),
            child: FittedBox(
              fit: BoxFit.cover,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: social.image,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _AppBar extends StatefulWidget {
  const _AppBar({
    required DashBoardController controller,
    required ThemeData theme,
  })  : _controller = controller,
        _theme = theme;

  final DashBoardController _controller;
  final ThemeData _theme;

  @override
  State<_AppBar> createState() => _AppBarState();
}

class _AppBarState extends State<_AppBar> with SingleTickerProviderStateMixin {
  bool _isOpened = false;

  TextStyle get _style => TextStyle(
        color: widget._theme.colorScheme.primary,
        fontWeight: FontWeight.w600,
      );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kAppHeight,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            alignment: Alignment.centerLeft,
            clipBehavior: Clip.antiAlias,
            children: [
              AnimatedPositioned(
                left: (constraints.maxWidth < kMobileWidth) ? 10 : 30,
                duration: const Duration(milliseconds: 400),
                child: AnimatedContainer(
                  height: (constraints.maxWidth < kMobileWidth) ? 90 : 130,
                  width: (constraints.maxWidth < kMobileWidth) ? 90 : 130,
                  duration: const Duration(milliseconds: 500),
                  child: Image.asset(
                    "assets/images/tushan_logo_c.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Obx(
                () {
                  if (widget._controller.factor.value > 0 &&
                      constraints.maxWidth < kMobileWidth) {
                    return Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Tushandeep Singh",
                        style: TextStyle(
                          color: widget._theme.colorScheme.primary,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ).animate(autoPlay: true).fade(
                          begin: 0,
                          end: 1,
                          duration: const Duration(seconds: 1),
                        );
                  }
                  return const Center();
                },
              ),

              // Nav Bar in Desktop View...
              if (constraints.maxWidth >= kMobileWidth)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: List.generate(
                    (constraints.maxWidth < 800)
                        ? navItems.length - 2
                        : navItems.length,
                    (index) => buildNavTile(
                      navItems[index],
                    ),
                  ),
                ),

              // Menu Icon for Mobile View...
              if (constraints.maxWidth < 800)
                Positioned(
                  right: 20,
                  child: StatefulBuilder(
                    builder: (context, update) {
                      return PopupMenuButton<int>(
                        onOpened: () => update(() {
                          _isOpened = true;
                        }),
                        onCanceled: () => update(() {
                          _isOpened = false;
                        }),
                        onSelected: (index) {
                          widget._controller.factor(index);
                          widget._controller.currPosOffset(
                            widget._controller.maxScreenHeight.value *
                                widget._controller.factor.value,
                          );

                          _isOpened = false;
                          update(() {});
                        },
                        tooltip: "",
                        padding: const EdgeInsets.all(8),
                        color: Colors.black,
                        offset: const Offset(0, 44),
                        splashRadius: 1,
                        iconSize: 32,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        icon: Icon(
                          (_isOpened) ? Icons.close : Icons.menu,
                          color: widget._theme.colorScheme.primary,
                        ),
                        itemBuilder: (context) => [
                          if (constraints.maxWidth < kMobileWidth)
                            PopupMenuItem(
                              value: 0,
                              child: Text(
                                "Home",
                                style: _style,
                              ),
                            ),
                          if (constraints.maxWidth < kMobileWidth)
                            PopupMenuItem(
                              value: 1,
                              child: Text(
                                "About",
                                style: _style,
                              ),
                            ),
                          if (constraints.maxWidth < kMobileWidth)
                            PopupMenuItem(
                              value: 2,
                              child: Text(
                                "Skills",
                                style: _style,
                              ),
                            ),
                          PopupMenuItem(
                            value: 3,
                            child: Text(
                              "Experience",
                              style: _style,
                            ),
                          ),
                          PopupMenuItem(
                            value: 4,
                            child: Text(
                              "Contact",
                              style: _style,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget buildNavTile(NavItem item) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GestureDetector(
        onTap: () {
          widget._controller.factor(item.value);
          widget._controller.currPosOffset(
            widget._controller.maxScreenHeight.value *
                widget._controller.factor.value,
          );
          item.onPress;
        },
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Obx(
            () {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.only(bottom: 6),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: (widget._controller.factor.value == item.value)
                              ? widget._theme.colorScheme.primary
                              : Colors.transparent,
                          width: 2,
                        ),
                      ),
                    ),
                    child: Text(
                      item.label,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight:
                            (widget._controller.factor.value == item.value)
                                ? FontWeight.bold
                                : null,
                        color: (widget._controller.factor.value == item.value)
                            ? widget._theme.colorScheme.primary
                            : Colors.grey,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
