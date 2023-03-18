import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

import '../../../controllers/dashboard_controller.dart';
import '../../../constants/constants.dart';

Duration _duration = const Duration(milliseconds: 700);

class SkillsPage extends StatefulWidget {
  const SkillsPage({super.key});

  @override
  State<SkillsPage> createState() => _SkillsPageState();
}

class _SkillsPageState extends State<SkillsPage> with TickerProviderStateMixin {
  late Size _size;
  late ThemeData _theme;

  late DashBoardController _dashBoardController;

  late AnimationController _animationController;
  late Animation<double> _opacityAnimation, _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _dashBoardController = Get.find<DashBoardController>();

    _animationController = AnimationController(
      vsync: this,
      duration: _duration,
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

    _scaleAnimation = Tween<double>(
      begin: 10,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.ease,
      ),
    );
    final double maxHeight = _dashBoardController.maxScreenHeight.value * 2;
    bool flag = true;

    _dashBoardController.currPosOffset.listen(
      (val) {
        if (val >= (maxHeight - 200) &&
            !_animationController.isAnimating &&
            flag) {
          _animationController.forward();
          flag = false;
        }
      },
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _size = MediaQuery.of(context).size;
    _theme = Theme.of(context);
  }

  @override
  void dispose() {
    super.dispose();

    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: _size.height - kAppHeight,
          width: double.maxFinite,
          margin: const EdgeInsets.symmetric(horizontal: 10),
        ),
        SkillsLabelWidget(
          animationController: _animationController,
          scaleAnimation: _scaleAnimation,
          opacityAnimation: _opacityAnimation,
          theme: _theme,
        ),
        const SkillTile(
          mainSkill: "General Skills",
          offset: Offset(0, -220),
          subSkills: [
            "Deep OOPS",
            "Debugging",
            "Clean Code",
            "Problem Solving",
          ],
        ),
        const SkillTile(
          mainSkill: "Flutter",
          offset: Offset(300, -120),
          duration: 800,
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
          offset: Offset(-300, -120),
          duration: 1100,
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
          offset: Offset(-240, 140),
          duration: 1400,
          subSkills: [
            "Realtime Database",
            "Sqflite",
            "Shared Preferences",
          ],
        ),
        const SkillTile(
          offset: Offset(240, 140),
          mainSkill: "Other",
          duration: 1700,
          subSkills: [
            "JSON",
            "API",
            "Problem Solving",
          ],
        ),
      ],
    );
  }
}

class SkillsLabelWidget extends StatelessWidget {
  const SkillsLabelWidget({
    super.key,
    required AnimationController animationController,
    required Animation<double> scaleAnimation,
    required Animation<double> opacityAnimation,
    required ThemeData theme,
  })  : _animationController = animationController,
        _scaleAnimation = scaleAnimation,
        _opacityAnimation = opacityAnimation,
        _theme = theme;

  final AnimationController _animationController;
  final Animation<double> _scaleAnimation;
  final Animation<double> _opacityAnimation;
  final ThemeData _theme;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, _) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: AnimatedOpacity(
            opacity: _opacityAnimation.value,
            duration: _duration,
            child: Container(
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
          ),
        );
      },
    );
  }
}

class SkillTile extends StatefulWidget {
  const SkillTile({
    super.key,
    required String mainSkill,
    required List<String> subSkills,
    required Offset offset,
    int duration = 500,
  })  : _mainSkill = mainSkill,
        _subSkills = subSkills,
        _offset = offset,
        _duration = duration;

  final List<String> _subSkills;
  final String _mainSkill;
  final Offset _offset;
  final int _duration;

  @override
  State<SkillTile> createState() => _SkillTileState();
}

class _SkillTileState extends State<SkillTile>
    with SingleTickerProviderStateMixin {
  bool isExpanded = false;

  late ThemeData _theme;
  late AnimationController _animationController;
  late DashBoardController _dashBoardController;

  @override
  void initState() {
    super.initState();

    _dashBoardController = Get.find<DashBoardController>();

    _animationController = AnimationController(vsync: this);

    final double maxHeight = _dashBoardController.maxScreenHeight.value * 2;

    _dashBoardController.currPosOffset.listen(
      (val) {
        if (val >= maxHeight && !_animationController.isAnimating) {
          _animationController.forward();
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
    return Transform.translate(
      offset: widget._offset,
      child: SizedBox(
        width: 240,
        child: DecoratedBox(
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
              elevation: 0,
              expandIconColor: _theme.colorScheme.primary,
              animationDuration: _duration,
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
        )
            .animate(
              controller: _animationController,
              autoPlay: false,
            )
            .fadeIn(
              duration: Duration(milliseconds: widget._duration),
              curve: Curves.easeInOutCubic,
              delay: const Duration(milliseconds: 300),
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
    backgroundColor: Colors.white24,
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
