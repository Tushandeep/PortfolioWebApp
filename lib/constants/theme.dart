import 'package:flutter/material.dart';

ThemeData get theme => ThemeData(
      colorScheme: _colorScheme,
      useMaterial3: true,
      scaffoldBackgroundColor: _colorScheme.surface,
      fontFamily: "TiltNeon",
    );

ColorScheme get _colorScheme => ColorScheme.fromSeed(
      seedColor: Colors.deepPurple,
      primary: const Color(0xFFC69749),
      surface: const Color(0xFF282A3A),
    );
