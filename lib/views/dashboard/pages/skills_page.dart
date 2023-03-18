import 'dart:math';

import 'package:flutter/material.dart';

import '../../../constants/constants.dart';

class SkillsPage extends StatefulWidget {
  const SkillsPage({super.key});

  @override
  State<SkillsPage> createState() => _SkillsPageState();
}

class _SkillsPageState extends State<SkillsPage> {
  late Size _size;
  late ThemeData _theme;

  final List<Widget> _childrens = <Widget>[
    const SkillTile(
      mainSkill: "General Skills",
      subSkills: [
        "Deep OOPS",
        "Debugging",
        "Clean Code",
        "Problem Solving",
      ],
    ),
    const SkillTile(
      mainSkill: "Flutter",
      subSkills: [
        "Dart",
        "GetX",
        "Provider",
        "Bloc",
        "Localization",
        "Firebase",
        "Animation",
      ],
    ),
    const SkillTile(
      mainSkill: "Tools",
      subSkills: [
        "Git",
        "Github",
        "Postman",
        "VS Code",
        "Android Studio",
      ],
    ),
    const SkillTile(
      mainSkill: "Databases",
      subSkills: [
        "Realtime Database",
        "Sqflite",
        "Shared Preferences",
      ],
    ),
    const SkillTile(
      mainSkill: "Other",
      subSkills: [
        "JSON",
        "API",
        "Problem Solving",
      ],
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
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Expanded(child: SkillsLabelWidget(theme: _theme)),
          Expanded(
            flex: 4,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Wrap(
                    spacing: 20,
                    runSpacing: 30,
                    alignment: WrapAlignment.center,
                    children: _childrens,
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SkillsLabelWidget extends StatelessWidget {
  const SkillsLabelWidget({
    super.key,
    required ThemeData theme,
  }) : _theme = theme;
  final ThemeData _theme;

  @override
  Widget build(BuildContext context) {
    return Text(
      "Skills",
      style: TextStyle(
        fontSize: 50,
        fontWeight: FontWeight.bold,
        color: _theme.colorScheme.primary,
      ),
    );
  }
}

class SkillTile extends StatefulWidget {
  const SkillTile({
    super.key,
    required String mainSkill,
    required List<String> subSkills,
  })  : _mainSkill = mainSkill,
        _subSkills = subSkills;

  final List<String> _subSkills;
  final String _mainSkill;

  @override
  State<SkillTile> createState() => _SkillTileState();
}

class _SkillTileState extends State<SkillTile> {
  bool isExpanded = false;

  late ThemeData _theme;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _theme = Theme.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 240,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: ExpansionPanelList(
            elevation: 0,
            animationDuration: const Duration(seconds: 1),
            expandIconColor: Colors.red,
            expansionCallback: (_, isOpen) {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            children: [
              _buildExpansionTile(
                isExpanded,
                _theme,
                widget._mainSkill,
                widget._subSkills,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

ExpansionPanel _buildExpansionTile(
  bool isExpanded,
  ThemeData theme,
  String mainSkill,
  List<String> subSkills,
) {
  return ExpansionPanel(
    canTapOnHeader: true,
    isExpanded: isExpanded,
    backgroundColor: Colors.white.withOpacity(0.2),
    headerBuilder: (_, isOpen) {
      return Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 6,
          horizontal: 16,
        ),
        child: Text(
          mainSkill,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.primary,
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
            subSkills.length,
            (index) => Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Text(
                subSkills[index],
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
  );
}
