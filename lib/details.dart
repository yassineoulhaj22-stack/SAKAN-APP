import 'package:flutter/material.dart';
import 'theme.dart';
import 'data.dart';
import 'widgets.dart';

class DetailsPage extends StatelessWidget {
  final Listing l;
  const DetailsPage(this.l, {super.key});

  Widget key(IconData i, String a, String b) => Expanded(
      child: Container(
          margin: const EdgeInsets.all(4),
          padding: const EdgeInsets.all(14),
          decoration: boxDeco(),
          child: Row(children: [
            Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: kSoft, borderRadius: BorderRadius.circular(10)), child: Icon(i, color: kPrimary, size: 20)),
            const SizedBox(width: 10),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(a, style: const TextStyle(fontSize: 11, color: kMuted)),
              Text(b, style: const TextStyle(fontWeight: FontWeight.w800)),
            ])),
          ])));

  @override
  Widget build(BuildContext context) {
    final st = AppState.i;
    return Scaffold(
      bottomNavigationBar: Container(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
          decoration: const BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)]),
          child: SafeArea(
              child: Row(children: [
            Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('${l.price} DH / mois', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
              const Text('Charges incluses', style: TextStyle(fontSize: 11, color: kPrimary)),
            ]),
            const Spacer(),
            Btn('Visiter', () => Navigator.push(context, MaterialPageRoute(builder: (_) => ContactPage(l))), small: true, outline: true, icon: Icons.calendar_today),
            const SizedBox(width: 8),
            Btn('Contacter', () => Navigator.push(context, MaterialPageRoute(builder: (_) => ContactPage(l))), small: true, icon: Icons.chat_bubble_outline),
          ]))),
      body: ListView(padding: EdgeInsets.zero, children: [
        Stack(children: [
          Photo(l.color, h: 280, radius: BorderRadius.zero),
          SafeArea(
              child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(children: [
                    CircleAvatar(backgroundColor: Colors.white, child: IconButton(icon: const Icon(Icons.arrow_back, color: kInk), onPressed: () => Navigator.pop(context))),
                    const Spacer(),
                    const CircleAvatar(backgroundColor: Colors.white, child: Icon(Icons.share, color: kInk, size: 20)),
                    const SizedBox(width: 8),
                    AnimatedBuilder(
                        animation: st,
                        builder: (c, _) => CircleAvatar(
                            backgroundColor: Colors.white,
                            child: IconButton(
                                icon: Icon(st.favs.contains(l.id) ? Icons.favorite : Icons.favorite_border, color: kPrimary),
                                onPressed: () => st.toggleFav(l.id)))),
                  ]))),
          const Positioned(left: 14, bottom: 14, child: Pill('Disponibilité immédiate', bg: Colors.white, fg: kInk, icon: Icons.circle)),
          const Positioned(right: 14, bottom: 14, child: Pill('1 / 4 photos', bg: Colors.black54, fg: Colors.white)),
        ]),
        Padding(
            padding: const EdgeInsets.all(16),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                  padding: const EdgeInsets.all(14),
                  decoration: boxDeco(color: kSoft),
                  child: const Row(children: [
                    Icon(Icons.home_rounded, color: kPrimary, size: 36),
                    SizedBox(width: 12),
                    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text('Certifié & Visité par Sakan', style: TextStyle(fontWeight: FontWeight.w800, color: kPrimary)),
                      Text('Conforme aux photos, loyer et charges vérifiés.', style: TextStyle(fontSize: 12, color: kMuted)),
                    ])),
                    Icon(Icons.check_circle_outline, color: kPrimary),
                  ])),
              const SizedBox(height: 14),
              Text(l.title, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w800, height: 1.15)),
              const SizedBox(height: 6),
              Row(children: [const Icon(Icons.place_outlined, color: kPrimary, size: 18), const SizedBox(width: 4), Expanded(child: Text('${l.loc} · ${l.transport}', style: const TextStyle(color: kMuted)))]),
              const SizedBox(height: 12),
              Container(
                  padding: const EdgeInsets.all(14),
                  decoration: boxDeco(),
                  child: Row(children: [
                    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text('${l.price} DH / mois', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: kPrimary)),
                      const Text('✓ Charges & syndic compris', style: TextStyle(fontSize: 12, color: kGreen)),
                    ]),
                    const Spacer(),
                    const Column(crossAxisAlignment: CrossAxisAlignment.end, children: [Pill('Bail de 12 mois', bg: kSoft), SizedBox(height: 4), Text('Caution : 1 mois', style: TextStyle(fontSize: 12, color: kMuted))]),
                  ])),
              const SectionTitle('Caractéristiques clés'),
              Row(children: [key(Icons.square_foot, 'Surface', '${l.surface} m²'), key(Icons.apartment, 'Étage', '3ème (Ascenseur)')]),
              Row(children: [key(Icons.chair, 'Ameublement', 'Meublé avec goût'), key(Icons.wifi, 'Connectivité', 'Wifi Fibre optique')]),
              const SectionTitle('Description du bien'),
              Container(
                  padding: const EdgeInsets.all(14),
                  decoration: boxDeco(),
                  child: const Text('Situé au cœur battant du quartier, dans un immeuble récent, sécurisé avec gardien 24/7 et ascenseur moderne. Ce logement lumineux baigne dans la lumière naturelle grâce à sa grande baie vitrée orientée sud-ouest.', style: TextStyle(color: kMuted, height: 1.5))),
              const SectionTitle('Équipements inclus'),
              Wrap(spacing: 8, runSpacing: 8, children: [for (final t in l.tags) Pill(t, bg: Colors.white, fg: kInk)]),
              const SectionTitle('Localisation & Trajets'),
              Container(
                  padding: const EdgeInsets.all(14),
                  decoration: boxDeco(),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Container(height: 110, decoration: BoxDecoration(color: const Color(0xFFF1EEE9), borderRadius: BorderRadius.circular(12)), child: const Center(child: Pill('Studio', bg: kPrimary, fg: Colors.white, icon: Icons.home))),
                    const SizedBox(height: 10),
                    const Text('Temps de trajet estimés :', style: TextStyle(fontWeight: FontWeight.w700)),
                    const SizedBox(height: 6),
                    for (final r in const [['Tramway Ibn rochd', '3 min à pied'], ['Pôle Universitaire', '14 min tram'], ['Agdal', '8 min taxi / 18 min pied'], ['Supermarché & Commodités', '2 min à pied']])
                      Container(
                          margin: const EdgeInsets.only(bottom: 6),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(color: const Color(0xFFF5F3F8), borderRadius: BorderRadius.circular(10)),
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(r[0]), Text(r[1], style: const TextStyle(color: kPrimary, fontWeight: FontWeight.w700, fontSize: 13))])),
                  ])),
              const SectionTitle('Propriétaire du bien'),
              Container(
                  padding: const EdgeInsets.all(14),
                  decoration: boxDeco(),
                  child: const Row(children: [
                    CircleAvatar(radius: 26, backgroundColor: kSoft, child: Icon(Icons.person, color: kPrimary)),
                    SizedBox(width: 12),
                    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Row(children: [Text('Karim B. ', style: TextStyle(fontWeight: FontWeight.w800)), Pill('Certifié Sakan')]),
                      Text('Membre depuis 2 ans • 4 biens gérés', style: TextStyle(fontSize: 12, color: kMuted)),
                      Text('⚡ Répond en moins d\'1h (98%)', style: TextStyle(fontSize: 12, color: kGreen)),
                    ])),
                    Icon(Icons.chevron_right),
                  ])),
              const TipCard('Le conseil de Sakan', 'Les studios dans ce secteur sont en moyenne réservés en moins de 48 heures. Préparez votre dossier locatif numérique en 1 clic !'),
            ])),
      ]),
    );
  }
}

class ContactPage extends StatefulWidget {
  final Listing l;
  const ContactPage(this.l, {super.key});
  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  bool onSite = true;
  int day = 0, hour = 1;
  final msg = TextEditingController(text: 'Bonjour Karim, ce studio m\'intéresse beaucoup pour la rentrée universitaire. Est-il toujours libre à partir du 1er juin ? J\'aimerais le visiter au créneau sélectionné.');
  static const days = [['MER', '15 Mai', '3 créneaux'], ['JEU', '16 Mai', '2 créneaux'], ['SAM', '18 Mai', '5 créneaux']];
  static const hours = ['11:00', '14:30', '17:00', '18:30'];

  @override
  Widget build(BuildContext context) {
    final l = widget.l;
    return Scaffold(
      appBar: AppBar(
          title: const Row(children: [
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Contacter Karim B.', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
              Text('Réponse moyenne en moins de 15 min', style: TextStyle(fontSize: 11, color: kMuted)),
            ])),
            CircleAvatar(backgroundColor: kSoft, child: Icon(Icons.person, color: kPrimary)),
          ])),
      bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16),
          child: SafeArea(
              child: Btn('Envoyer la demande & Réserver le créneau', () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => ConfirmPage(l, '${days[day][0] == 'MER' ? 'Mercredi' : days[day][0] == 'JEU' ? 'Jeudi' : 'Samedi'} ${days[day][1]}', hours[hour], onSite)));
          }, icon: Icons.send))),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        Container(
            padding: const EdgeInsets.all(12),
            decoration: boxDeco(),
            child: Row(children: [
              SizedBox(width: 90, child: Photo(l.color, h: 90)),
              const SizedBox(width: 12),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Pill('Disponibilité confirmée par Sakan', bg: Color(0xFFDFF7EA), fg: kGreen, icon: Icons.verified),
                const SizedBox(height: 4),
                Text(l.title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
                Text(l.loc, style: const TextStyle(fontSize: 12, color: kMuted)),
                Text('${l.price} DH / mois', style: const TextStyle(color: kPrimary, fontWeight: FontWeight.w800, fontSize: 18)),
              ])),
            ])),
        const SizedBox(height: 14),
        Container(
            padding: const EdgeInsets.all(16),
            decoration: boxDeco(),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Row(children: [
                Icon(Icons.calendar_month, color: kPrimary),
                SizedBox(width: 8),
                Expanded(child: Text('Choisir un créneau de visite', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800))),
                Pill('Étape 1/2'),
              ]),
              const Text('Sans engagement et gratuit', style: TextStyle(color: kMuted, fontSize: 12)),
              const SizedBox(height: 12),
              Row(children: [
                for (final e in [[true, 'Visite sur place', Icons.place], [false, 'Vidéo guidée', Icons.videocam]])
                  Expanded(child: InkWell(
                      onTap: () => setState(() => onSite = e[0] as bool),
                      child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(color: onSite == e[0] ? kSoft : const Color(0xFFF5F3F8), borderRadius: BorderRadius.circular(12)),
                          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                            Icon(e[2] as IconData, size: 18, color: onSite == e[0] ? kPrimary : kMuted),
                            const SizedBox(width: 6),
                            Text(e[1] as String, style: TextStyle(fontWeight: FontWeight.w700, color: onSite == e[0] ? kPrimary : kMuted)),
                          ])))),
              ]),
              const SizedBox(height: 14),
              const Text('Date disponible', style: TextStyle(fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              Row(children: [
                for (var i = 0; i < 3; i++)
                  Expanded(child: InkWell(
                      onTap: () => setState(() => day = i),
                      child: Container(
                          margin: const EdgeInsets.only(right: 8),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(color: day == i ? kPrimary : Colors.white, border: Border.all(color: kLine), borderRadius: BorderRadius.circular(14)),
                          child: Column(children: [
                            Text(days[i][0], style: TextStyle(fontSize: 12, color: day == i ? Colors.white70 : kMuted)),
                            Text(days[i][1], style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: day == i ? Colors.white : kInk)),
                            Text(days[i][2], style: TextStyle(fontSize: 10, color: day == i ? Colors.white70 : kMuted)),
                          ])))),
              ]),
              const SizedBox(height: 14),
              const Text('Heure souhaitée', style: TextStyle(fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              Row(children: [
                for (var i = 0; i < 4; i++)
                  Expanded(child: InkWell(
                      onTap: () => setState(() => hour = i),
                      child: Container(
                          margin: const EdgeInsets.only(right: 6),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(color: hour == i ? kPrimary : Colors.white, border: Border.all(color: kLine), borderRadius: BorderRadius.circular(12)),
                          child: Center(child: Text(hours[i], style: TextStyle(fontWeight: FontWeight.w700, color: hour == i ? Colors.white : kInk)))))),
              ]),
            ])),
        const SizedBox(height: 14),
        Container(
            padding: const EdgeInsets.all(16),
            decoration: boxDeco(),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Row(children: [
                Icon(Icons.chat_bubble_outline, color: kPrimary),
                SizedBox(width: 8),
                Expanded(child: Text('Message pour Karim', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800))),
                Text('🔒 Chiffré Sakan', style: TextStyle(fontSize: 11, color: kGreen)),
              ]),
              const SizedBox(height: 8),
              Wrap(spacing: 6, runSpacing: 6, children: [
                for (final s in const ['Je suis étudiant(e)', 'Quand emménager ?', 'Dossier complet disponible'])
                  ActionChip(label: Text('+ $s', style: const TextStyle(fontSize: 12)), onPressed: () => setState(() => msg.text = '${msg.text} $s.')),
              ]),
              const SizedBox(height: 8),
              TextField(controller: msg, maxLines: 4, maxLength: 500, decoration: InputDecoration(filled: true, fillColor: kSoft.withOpacity(.4), border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none), helperText: 'Présentez votre situation pour maximiser vos chances')),
            ])),
        const TipCard('Garantie Transparence Sakan', 'Zéro frais cachés. Vos données personnelles et votre caution sont protégées. Aucun versement préalable n\'est requis avant la visite.'),
      ]),
    );
  }
}

class ConfirmPage extends StatelessWidget {
  final Listing l;
  final String date, hour;
  final bool onSite;
  const ConfirmPage(this.l, this.date, this.hour, this.onSite, {super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(automaticallyImplyLeading: false, title: const Logo(), actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.popUntil(context, (r) => r.isFirst))]),
        body: ListView(padding: const EdgeInsets.all(20), children: [
          const Center(child: Mascot(size: 120, item: Icons.check_circle)),
          const SizedBox(height: 8),
          const Center(child: Text('Demande envoyée !', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800))),
          const Center(child: Text('Votre visite est réservée avec Karim', style: TextStyle(color: kMuted))),
          const SizedBox(height: 10),
          const Center(child: Pill('● En attente de confirmation du propriétaire', bg: Color(0xFFFFF1DC), fg: Color(0xFFB45F06))),
          const SizedBox(height: 16),
          Container(
              padding: const EdgeInsets.all(14),
              decoration: boxDeco(),
              child: Column(children: [
                Row(children: [
                  SizedBox(width: 64, child: Photo(l.color, h: 64)),
                  const SizedBox(width: 10),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    const Pill('Studio Meublé'),
                    Text(l.title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
                    Text(l.loc, style: const TextStyle(fontSize: 11, color: kMuted)),
                  ])),
                  Text('${l.price}\nDH/mois', textAlign: TextAlign.right, style: const TextStyle(color: kPrimary, fontWeight: FontWeight.w800)),
                ]),
                const SizedBox(height: 12),
                Row(children: [
                  Expanded(child: _info('Date & Heure', date, '$hour (Créneau réservé)')),
                  const SizedBox(width: 8),
                  Expanded(child: _info('Format de visite', onSite ? 'Visite sur place' : 'Vidéo guidée', 'Durée estimée : 20 min')),
                ]),
                const SizedBox(height: 10),
                Container(width: double.infinity, padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: const Color(0xFFE5F6EE), borderRadius: BorderRadius.circular(10)), child: const Text('🛡 Dossier locatif 100% complet partagé', style: TextStyle(color: kGreen, fontWeight: FontWeight.w700, fontSize: 13))),
              ])),
          const TipCard('Garantie de Sérénité Sakan', 'Le propriétaire s\'engage à vous répondre sous 2 heures. Zéro avance de frais avant la remise des clés et signature du bail certifié.'),
          const SectionTitle('PROCHAINES ÉTAPES'),
          for (final s in const ['Karim confirme la disponibilité du créneau.', 'Rendez-vous sur place à l\'adresse du logement.'].asMap().entries)
            ListTile(dense: true, contentPadding: EdgeInsets.zero, leading: CircleAvatar(radius: 12, backgroundColor: s.key == 0 ? kPrimary : kLine, child: Text('${s.key + 1}', style: TextStyle(fontSize: 12, color: s.key == 0 ? Colors.white : kMuted))), title: Text(s.value)),
          const SizedBox(height: 10),
          Btn('Accéder à la messagerie', () => Navigator.push(context, MaterialPageRoute(builder: (_) => ChatPage(l, date, hour))), icon: Icons.chat),
          const SizedBox(height: 10),
          Btn('Ajouter au calendrier', () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Visite ajoutée au calendrier'))), outline: true, icon: Icons.event),
          TextButton(onPressed: () => Navigator.popUntil(context, (r) => r.isFirst), child: const Text('Retourner à l\'accueil', style: TextStyle(color: kMuted))),
        ]),
      );

  Widget _info(String a, String b, String c) => Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: const Color(0xFFF5F3F8), borderRadius: BorderRadius.circular(12)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(a, style: const TextStyle(fontSize: 11, color: kMuted)),
        Text(b, style: const TextStyle(fontWeight: FontWeight.w800)),
        Text(c, style: const TextStyle(fontSize: 11, color: kPrimary)),
      ]));
}

class ChatPage extends StatefulWidget {
  final Listing l;
  final String date, hour;
  const ChatPage(this.l, this.date, this.hour, {super.key});
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final input = TextEditingController();
  late final List<List<dynamic>> msgs = [
    [true, 'Bonjour Karim, j\'ai réservé le créneau du ${widget.date} à ${widget.hour} pour visiter le studio. Mon dossier locatif Sakan est vérifié et complet.', '10:42'],
    [false, 'Bonjour ! Parfait, le créneau est validé. Je vous attends à ${widget.hour} devant l\'immeuble. Avez-vous besoin du lien de localisation exacte ?', '10:45'],
    [true, 'Oui avec plaisir, merci beaucoup !', '10:46'],
  ];
  void send(String t) {
    if (t.trim().isEmpty) return;
    setState(() => msgs.add([true, t.trim(), 'maintenant']));
    input.clear();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
            title: const Row(children: [
              CircleAvatar(backgroundColor: kSoft, child: Icon(Icons.person, color: kPrimary)),
              SizedBox(width: 10),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [Text('Karim B. ', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17)), Pill('HÔTE')]),
                Text('● En ligne • Répond en 15 min', style: TextStyle(fontSize: 11, color: kGreen)),
              ])),
              Icon(Icons.phone, color: kPrimary),
            ])),
        body: Column(children: [
          Container(
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.all(10),
              decoration: boxDeco(),
              child: Row(children: [
                SizedBox(width: 44, child: Photo(widget.l.color, h: 44)),
                const SizedBox(width: 10),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(widget.l.title, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.w700)),
                  Text('${widget.l.price} DH /mois', style: const TextStyle(color: kPrimary, fontWeight: FontWeight.w700, fontSize: 12)),
                ])),
                Pill('${widget.date} ${widget.hour}', bg: const Color(0xFFDFF7EA), fg: kGreen),
              ])),
          Expanded(
              child: ListView(padding: const EdgeInsets.symmetric(horizontal: 14), children: [
            Container(margin: const EdgeInsets.only(bottom: 12), padding: const EdgeInsets.all(12), decoration: boxDeco(color: kSoft), child: const Row(children: [Icon(Icons.lock, color: kPrimary), SizedBox(width: 10), Expanded(child: Text('Garantie Sakan Protection : ne transférez aucun fonds d\'acompte avant la visite physique des lieux.', style: TextStyle(fontSize: 12, color: kMuted)))])),
            for (final m in msgs)
              Align(
                  alignment: m[0] ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(12),
                      constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * .75),
                      decoration: BoxDecoration(color: m[0] ? kPrimary : Colors.white, border: m[0] ? null : Border.all(color: kLine), borderRadius: BorderRadius.circular(18)),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                        Text(m[1], style: TextStyle(color: m[0] ? Colors.white : kInk, height: 1.35)),
                        Text('${m[2]}${m[0] ? ' ✓✓' : ''}', style: TextStyle(fontSize: 10, color: m[0] ? Colors.white70 : kMuted)),
                      ]))),
            Container(
                margin: const EdgeInsets.only(bottom: 10, right: 40),
                padding: const EdgeInsets.all(12),
                decoration: boxDeco(),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Container(height: 70, decoration: BoxDecoration(color: const Color(0xFFF1EEE9), borderRadius: BorderRadius.circular(10)), child: const Center(child: Icon(Icons.place, color: kPrimary, size: 34))),
                  const SizedBox(height: 8),
                  Text(widget.l.loc, style: const TextStyle(fontWeight: FontWeight.w800)),
                  Text(widget.l.transport, style: const TextStyle(fontSize: 12, color: kMuted)),
                  const SizedBox(height: 8),
                  Btn('Ouvrir l\'itinéraire Tramway', () {}, small: true, outline: true, icon: Icons.directions),
                ])),
          ])),
          SizedBox(
              height: 40,
              child: ListView(scrollDirection: Axis.horizontal, padding: const EdgeInsets.symmetric(horizontal: 12), children: [
                for (final q in const ['Je serai là à l\'heure 👋', 'Pouvez-vous m\'appeler ? 📞', 'Partager mon dossier'])
                  Padding(padding: const EdgeInsets.only(right: 8), child: ActionChip(label: Text(q, style: const TextStyle(fontSize: 12)), backgroundColor: Colors.white, onPressed: () => send(q))),
              ])),
          Padding(
              padding: const EdgeInsets.all(12),
              child: SafeArea(
                  child: Row(children: [
                Expanded(child: TextField(controller: input, onSubmitted: send, decoration: InputDecoration(hintText: 'Écrivez votre message...', filled: true, fillColor: Colors.white, border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none)))),
                const SizedBox(width: 8),
                InkWell(onTap: () => send(input.text), child: Container(padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: kPrimary, borderRadius: BorderRadius.circular(16)), child: const Icon(Icons.send, color: Colors.white))),
              ]))),
        ]),
      );
}
