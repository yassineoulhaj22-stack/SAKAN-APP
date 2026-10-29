import 'package:flutter/material.dart';
import 'theme.dart';
import 'onboarding.dart';

void main() => runApp(const SakanApp());

class SakanApp extends StatelessWidget {
  const SakanApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Sakan',
        debugShowCheckedModeBanner: false,
        theme: buildTheme(),
        home: const Onboarding(),
      );
}
