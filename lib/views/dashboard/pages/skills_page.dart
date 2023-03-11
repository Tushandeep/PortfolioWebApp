import 'package:flutter/material.dart';

import '../../../constants/constants.dart';

const Duration _duration = Duration(milliseconds: 700);

class SkillsPage extends StatefulWidget {
  const SkillsPage({
    super.key,
    required ScrollController controller,
  }) : _controller = controller;

  final ScrollController _controller;

  @override
  State<SkillsPage> createState() => _SkillsPageState();
}

class _SkillsPageState extends State<SkillsPage> {
  late Size _size;
  late ThemeData _theme;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _size = MediaQuery.of(context).size;
    _theme = Theme.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: _size.height - kAppHeight,
          width: double.maxFinite,
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: 6,
            horizontal: 22,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: _theme.colorScheme.primary,
              width: 3,
            ),
            borderRadius: BorderRadius.circular(100),
          ),
          child: Text(
            "Skills",
            style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
              color: _theme.colorScheme.primary,
            ),
          ),
        ),
        Transform.translate(
          offset: const Offset(0, -200),
          child: Transform.rotate(
            angle: 0,
            child: SkillTile(
              theme: _theme,
              mainSkill: "General Skills",
              subSkills: const [
                "Deep OOPS",
                "Debugging",
                "Clean Code",
                "Problem Solving",
              ],
            ),
          ),
        ),
        Transform.translate(
          offset: const Offset(380, -140),
          child: SkillTile(
            theme: _theme,
            mainSkill: "Flutter",
            subSkills: const [
              "Dart",
              "GetX",
              "Provider",
              "Bloc",
              "Localization",
              "Firebase",
              "Animation",
            ],
          ),
        ),
        Transform.translate(
          offset: const Offset(-380, -140),
          child: SkillTile(
            theme: _theme,
            mainSkill: "Tools",
            subSkills: const [
              "Git",
              "Github",
              "Postman",
              "VS Code",
              "Android Studio",
            ],
          ),
        ),
        Transform.translate(
          offset: const Offset(-300, 140),
          child: SkillTile(
            theme: _theme,
            mainSkill: "Databases",
            subSkills: const [
              "Realtime Database",
              "Sqflite",
              "Shared Preferences",
            ],
          ),
        ),
        Transform.translate(
          offset: const Offset(300, 140),
          child: SkillTile(
            theme: _theme,
            mainSkill: "Other",
            subSkills: const [
              "JSON",
              "API",
              "Problem Solving",
            ],
          ),
        ),
      ],
    );
  }
}

class SkillTile extends StatefulWidget {
  const SkillTile({
    super.key,
    required ThemeData theme,
    required String mainSkill,
    required List<String> subSkills,
  })  : _theme = theme,
        _mainSkill = mainSkill,
        _subSkills = subSkills;

  final ThemeData _theme;
  final List<String> _subSkills;
  final String _mainSkill;

  @override
  State<SkillTile> createState() => _SkillTileState();
}

class _SkillTileState extends State<SkillTile> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white,
          width: 3,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: ExpansionPanelList(
          elevation: 4,
          expandIconColor: widget._theme.colorScheme.primary,
          animationDuration: _duration,
          expansionCallback: (_, isOpen) {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          children: [
            ExpansionPanel(
              canTapOnHeader: true,
              isExpanded: isExpanded,
              backgroundColor: Colors.white24,
              headerBuilder: (_, isOpen) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 6,
                    horizontal: 16,
                  ),
                  child: Text(
                    widget._mainSkill,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: widget._theme.colorScheme.primary,
                    ),
                  ),
                );
              },
              body: SizedBox(
                width: double.maxFinite,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                      widget._subSkills.length,
                      (index) => Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Text(
                          widget._subSkills[index],
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
