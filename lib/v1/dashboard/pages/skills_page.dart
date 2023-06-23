import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/dashboard_controller.dart';
import '../../../constants/constants.dart';

class SkillsPage extends StatefulWidget {
  const SkillsPage({super.key});

  @override
  State<SkillsPage> createState() => _SkillsPageState();
}

class _SkillsPageState extends State<SkillsPage> {
  late Size _size;
  late ThemeData _theme;
  late DashBoardController _controller;

  List<Widget> _childrens(BoxConstraints constraints) => <Widget>[
        SkillTile(
          index: 0,
          mainSkill: "General Skills",
          constraints: constraints,
          subSkills: const [
            "Deep OOPS",
            "Debugging",
            "Clean Code",
            "Problem Solving",
          ],
        ),
        SkillTile(
          index: 1,
          mainSkill: "Flutter",
          constraints: constraints,
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
        SkillTile(
          index: 2,
          mainSkill: "Tools",
          constraints: constraints,
          subSkills: const [
            "Git",
            "Github",
            "Postman",
            "VS Code",
            "Android Studio",
          ],
        ),
        SkillTile(
          index: 3,
          mainSkill: "Databases",
          constraints: constraints,
          subSkills: const [
            "Realtime Database",
            "Sqlite",
            "Shared Preferences",
          ],
        ),
        SkillTile(
          index: 4,
          mainSkill: "Other",
          constraints: constraints,
          subSkills: const [
            "JSON",
            "API",
            "Problem Solving",
          ],
        ),
      ];
  @override
  void initState() {
    super.initState();

    _controller = Get.find<DashBoardController>();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _size = MediaQuery.of(context).size;
    _theme = Theme.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 841) {
          _controller.skillsContainerExpand(List.generate(5, (index) => true));
        } else {
          _controller.skillsContainerExpand(List.generate(5, (index) => false));
        }
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
                        children: _childrens(constraints),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
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
    required int index,
    required String mainSkill,
    required List<String> subSkills,
    required BoxConstraints constraints,
  })  : _index = index,
        _mainSkill = mainSkill,
        _subSkills = subSkills,
        _constraints = constraints;

  final int _index;
  final List<String> _subSkills;
  final String _mainSkill;
  final BoxConstraints _constraints;

  @override
  State<SkillTile> createState() => _SkillTileState();
}

class _SkillTileState extends State<SkillTile> {
  late ThemeData _theme;
  late DashBoardController _controller;

  @override
  void initState() {
    super.initState();

    _controller = Get.find<DashBoardController>();
  }

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
        child: Obx(
          () => ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: AbsorbPointer(
              absorbing: (widget._constraints.maxWidth > 841),
              child: ExpansionPanelList(
                elevation: 0,
                animationDuration: const Duration(seconds: 1),
                expandIconColor: Colors.red,
                expansionCallback: (widget._constraints.maxWidth <= 841)
                    ? (_, isOpen) {
                        if (isOpen) {
                          _controller.skillsContainerExpand[widget._index] =
                              false;
                        } else {
                          _controller
                              .skillsContainerExpand(List.filled(5, false));
                          _controller.skillsContainerExpand[widget._index] =
                              true;
                        }
                      }
                    : null,
                children: [
                  _buildExpansionTile(
                    _controller.skillsContainerExpand[widget._index],
                    _theme,
                    widget._mainSkill,
                    widget._subSkills,
                  ),
                ],
              ),
            ),
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
