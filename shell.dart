import 'package:flutter/material.dart';
import 'theme.dart';
import 'data.dart';
import 'widgets.dart';
import 'search.dart';
import 'favs.dart';
import 'profile.dart';

class Shell extends StatefulWidget {
  const Shell({super.key});
  @override
  State<Shell> createState() => _ShellState();
}

class _ShellState extends State<Shell> {
  int i = 0;
  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
            child: IndexedStack(index: i, children: [
          HomePage(onTab: (v) => setState(() => i = v)),
          const SearchPage(),
          const FavsPage(),
          const ProfilePage(),
        ])),
        bottomNavigationBar: NavigationBar(
            selectedIndex: i,
            onDestinationSelected: (v) => setState(() => i = v),
            backgroundColor: Colors.white,
            indicatorColor: kSoft,
            destinations: const [
              NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home, color: kPrimary), label: 'Accueil'),
              NavigationDestination(icon: Icon(Icons.search), selectedIcon: Icon(Icons.search, color: kPrimary), label: 'Recherche'),
              NavigationDestination(icon: Icon(Icons.favorite_border), selectedIcon: Icon(Icons.favorite, color: kPrimary), label: 'Favoris'),
              NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person, color: kPrimary), label: 'Profil'),
            ]),
      );
}

class HomePage extends StatefulWidget {
  final void Function(int) onTab;
  const HomePage({super.key, required this.onTab});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String sel = 'Studio';
  @override
  Widget build(BuildContext context) {
    return ListView(padding: const EdgeInsets.all(16), children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        const Logo(),
        Stack(children: [
          const Icon(Icons.notifications_none, size: 28),
          Positioned(right: 2, top: 2, child: Container(width: 9, height: 9, decoration: const BoxDecoration(color: kPrimary, shape: BoxShape.circle))),
        ]),
      ]),
      const SizedBox(height: 14),
      Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(22), gradient: const LinearGradient(colors: [kSoft, Color(0xFFF6F3FF)])),
          child: Row(children: [
            Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Pill('100% vérifié', bg: Colors.white, icon: Icons.verified),
              const SizedBox(height: 10),
              const Text('Trouve ton logement idéal en toute sérénité', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, height: 1.2)),
              const SizedBox(height: 6),
              const Text('Zéro caution floue, trajets étudiants calculés.', style: TextStyle(fontSize: 12, color: kMuted)),
            ])),
            const Mascot(size: 110),
          ])),
      const SizedBox(height: 14),
      InkWell(
          onTap: () => widget.onTab(1),
          child: Container(
              padding: const EdgeInsets.all(14),
              decoration: boxDeco(),
              child: const Row(children: [
                Icon(Icons.search, color: kMuted),
                SizedBox(width: 10),
                Expanded(child: Text('Ville, quartier, école ou tramway...', style: TextStyle(color: kMuted))),
                Icon(Icons.tune, color: kPrimary),
              ]))),
      const SizedBox(height: 12),
      SizedBox(
          height: 40,
          child: ListView(scrollDirection: Axis.horizontal, children: [
            for (final c in const ['Studio', 'Colocation', 'Appartement meublé'])
              Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                      label: Text(c),
                      selected: sel == c,
                      onSelected: (_) => setState(() => sel = c),
                      selectedColor: kPrimary,
                      labelStyle: TextStyle(color: sel == c ? Colors.white : kInk, fontWeight: FontWeight.w600),
                      showCheckmark: false,
                      backgroundColor: Colors.white)),
          ])),
      SectionTitle('Recommandés pour toi', action: 'Voir tout', onAction: () => widget.onTab(1)),
      const Text('Vérifiés sur place par les ambassadeurs Sakan', style: TextStyle(color: kMuted, fontSize: 13)),
      const SizedBox(height: 12),
      ListingCard(listings[0]),
      ListingCard(listings[1]),
      const SectionTitle('Villes populaires'),
      GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 2.2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          children: [
            for (final c in const [
              ['Casablanca', '840+ annonces', Icons.apartment],
              ['Rabat', '520+ annonces', Icons.account_balance],
              ['Marrakech', '390+ annonces', Icons.wb_sunny_outlined],
              ['Tanger', '270+ annonces', Icons.sailing],
            ])
              InkWell(
                  onTap: () => widget.onTab(1),
                  child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: boxDeco(),
                      child: Row(children: [
                        Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(color: kSoft, borderRadius: BorderRadius.circular(12)),
                            child: Icon(c[2] as IconData, color: kPrimary)),
                        const SizedBox(width: 8),
                        Expanded(
                            child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text(c[0] as String, style: const TextStyle(fontWeight: FontWeight.w800)),
                          Text(c[1] as String, style: const TextStyle(fontSize: 11, color: kMuted)),
                        ])),
                      ]))),
          ]),
      const TipCard('Garantie Transparence Sakan', 'Contrats types, aucune commission cachée et visite vérifiée.'),
    ]);
  }
}
