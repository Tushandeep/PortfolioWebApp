import 'dart:html';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constants/constants.dart';
import '../../../controllers/dashboard_controller.dart';

const Duration _startDuration = Duration(seconds: 1);

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage>
    with SingleTickerProviderStateMixin {
  late Size _size;
  late ThemeData _theme;
  late DashBoardController _dashBoardController;

  late Animation<Offset> _slideAnimation;
  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    _dashBoardController = Get.find<DashBoardController>();

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

    final double maxHeight = _dashBoardController.maxScreenHeight.value * 2;

    _dashBoardController.currPosOffset.listen(
      (val) {
        if (val >= maxHeight && !_animationController.isAnimating) {
          _animationController.forward();
        }
      },
    );
  }

  void downloadResume() {
    AnchorElement element = AnchorElement(href: "/assets/cv/cv.pdf");
    element.download = "Resume";
    element.click();
  }

  void mailMe() async {
    const String url = "mailto:$mail";
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _size = MediaQuery.of(context).size;
    _theme = Theme.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _size.height - kAppHeight,
      width: double.maxFinite,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Contact Me",
                              style: TextStyle(
                                fontSize: 50,
                                color: _theme.colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 30),
                            SizedBox(
                              width: 180,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: List.generate(
                                  2,
                                  (index) => MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: GestureDetector(
                                      onTap: socials[index].onPress,
                                      child: Container(
                                        height: 80,
                                        width: 80,
                                        padding: const EdgeInsets.all(14),
                                        decoration: BoxDecoration(
                                          color: Colors.black45,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                            color: _theme.colorScheme.primary,
                                            width: 1,
                                          ),
                                        ),
                                        child: socials[index].image,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: 180,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: List.generate(
                                  2,
                                  (index) => MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: GestureDetector(
                                      onTap: socials[index + 2].onPress,
                                      child: Container(
                                        height: 80,
                                        width: 80,
                                        padding: const EdgeInsets.all(14),
                                        decoration: BoxDecoration(
                                          color: Colors.black45,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                            color: _theme.colorScheme.primary,
                                            width: 1,
                                          ),
                                        ),
                                        child: socials[index + 2].image,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            ContactTile(
                              theme: _theme,
                              icon: Icons.download_rounded,
                              info: "Resume",
                              onTap: downloadResume,
                            ),
                            const SizedBox(height: 20),
                            ContactTile(
                              theme: _theme,
                              icon: Icons.phone_rounded,
                              info: phone,
                            ),
                            const SizedBox(height: 20),
                            ContactTile(
                              theme: _theme,
                              icon: Icons.location_pin,
                              info: location,
                            ),
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
                        child: AnimatedBuilder(
                          animation: _animationController,
                          builder: (context, _) {
                            return Transform.translate(
                              offset: _slideAnimation.value,
                              child: AnimatedOpacity(
                                opacity: _opacityAnimation.value,
                                duration: _startDuration,
                                child: Container(
                                  height: 500,
                                  width: 500,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(700),
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
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                "\"Thanks for Visiting\"",
                style: TextStyle(
                  fontSize: 40,
                  color: _theme.colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ContactTile extends StatefulWidget {
  const ContactTile({
    super.key,
    required ThemeData theme,
    required IconData icon,
    required String info,
    Function()? onTap,
  })  : _theme = theme,
        _icon = icon,
        _info = info,
        _onTap = onTap;

  final ThemeData _theme;
  final IconData _icon;
  final String _info;
  final Function()? _onTap;

  @override
  State<ContactTile> createState() => _ContactTileState();
}

class _ContactTileState extends State<ContactTile> {
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: (widget._onTap != null)
          ? SystemMouseCursors.click
          : MouseCursor.defer,
      child: GestureDetector(
        onTap: widget._onTap,
        child: Container(
          width: 180,
          height: 50,
          padding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 18,
          ),
          decoration: BoxDecoration(
            color: Colors.black45,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: widget._theme.colorScheme.primary,
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(widget._icon, color: widget._theme.colorScheme.primary),
              const SizedBox(width: 8),
              Text(
                widget._info,
                style: TextStyle(color: widget._theme.colorScheme.primary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
