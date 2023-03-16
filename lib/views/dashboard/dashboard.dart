import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/constants.dart';
import '../../controllers/dashboard_controller.dart';
import '../../models/nav_item_model.dart';
import './pages/pages.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  late ThemeData _theme;
  late DashBoardController _controller;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    _controller = Get.find<DashBoardController>()
      ..maxScreenHeight(widget.size.height - kAppHeight);

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

        _scrollController.animateTo(
          _controller.currPosOffset.value,
          duration: const Duration(seconds: 1),
          curve: Curves.ease,
        );

        await Future.delayed(const Duration(milliseconds: 1100));

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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _theme = Theme.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                    children: [
                      HomePage(controller: _scrollController),
                      AboutPage(controller: _scrollController),
                      const SkillsPage(),
                      const ExperiencePage(),
                      const ContactPage(),
                    ],
                  ),
                ),
                Obx(
                  () => AnimatedPositioned(
                    right: (_controller.showSocials.value) ? 60 : -60,
                    bottom: 30,
                    duration: const Duration(milliseconds: 700),
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 80,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: _theme.colorScheme.primary,
                              width: 2,
                            ),
                            color: _theme.colorScheme.primary,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        ...List.generate(
                          socials.length,
                          (index) => buildSocialTile(socials[index]),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
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

class _AppBar extends StatelessWidget {
  const _AppBar({
    required DashBoardController controller,
    required ThemeData theme,
  })  : _controller = controller,
        _theme = theme;

  final DashBoardController _controller;
  final ThemeData _theme;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kAppHeight,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          AnimatedPositioned(
            left: 30,
            duration: const Duration(milliseconds: 400),
            child: SizedBox(
              height: 130,
              width: 130,
              child: Image.asset(
                "assets/images/tushan_logo_c.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: List.generate(
              navItems.length,
              (index) => buildNavTile(
                navItems[index],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildNavTile(NavItem item) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GestureDetector(
        onTap: () {
          _controller.factor(item.value);
          _controller.currPosOffset(
            _controller.maxScreenHeight.value * _controller.factor.value,
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
                          color: (_controller.factor.value == item.value)
                              ? _theme.colorScheme.primary
                              : Colors.transparent,
                          width: 2,
                        ),
                      ),
                    ),
                    child: Text(
                      item.label,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: (_controller.factor.value == item.value)
                            ? FontWeight.bold
                            : null,
                        color: (_controller.factor.value == item.value)
                            ? _theme.colorScheme.primary
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
