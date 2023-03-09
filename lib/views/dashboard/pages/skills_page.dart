import 'package:flutter/material.dart';

import '../../../constants/constants.dart';

class SkillsPage extends StatefulWidget {
  const SkillsPage({super.key});

  @override
  State<SkillsPage> createState() => _SkillsPageState();
}

class _SkillsPageState extends State<SkillsPage> {
  late Size _size;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _size = MediaQuery.of(context).size;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _size.height - kAppHeight,
      child: const Column(
        children: <Widget>[
          Text("Skills"),
        ],
      ),
    );
  }
}
