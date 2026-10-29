import 'package:flutter/material.dart';
import 'theme.dart';
import 'data.dart';
import 'widgets.dart';
import 'details.dart';

class FavsPage extends StatefulWidget {
  const FavsPage({super.key});
  @override
  State<FavsPage> createState() => _FavsPageState();
}

class _FavsPageState extends State<FavsPage> {
  bool tab2 = false;
  @override
  Widget build(BuildContext context) {
    final st = AppState.i;
    return AnimatedBuilder(
        animation: st,
        builder: (c, _) {
          final favs = listings.where((l) => st.favs.contains(l.id)).toList();
          final cmp = listings.where((l) => st.compare.contains(l.id)).toList();
          final shown = tab2 ? cmp : favs;
          return ListView(padding: const EdgeInsets.all(16), children: [
            const Text('ESPACE RECHERCHE', style: TextStyle(fontSize: 11, color: kMuted)),
            Row(children: [
              Expanded(child: Text('Favoris (${favs.length} logements)', style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w800))),
              Btn('Comparer', () => Navigator.push(c, MaterialPageRoute(builder: (_) => const ComparePage())), small: true, icon: Icons.compare_arrows),
            ]),
            const SizedBox(height: 12),
            Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(color: const Color(0xFFF0EDF5), borderRadius: BorderRadius.circular(14)),
                child: Row(children: [
                  for (final e in [[false, 'Tous mes favoris (${favs.length})'], [true, 'Comparateur actif ${cmp.length}']])
                    Expanded(child: InkWell(
                        onTap: () => setState(() => tab2 = e[0] as bool),
                        child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(color: tab2 == e[0] ? Colors.white : Colors.transparent, borderRadius: BorderRadius.circular(10)),
                            child: Center(child: Text(e[1] as String, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: tab2 == e[0] ? kPrimary : kMuted)))))),
                ])),
            const TipCard('Conseil Sakan', 'Compare jusqu\'à 4 annonces pour trouver le meilleur compromis loyer/trajet sans mauvaise surprise !'),
            if (shown.isEmpty) const Padding(padding: EdgeInsets.all(32), child: Center(child: Text('Rien ici pour le moment.', style: TextStyle(color: kMuted)))),
            for (final l in shown)
              Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: boxDeco(),
                  child: Column(children: [
                    Stack(children: [
                      Padding(padding: const EdgeInsets.all(8), child: Photo(l.color, h: 170)),
                      Positioned(left: 18, top: 18, child: Wrap(spacing: 6, children: [
                        if (l.verified) const Pill('Vérifié Sakan', icon: Icons.verified),
                        if (l.immediate) const Pill('Disponible immédiatement', bg: Color(0xFFDFF7EA), fg: kGreen),
                      ])),
                      Positioned(right: 18, top: 18, child: InkWell(onTap: () => st.toggleFav(l.id), child: const CircleAvatar(radius: 18, backgroundColor: Colors.white, child: Icon(Icons.favorite, color: kPrimary, size: 20)))),
                    ]),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(16, 4, 16, 14),
                        child: Column(children: [
                          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              Text(l.title, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800)),
                              Text('${l.loc} • ${l.surface} m²', style: const TextStyle(fontSize: 12, color: kMuted)),
                            ])),
                            Text('${l.price} DH', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: kPrimary)),
                          ]),
                          const SizedBox(height: 10),
                          Container(width: double.infinity, padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: const Color(0xFFF5F3F8), borderRadius: BorderRadius.circular(12)), child: Text('🚋 ${l.transport}', style: const TextStyle(fontSize: 12, color: kMuted))),
                          const Divider(height: 22, color: kLine),
                          Row(children: [
                            InkWell(onTap: () => st.toggleCompare(l.id), child: Row(children: [Icon(st.compare.contains(l.id) ? Icons.check_box : Icons.check_box_outline_blank, color: kPrimary), const SizedBox(width: 6), const Text('Comparer', style: TextStyle(fontWeight: FontWeight.w600))])),
                            const Spacer(),
                            Btn('Réserver visite', () => Navigator.push(c, MaterialPageRoute(builder: (_) => ContactPage(l))), small: true),
                          ]),
                        ])),
                  ])),
            Container(
                padding: const EdgeInsets.all(16),
                decoration: boxDeco(),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(children: [const Icon(Icons.table_chart_outlined, color: kPrimary), const SizedBox(width: 8), const Expanded(child: Text('Tableau comparatif rapide', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800))), Pill('${cmp.length} sélectionnés')]),
                  const SizedBox(height: 10),
                  _CmpTable(cmp.take(2).toList()),
                  const SizedBox(height: 12),
                  Btn('Ouvrir le comparateur complet (côte à côte)', () => Navigator.push(c, MaterialPageRoute(builder: (_) => const ComparePage())), icon: Icons.arrow_forward, trailing: true),
                ])),
          ]);
        });
  }
}

class _CmpTable extends StatelessWidget {
  final List<Listing> ls;
  const _CmpTable(this.ls);
  @override
  Widget build(BuildContext context) {
    final rows = <List<String>>[
      ['Loyer mensuel', ...ls.map((l) => '${l.price} DH')],
      ['Transports', ...ls.map((l) => l.transport)],
      ['Surface nette', ...ls.map((l) => '${l.surface} m²')],
      ['Charges incluses', ...ls.map((l) => l.tags.isNotEmpty ? l.tags.first : '-')],
      ['Disponibilité', ...ls.map((l) => l.immediate ? 'Immédiate' : 'Sur demande')],
    ];
    return Table(columnWidths: const {0: FlexColumnWidth(1.1)}, children: [
      TableRow(children: [const Text('CRITÈRE', style: TextStyle(fontSize: 11, color: kMuted)), for (final l in ls) Text(l.loc.split(',').first, style: const TextStyle(fontWeight: FontWeight.w800, color: kPrimary))]),
      for (final r in rows)
        TableRow(children: [for (var i = 0; i < r.length; i++) Padding(padding: const EdgeInsets.symmetric(vertical: 8), child: Text(r[i], style: TextStyle(fontSize: 12, color: i == 0 ? kMuted : kInk, fontWeight: i == 0 ? FontWeight.w400 : FontWeight.w600)))]),
    ]);
  }
}

class ComparePage extends StatelessWidget {
  const ComparePage({super.key});
  @override
  Widget build(BuildContext context) {
    final st = AppState.i;
    final cmp = listings.where((l) => st.compare.contains(l.id)).toList();
    return Scaffold(
        appBar: AppBar(title: const Text('Comparateur', style: TextStyle(fontWeight: FontWeight.w800))),
        body: cmp.isEmpty
            ? const Center(child: Text('Sélectionne des logements à comparer.', style: TextStyle(color: kMuted)))
            : ListView(padding: const EdgeInsets.all(16), children: [
                Container(padding: const EdgeInsets.all(14), decoration: boxDeco(), child: _CmpTable(cmp)),
                const SizedBox(height: 14),
                for (final l in cmp) Padding(padding: const EdgeInsets.only(bottom: 8), child: Btn('Réserver visite : ${l.title}', () => Navigator.push(context, MaterialPageRoute(builder: (_) => ContactPage(l))), outline: true)),
              ]));
  }
}
