import 'package:flutter/material.dart';
import 'theme.dart';
import 'widgets.dart';
import 'shell.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});
  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final ctrl = PageController();
  int page = 0;

  static const pages = [
    ['Trouve ton logement idéal', 'Des centaines de studios et colocations vérifiés sur le terrain à Casablanca, Rabat et partout au Maroc.'],
    ['Calcule tes trajets réels', 'Estime en direct le temps de trajet en tramway, bus et à pied jusqu\'à ton université ou lieu de travail.'],
    ['Loue en toute sécurité', 'Zéro arnaque et zéro avance de frais. Visite des logements certifiés avec un dossier 100% protégé.'],
  ];
  static const items = [Icons.search, Icons.arrow_forward, Icons.verified_user];

  void _go() => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const Shell()));

  @override
  Widget build(BuildContext context) {
    final last = page == 2;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(children: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                page > 0
                    ? IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () => ctrl.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeOut))
                    : const SizedBox(width: 48),
                if (page > 0) Text('Étape ${page + 1} sur 3', style: const TextStyle(color: kMuted)),
                TextButton(onPressed: _go, child: const Text('Passer', style: TextStyle(color: kMuted))),
              ])),
          Expanded(
              child: PageView.builder(
                  controller: ctrl,
                  itemCount: 3,
                  onPageChanged: (v) => setState(() => page = v),
                  itemBuilder: (_, i) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                        Mascot(size: 240, item: items[i], itemColor: i == 2 ? kGreen : kPrimary),
                        const SizedBox(height: 40),
                        Text(pages[i][0], textAlign: TextAlign.center, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w800)),
                        const SizedBox(height: 12),
                        Text(pages[i][1], textAlign: TextAlign.center, style: const TextStyle(fontSize: 15, color: kMuted, height: 1.4)),
                        if (i == 0) ...[
                          const SizedBox(height: 16),
                          const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                            Pill('Prix en DH nets', icon: Icons.check_circle_outline),
                            SizedBox(width: 8),
                            Pill('Zéro arnaque', icon: Icons.shield_outlined),
                          ]),
                        ],
                      ])))),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            for (var i = 0; i < 3; i++)
              AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.all(3),
                  width: i == page ? 28 : 8,
                  height: 8,
                  decoration: BoxDecoration(color: i == page ? kPrimary : kLine, borderRadius: BorderRadius.circular(8))),
          ]),
          Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 8),
              child: Btn(last ? 'Commencer l\'expérience' : 'Suivant',
                  last ? _go : () => ctrl.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeOut),
                  icon: Icons.arrow_forward, trailing: true)),
          Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: GestureDetector(
                  onTap: _go,
                  child: const Text.rich(TextSpan(text: 'Déjà un compte ? ', style: TextStyle(fontSize: 12, color: kMuted), children: [
                    TextSpan(text: 'Se connecter', style: TextStyle(color: kPrimary, fontWeight: FontWeight.w700)),
                  ])))),
        ]),
      ),
    );
  }
}
