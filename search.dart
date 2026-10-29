import 'package:flutter/material.dart';
import 'theme.dart';
import 'data.dart';
import 'widgets.dart';
import 'details.dart';
import 'favs.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool map = false;
  int sort = 0;
  @override
  Widget build(BuildContext context) {
    final res = [listings[3], listings[4], listings[5], listings[6]];
    if (sort == 0) res.sort((a, b) => a.price.compareTo(b.price));
    return Column(children: [
      Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
          child: Column(children: [
            const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Logo(), Icon(Icons.notifications_none, size: 28)]),
            const SizedBox(height: 12),
            InkWell(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const FiltersPage())),
                child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: boxDeco(),
                    child: const Row(children: [
                      Icon(Icons.search, color: kPrimary),
                      SizedBox(width: 10),
                      Expanded(child: Text('Rabat, Al irfan', style: TextStyle(fontWeight: FontWeight.w600))),
                      Pill('(3) filtres', icon: Icons.tune),
                    ]))),
            const SizedBox(height: 12),
            Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(color: const Color(0xFFF0EDF5), borderRadius: BorderRadius.circular(14)),
                child: Row(children: [
                  for (final e in [[false, 'Liste', Icons.view_list], [true, 'Carte', Icons.map_outlined]])
                    Expanded(
                        child: InkWell(
                            onTap: () => setState(() => map = e[0] as bool),
                            child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 9),
                                decoration: BoxDecoration(
                                    color: map == e[0] ? Colors.white : Colors.transparent, borderRadius: BorderRadius.circular(10)),
                                child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                  Icon(e[2] as IconData, size: 18, color: map == e[0] ? kPrimary : kMuted),
                                  const SizedBox(width: 6),
                                  Text(e[1] as String, style: TextStyle(fontWeight: FontWeight.w700, color: map == e[0] ? kPrimary : kMuted)),
                                ])))),
                ])),
          ])),
      Expanded(
          child: map
              ? const MapView()
              : ListView(padding: const EdgeInsets.all(16), children: [
                  Row(children: [
                    const Text('48 logements disponibles ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
                    const Icon(Icons.circle, size: 9, color: kGreen),
                  ]),
                  const SizedBox(height: 8),
                  SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(children: [
                        const Text('Trier par : ', style: TextStyle(color: kMuted, fontSize: 13)),
                        for (final e in const ['Prix croissant', 'Plus récents', 'Proximité'].asMap().entries)
                          Padding(
                              padding: const EdgeInsets.only(right: 6),
                              child: ChoiceChip(
                                  label: Text(e.value, style: TextStyle(fontSize: 12, color: sort == e.key ? kPrimary : kMuted)),
                                  selected: sort == e.key,
                                  selectedColor: kSoft,
                                  showCheckmark: false,
                                  onSelected: (_) => setState(() => sort = e.key))),
                      ])),
                  const SizedBox(height: 12),
                  for (final l in res) ListingCard(l, compare: true),
                  const TipCard('Astuce de Sakan', 'Besoin d\'aide pour choisir ? Utilisez le bouton Comparer pour évaluer 2 logements côte à côte.'),
                ])),
      AnimatedBuilder(
          animation: AppState.i,
          builder: (c, _) => AppState.i.compare.isEmpty
              ? const SizedBox()
              : GestureDetector(
                  onTap: () => Navigator.push(c, MaterialPageRoute(builder: (_) => const ComparePage())),
                  child: Container(
                      margin: const EdgeInsets.fromLTRB(16, 4, 16, 8),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(color: kInk, borderRadius: BorderRadius.circular(16)),
                      child: Row(children: [
                        CircleAvatar(radius: 12, backgroundColor: kPrimary, child: Text('${AppState.i.compare.length}', style: const TextStyle(color: Colors.white, fontSize: 12))),
                        const SizedBox(width: 10),
                        Text('Comparer (${AppState.i.compare.length} logements)', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                        const Spacer(),
                        const Text('Ouvrir l\'analyse', style: TextStyle(color: Color(0xFFCFC6FF), fontSize: 12)),
                      ])))),
    ]);
  }
}

class MapView extends StatelessWidget {
  const MapView({super.key});
  Widget pill(String t, double x, double y, {bool star = false}) => Align(
      alignment: Alignment(x, y),
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
              color: star ? kPrimary : Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)]),
          child: Text(star ? '★ $t' : t, style: TextStyle(fontWeight: FontWeight.w800, color: star ? Colors.white : kInk))));
  @override
  Widget build(BuildContext context) {
    final l = listings[6];
    return Stack(children: [
      Positioned.fill(child: CustomPaint(painter: _MapPainter())),
      Align(
          alignment: const Alignment(-0.95, -0.75),
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(color: kSoft, borderRadius: BorderRadius.circular(20)),
              child: const Text('🎓 Faculté de Science de Rabat', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600)))),
      pill('3 800 DH', 0.3, -0.35),
      pill('5 200 DH', -0.5, -0.05),
      pill('4 200 DH', 0.45, 0.4),
      pill('2 500 DH', -0.1, 0.15, star: true),
      Positioned(
          right: 12,
          top: 12,
          child: Column(children: [
            for (final i in const [Icons.my_location, Icons.school, Icons.add, Icons.remove])
              Container(margin: const EdgeInsets.only(bottom: 6), padding: const EdgeInsets.all(10), decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle), child: Icon(i, color: kPrimary, size: 20)),
          ])),
      Positioned(
          left: 12,
          right: 12,
          bottom: 12,
          child: InkWell(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => DetailsPage(l))),
              child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: boxDeco(),
                  child: Row(children: [
                    SizedBox(width: 90, child: Photo(l.color, h: 90)),
                    const SizedBox(width: 12),
                    Expanded(
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      const Wrap(spacing: 4, children: [Pill('Vérifié Sakan', icon: Icons.verified), Pill('5 min Tram', bg: Color(0xFFF2F0F7), fg: kMuted)]),
                      const SizedBox(height: 4),
                      const Text('Studio Moderne al irfan', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
                      const Text('Av. Allal Al Fassi, Rabat 11000', style: TextStyle(fontSize: 11, color: kMuted)),
                      const SizedBox(height: 4),
                      const Text('2 500 DH / mois', style: TextStyle(color: kPrimary, fontWeight: FontWeight.w800, fontSize: 18)),
                    ])),
                  ])))),
    ]);
  }
}

class _MapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size s) {
    canvas.drawRect(Offset.zero & s, Paint()..color = const Color(0xFFF1EEE9));
    final road = Paint()..color = Colors.white..strokeWidth = 14;
    for (final f in [0.2, 0.55, 0.85]) {
      canvas.drawLine(Offset(0, s.height * f), Offset(s.width, s.height * f - 20), road);
    }
    for (final f in [0.15, 0.5, 0.8]) {
      canvas.drawLine(Offset(s.width * f, 0), Offset(s.width * f + 20, s.height), road);
    }
    canvas.drawCircle(Offset(s.width * .7, s.height * .3), 50, Paint()..color = const Color(0xFFE3F0E5));
    final path = Path()
      ..moveTo(s.width * .85, s.height * .05)
      ..quadraticBezierTo(s.width * .45, s.height * .4, s.width * .1, s.height * .9);
    final p = Paint()..color = kPrimary..style = PaintingStyle.stroke..strokeWidth = 3;
    for (final m in path.computeMetrics()) {
      double d = 0;
      while (d < m.length) {
        canvas.drawPath(m.extractPath(d, d + 10), p);
        d += 18;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}

class FiltersPage extends StatefulWidget {
  const FiltersPage({super.key});
  @override
  State<FiltersPage> createState() => _FiltersPageState();
}

class _FiltersPageState extends State<FiltersPage> {
  String city = 'Rabat';
  double walk = 10;
  RangeValues budget = const RangeValues(1000, 2500);
  final types = <String>{'Studio', 'F2 (1 Chambre)', 'Colocation'};
  final crit = <String, bool>{'Meublé & Équipé': true, 'Sans frais d\'agence': true, 'Disponibilité immédiate': false, 'Vérifié par Sakan': true};
  static const sub = {
    'Meublé & Équipé': 'Lit, bureau, électroménager inclus',
    'Sans frais d\'agence': 'Direct propriétaire certifié',
    'Disponibilité immédiate': 'Emménagement ce mois-ci',
    'Vérifié par Sakan': 'Visité & validé par nos équipes terrain',
  };

  Widget box(String t, IconData i, Widget child) => Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: boxDeco(),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [Icon(i, color: kPrimary), const SizedBox(width: 8), Text(t, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800))]),
        const SizedBox(height: 12),
        child,
      ]));

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
            leading: IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context)),
            title: const Text('Filtres de recherche', style: TextStyle(fontWeight: FontWeight.w800)),
            actions: [
              TextButton(
                  onPressed: () => setState(() {
                        walk = 10;
                        budget = const RangeValues(1000, 2500);
                        types..clear()..add('Studio');
                      }),
                  child: const Text('Réinitialiser'))
            ]),
        bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(16),
            child: SafeArea(child: Btn('Afficher les 48 logements', () => Navigator.pop(context), icon: Icons.tune))),
        body: ListView(padding: const EdgeInsets.all(16), children: [
          box('Localisation & Trajet', Icons.explore_outlined, Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Wrap(spacing: 8, children: [
              for (final c in const ['Rabat', 'Casablanca', 'Tanger', 'Marrakech'])
                ChoiceChip(label: Text(c), selected: city == c, selectedColor: kPrimary, showCheckmark: false, labelStyle: TextStyle(color: city == c ? Colors.white : kInk), onSelected: (_) => setState(() => city = c)),
            ]),
            const SizedBox(height: 12),
            Container(padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: const Color(0xFFF5F3F8), borderRadius: BorderRadius.circular(12)), child: const Row(children: [Icon(Icons.school_outlined, color: kMuted), SizedBox(width: 10), Text('Faculté de Médecine et pharmacie')])),
            const SizedBox(height: 8),
            Row(children: [const Icon(Icons.directions_walk, size: 18, color: kMuted), const Text(' Distance maximale à pied'), const Spacer(), Text('${walk.round()} min max', style: const TextStyle(color: kPrimary, fontWeight: FontWeight.w700))]),
            Slider(value: walk, min: 5, max: 30, activeColor: kPrimary, onChanged: (v) => setState(() => walk = v)),
          ])),
          box('Budget mensuel (DH)', Icons.payments_outlined, Column(children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text('${budget.start.round()} DH', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
              const Pill('Toutes charges comprises'),
              Text('${budget.end.round()} DH', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
            ]),
            RangeSlider(values: budget, min: 1000, max: 15000, activeColor: kPrimary, onChanged: (v) => setState(() => budget = v)),
          ])),
          box('Type de logement', Icons.apartment, Wrap(spacing: 8, runSpacing: 8, children: [
            for (final t in const ['Studio', 'F2 (1 Chambre)', 'F3 (2 Chambres)', 'Colocation', 'Chambre étudiante'])
              FilterChip(
                  label: Text(t),
                  selected: types.contains(t),
                  selectedColor: kPrimary,
                  checkmarkColor: Colors.white,
                  labelStyle: TextStyle(color: types.contains(t) ? Colors.white : kInk),
                  onSelected: (v) => setState(() => v ? types.add(t) : types.remove(t))),
          ])),
          box('Critères essentiels', Icons.tune, Column(children: [
            for (final k in crit.keys)
              SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(k, style: const TextStyle(fontWeight: FontWeight.w700)),
                  subtitle: Text(sub[k]!, style: const TextStyle(fontSize: 12)),
                  value: crit[k]!,
                  activeTrackColor: kPrimary,
                  activeColor: Colors.white,
                  onChanged: (v) => setState(() => crit[k] = v)),
          ])),
          const TipCard('ASTUCE SAKAN', 'Active l\'alerte pour être notifié des nouveaux logements dès leur parution avant tout le monde !'),
        ]),
      );
}
