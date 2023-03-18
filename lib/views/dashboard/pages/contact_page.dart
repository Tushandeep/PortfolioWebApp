import 'dart:html';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constants/constants.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  late Size _size;
  late ThemeData _theme;

  void downloadResume() {
    AnchorElement element = AnchorElement(href: "/assets/images/cv.png");
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

  List<Widget> _children(bool isMobile) => [
        Expanded(
          flex: (isMobile) ? 6 : 1,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: (isMobile)
                      ? CrossAxisAlignment.center
                      : CrossAxisAlignment.end,
                  children: <Widget>[
                    FittedBox(
                      fit: BoxFit.cover,
                      child: Text(
                        "Contact Me",
                        style: TextStyle(
                          fontSize: 50,
                          color: _theme.colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: 160,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(
                          2,
                          (index) => MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: socials[index].onPress,
                              child: Container(
                                height: 70,
                                width: 70,
                                padding: const EdgeInsets.all(14),
                                decoration: BoxDecoration(
                                  color: Colors.black45,
                                  borderRadius: BorderRadius.circular(10),
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
                      width: 160,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(
                          2,
                          (index) => MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: socials[index + 2].onPress,
                              child: Container(
                                height: 70,
                                width: 70,
                                padding: const EdgeInsets.all(14),
                                decoration: BoxDecoration(
                                  color: Colors.black45,
                                  borderRadius: BorderRadius.circular(10),
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
        const SizedBox(height: 10),
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
            ],
          ),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: max(kMinHeight, _size.height - kAppHeight + 50),
      width: double.maxFinite,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            flex: 8,
            child: LayoutBuilder(builder: (context, constraints) {
              if (constraints.maxWidth < kMobileWidth) {
                return Column(children: _children(true));
              }
              return Row(children: _children(false));
            }),
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
