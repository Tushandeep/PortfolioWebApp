import 'dart:math';

import 'package:flutter/material.dart';

import '../../../constants/constants.dart';

int i = 0;

class ExperiencePage extends StatefulWidget {
  const ExperiencePage({super.key});

  @override
  State<ExperiencePage> createState() => _ExperiencePageState();
}

class _ExperiencePageState extends State<ExperiencePage> {
  late Size _size;
  late ThemeData _theme;

  final List<Widget> experiences = <Widget>[
    ExperienceTile(
      designation: "Hybrid App Developer",
      locationWithCountry: "Mumbai, India",
      timeRangeInYear: "May, 2022 - July, 2023",
      tags: const ["Internship"],
      description:
          "\nI worked as Hybrid Application Developer at RASIENT TECHNOHUB PRIVATE LIMITED, Mumbai and have worked on the below product for the company.\n\nProduct Name: mTopper\n\n• It is an edtech application for students learning\n\n• Pure HTTP Request and APIs based Application\n\n• Basically worked on the Responsive UI/Screens Part for the app",
      index: i++,
    ),
    ExperienceTile(
      designation: "Flutter Developer",
      locationWithCountry: "Punjab, India",
      timeRangeInYear: "2021 - ${DateTime.now().year}",
      tags: const ["Self-Intern", "Full-Time"],
      description: "",
      index: i++,
    ),
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _theme = Theme.of(context);
    _size = MediaQuery.of(context).size;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: max(kMinHeight, _size.height - kAppHeight),
      width: double.maxFinite,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                "Experience",
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: _theme.colorScheme.primary,
                ),
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Wrap(children: experiences),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ExperienceTile extends StatefulWidget {
  const ExperienceTile({
    super.key,
    required String designation,
    required String locationWithCountry,
    required String timeRangeInYear,
    required List<String> tags,
    required String description,
    int? index,
  })  : _designation = designation,
        _locationWithCountry = locationWithCountry,
        _timeRangeInYear = timeRangeInYear,
        _tags = tags,
        _description = description;

  final String _designation;
  final String _locationWithCountry;
  final String _timeRangeInYear;
  final List<String> _tags;
  final String _description;

  @override
  State<ExperienceTile> createState() => _ExperienceTileState();
}

class _ExperienceTileState extends State<ExperienceTile> {
  late ThemeData _theme;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _theme = Theme.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 10,
      ),
      child: GestureDetector(
        onTap: viewExperienceTile,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Container(
            width: 300,
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: _theme.colorScheme.primary,
                width: 3,
              ),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                FittedBox(
                  fit: BoxFit.cover,
                  child: Text(
                    widget._designation,
                    style: const TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  widget._locationWithCountry,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white70,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    widget._timeRangeInYear,
                    style: const TextStyle(
                      fontSize: 26,
                      color: Colors.white60,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
                Wrap(
                  children: List.generate(
                    widget._tags.length,
                    (index) => Container(
                      decoration: BoxDecoration(
                        color: _theme.colorScheme.primary,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 2,
                        horizontal: 6,
                      ),
                      margin: const EdgeInsets.only(right: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            height: 4,
                            width: 4,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            widget._tags[index],
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /*
  
  width: (constraints.maxWidth < kMobileWidth) ? null : 400,
  
  */

  Future<dynamic> viewExperienceTile() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        scrollable: true,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: BorderSide(
            color: _theme.colorScheme.primary,
            width: 2,
          ),
        ),
        backgroundColor: _theme.scaffoldBackgroundColor,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            FittedBox(
              fit: BoxFit.cover,
              child: Text(
                widget._designation,
                style: const TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              widget._locationWithCountry,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white70,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                widget._timeRangeInYear,
                style: const TextStyle(
                  fontSize: 26,
                  color: Colors.white60,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ],
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Wrap(
              children: List.generate(
                widget._tags.length,
                (index) => Container(
                  decoration: BoxDecoration(
                    color: _theme.colorScheme.primary,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 2,
                    horizontal: 6,
                  ),
                  margin: const EdgeInsets.only(right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 4,
                        width: 4,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        widget._tags[index],
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (widget._description.isNotEmpty)
              Container(
                width: 400,
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  widget._description,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ),
            const SizedBox(height: 20),
          ],
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 14,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: _theme.colorScheme.primary,
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.close, color: Colors.white),
                    SizedBox(width: 4),
                    Text(
                      "Close",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
