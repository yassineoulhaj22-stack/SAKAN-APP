import 'package:flutter/material.dart';

const kPrimary = Color(0xFF6C54FF);
const kBg = Color(0xFFFAF8F5);
const kInk = Color(0xFF14122B);
const kMuted = Color(0xFF6B6880);
const kSoft = Color(0xFFEEEAFF);
const kGreen = Color(0xFF16A06B);
const kLine = Color(0xFFE9E6F2);

ThemeData buildTheme() => ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: kPrimary, primary: kPrimary),
      scaffoldBackgroundColor: kBg,
      appBarTheme: const AppBarTheme(
          backgroundColor: kBg, elevation: 0, foregroundColor: kInk, scrolledUnderElevation: 0),
      textTheme: Typography.blackMountainView.apply(bodyColor: kInk, displayColor: kInk),
    );
