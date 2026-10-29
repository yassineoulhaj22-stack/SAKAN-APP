import 'package:flutter/material.dart';
import 'theme.dart';
import 'data.dart';
import 'widgets.dart';
import 'onboarding.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  Widget card(Widget child) => Container(margin: const EdgeInsets.only(bottom: 14), padding: const EdgeInsets.all(16), decoration: boxDeco(), child: child);
  Widget stat(String a, String b) => Expanded(child: Container(margin: const EdgeInsets.all(3), padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: const Color(0xFFF5F3F8), borderRadius: BorderRadius.circular(12)), child: Column(children: [Text(a, style: const TextStyle(fontSize: 11, color: kMuted)), Text(b, style: const TextStyle(fontWeight: FontWeight.w800, color: kPrimary))])));
  Widget act(IconData i, String t, String s, {Color c = kPrimary}) => Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: boxDeco(),
      child: Row(children: [
        Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: kSoft, borderRadius: BorderRadius.circular(12)), child: Icon(i, color: c)),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(t, style: const TextStyle(fontWeight: FontWeight.w800)), Text(s, style: const TextStyle(fontSize: 12, color: kMuted))])),
        const Icon(Icons.chevron_right, color: kMuted),
      ]));

  @override
  Widget build(BuildContext context) => ListView(padding: const EdgeInsets.all(16), children: [
        card(Column(children: [
          const Row(children: [
            CircleAvatar(radius: 32, backgroundColor: kSoft, child: Icon(Icons.person, color: kPrimary, size: 36)),
            SizedBox(width: 14),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Lina', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
              Text('Étudiant / Jeune actif', style: TextStyle(color: kMuted)),
              SizedBox(height: 4),
              Pill('Dossier vérifié Sakan (100%)', icon: Icons.verified),
            ])),
            Icon(Icons.edit_outlined, color: kPrimary),
          ]),
          const Divider(height: 24, color: kLine),
          Row(children: [stat('Dossier', 'Complet'), stat('Visites', '1 active'), stat('Alertes', '2 ciblées')]),
        ])),
        card(Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Row(children: [Icon(Icons.tune, color: kPrimary), SizedBox(width: 8), Expanded(child: Text('Mon profil de recherche', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800))), Text('Ajuster', style: TextStyle(color: kPrimary))]),
          const SizedBox(height: 10),
          _line(Icons.school_outlined, 'École / Entreprise ciblée', 'Faculté de Médecine et pharmacie\nRayon max 20 min en tramway / marche'),
          _line(Icons.payments_outlined, 'Budget cible', '1500 – 2500 DH/mois · Charges comprises'),
          _line(Icons.place_outlined, 'Villes & Quartiers', 'Rabat (Al Irfane) · Rabat (Agdal)'),
        ])),
        card(Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Row(children: [Icon(Icons.folder_outlined, color: kPrimary), SizedBox(width: 8), Expanded(child: Text('Mon Dossier Locatif numérique', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800))), Pill('Prêt à l\'envoi', bg: Color(0xFFDFF7EA), fg: kGreen)]),
          const SizedBox(height: 10),
          for (final r in const [['Pièce d\'identité (CNIE marocaine)', 'Vérifiée et chiffrée'], ['Justificatif étudiant / inscription', 'Année universitaire 2024 - 2025'], ['Garant certifié & Justificatif de revenu', 'Revenu 3× supérieur validé']])
            Container(margin: const EdgeInsets.only(bottom: 8), padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: const Color(0xFFF5F3F8), borderRadius: BorderRadius.circular(14)), child: Row(children: [
              const Icon(Icons.check_circle, color: kGreen),
              const SizedBox(width: 10),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(r[0], style: const TextStyle(fontWeight: FontWeight.w700)), Text(r[1], style: const TextStyle(fontSize: 12, color: kMuted))])),
              const Icon(Icons.visibility_outlined, color: kMuted),
            ])),
          Btn('Télécharger / Mettre à jour mon dossier', () => Navigator.push(context, MaterialPageRoute(builder: (_) => const DossierPage())), icon: Icons.upload_file),
        ])),
        const Padding(padding: EdgeInsets.only(left: 4, bottom: 8), child: Text('Activité récente', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800))),
        act(Icons.calendar_today, 'Mes visites planifiées', 'Studio moderne Maarif Extension – Jeudi 16h30'),
        act(Icons.notifications_active_outlined, 'Mes alertes actives', '2 alertes configurées (Maarif ≤ 4 500 DH)'),
        act(Icons.history, 'Historique de candidatures', '3 logements consultés et partagés'),
        const TipCard('Besoin d\'aide ? Demande à Sakan !', '"Ton dossier est prêt à 100%. Je peux t\'aider à débloquer une visite prioritaire en 2 clics !"'),
        Center(
            child: TextButton.icon(
                onPressed: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const Onboarding()), (r) => false),
                icon: const Icon(Icons.logout, color: Colors.red),
                label: const Text('Déconnexion de mon compte', style: TextStyle(color: Colors.red)))),
      ]);

  Widget _line(IconData i, String a, String b) => Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: const Color(0xFFF5F3F8), borderRadius: BorderRadius.circular(14)),
      child: Row(children: [
        Icon(i, color: kPrimary),
        const SizedBox(width: 10),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(a, style: const TextStyle(fontSize: 11, color: kMuted)), Text(b, style: const TextStyle(fontWeight: FontWeight.w700))])),
      ]));
}

class DossierPage extends StatefulWidget {
  const DossierPage({super.key});
  @override
  State<DossierPage> createState() => _DossierPageState();
}

class _DossierPageState extends State<DossierPage> {
  bool filigrane = true;
  @override
  Widget build(BuildContext context) {
    final st = AppState.i;
    return AnimatedBuilder(
        animation: st,
        builder: (c, _) {
          final n = st.quittance ? 4 : 3;
          return Scaffold(
            appBar: AppBar(title: const Text('Dossier Locatif', style: TextStyle(fontWeight: FontWeight.w800)), actions: const [Icon(Icons.lock_outline, color: kPrimary), SizedBox(width: 16)]),
            bottomNavigationBar: Padding(
                padding: const EdgeInsets.all(16),
                child: SafeArea(
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Btn('Valider & Activer le dossier prioritaire', () {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Dossier prioritaire activé ✓')));
                    Navigator.pop(context);
                  }, icon: Icons.verified_user),
                  const SizedBox(height: 6),
                  const Text('Télécharger mon dossier complet en 1 clic (PDF sécurisé)', style: TextStyle(fontSize: 11, color: kPrimary)),
                ]))),
            body: ListView(padding: const EdgeInsets.all(16), children: [
              Container(
                  padding: const EdgeInsets.all(16),
                  decoration: boxDeco(),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Pill(n == 4 ? 'Complet • Prioritaire' : 'Presque prêt • Prioritaire'), Text('$n/4', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: kPrimary))]),
                    const SizedBox(height: 8),
                    Text('Complété à ${n * 25}%', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
                    const SizedBox(height: 8),
                    ClipRRect(borderRadius: BorderRadius.circular(8), child: LinearProgressIndicator(value: n / 4, minHeight: 8, color: kPrimary, backgroundColor: kSoft)),
                    const SizedBox(height: 10),
                    const Text('Conseil Sakan : un dossier complet multiplie par 3× tes chances d\'obtenir une visite rapide auprès des propriétaires vérifiés !', style: TextStyle(fontSize: 12, color: kMuted)),
                    const SizedBox(height: 8),
                    const Text('🔒 Chiffré AES-256 • Conforme CNDP Maroc', style: TextStyle(fontSize: 11, color: kMuted)),
                  ])),
              const SectionTitle('Pièces requises'),
              for (final d in const [
                ['Pièce d\'identité (CNIE ou Passeport)', 'CNIE_recto_verso_Lina.pdf (1.8 Mo)', 'Validé le 12 Mai', Icons.badge_outlined],
                ['Certificat de scolarité ou Contrat', 'Attestation_Inscription_FMD rabat_2024.pdf (920 Ko)', 'Statut étudiant validé', Icons.school_outlined],
                ['Garant & Justificatif de revenus', '3 derniers bulletins de paie (Garant familial)', 'Solvabilité 3x loyer certifiée', Icons.payments_outlined],
              ])
                Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(14),
                    decoration: boxDeco(),
                    child: Row(children: [
                      Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: kSoft, borderRadius: BorderRadius.circular(12)), child: Icon(d[3] as IconData, color: kPrimary)),
                      const SizedBox(width: 12),
                      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(d[0] as String, style: const TextStyle(fontWeight: FontWeight.w800)),
                        Text(d[1] as String, style: const TextStyle(fontSize: 12, color: kMuted)),
                        const SizedBox(height: 4),
                        Pill('✓ ${d[2]}', bg: const Color(0xFFE5F6EE), fg: kGreen),
                      ])),
                      const Icon(Icons.visibility_outlined, color: kMuted),
                    ])),
              Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(color: st.quittance ? const Color(0xFFE5F6EE) : const Color(0xFFF8F6FF), borderRadius: BorderRadius.circular(18), border: Border.all(color: kPrimary.withOpacity(.4))),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    const Row(children: [Expanded(child: Text('Quittance précédente ou hébergement', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16))), Pill('Recommandé', bg: Color(0xFFFFF1DC), fg: Color(0xFFB45F06))]),
                    const Text('Dernière quittance de loyer ou attestation sur l\'honneur', style: TextStyle(fontSize: 12, color: kMuted)),
                    const SizedBox(height: 10),
                    if (st.quittance)
                      const Pill('✓ Quittance_loyer.pdf importée', bg: Colors.white, fg: kGreen)
                    else
                      Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
                          child: Column(children: [
                            const CircleAvatar(backgroundColor: kSoft, child: Icon(Icons.cloud_upload_outlined, color: kPrimary)),
                            const SizedBox(height: 8),
                            const Text('Glisse ton fichier ici ou clique pour parcourir', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                            const Text('PDF, JPG, PNG (Max. 10 Mo)', style: TextStyle(fontSize: 11, color: kMuted)),
                            const SizedBox(height: 10),
                            Row(children: [
                              Expanded(child: Btn('Importer', () => st.setQuittance(true), small: true, icon: Icons.file_upload_outlined)),
                              const SizedBox(width: 8),
                              Expanded(child: Btn('Scanner', () => st.setQuittance(true), small: true, outline: true, icon: Icons.camera_alt_outlined)),
                            ]),
                          ])),
                  ])),
              const SizedBox(height: 14),
              Container(
                  padding: const EdgeInsets.all(14),
                  decoration: boxDeco(),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    const Text('Protection & Confidentialité Sakan', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
                    SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Filigrane antivol automatique', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                        subtitle: const Text('Applique la mention infalsifiable : « Document exclusivement destiné à la location Sakan ».', style: TextStyle(fontSize: 11)),
                        value: filigrane,
                        activeTrackColor: kPrimary,
                        activeColor: Colors.white,
                        onChanged: (v) => setState(() => filigrane = v)),
                    const Divider(color: kLine),
                    const Text('Révélation sécurisée', style: TextStyle(fontWeight: FontWeight.w700)),
                    const Text('Le propriétaire n\'accède à tes pièces complètes qu\'une fois votre créneau de visite mutuellement confirmé.', style: TextStyle(fontSize: 12, color: kMuted)),
                  ])),
            ]),
          );
        });
  }
}
