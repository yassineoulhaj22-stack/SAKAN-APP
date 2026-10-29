import 'package:flutter/material.dart';
import 'theme.dart';
import 'data.dart';
import 'details.dart';

BoxDecoration boxDeco({Color color = Colors.white, double r = 18, bool border = true}) =>
    BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(r),
        border: border ? Border.all(color: kLine) : null);

class Mascot extends StatelessWidget {
  final double size;
  final IconData? item;
  final Color itemColor;
  const Mascot({super.key, this.size = 160, this.item, this.itemColor = kGreen});
  Widget _eye(double s) => Container(
      width: s * 0.15,
      height: s * 0.13,
      decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
      child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
              width: s * 0.07,
              height: s * 0.07,
              decoration: const BoxDecoration(color: kInk, shape: BoxShape.circle))));
  Widget _leg(double s) => Container(
      width: s * 0.15,
      height: s * 0.2,
      decoration: BoxDecoration(
          color: kPrimary, borderRadius: BorderRadius.vertical(top: Radius.circular(s * 0.04), bottom: Radius.circular(s * 0.08))));
  @override
  Widget build(BuildContext context) {
    final s = size;
    return SizedBox(
        width: s,
        height: s,
        child: Stack(alignment: Alignment.center, children: [
          Positioned(
              top: s * 0.08,
              child: Container(
                  width: s * 0.62,
                  height: s * 0.55,
                  decoration: BoxDecoration(
                      color: kPrimary,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(s * 0.2),
                          topRight: Radius.circular(s * 0.3),
                          bottomLeft: Radius.circular(s * 0.05),
                          bottomRight: Radius.circular(s * 0.2))))),
          Positioned(top: s * 0.3, child: Row(children: [_eye(s), SizedBox(width: s * 0.08), _eye(s)])),
          Positioned(bottom: s * 0.05, child: Row(children: [_leg(s), SizedBox(width: s * 0.12), _leg(s)])),
          if (item != null)
            Positioned(right: s * 0.06, bottom: s * 0.22, child: Icon(item, size: s * 0.3, color: itemColor)),
        ]));
  }
}

class Logo extends StatelessWidget {
  const Logo({super.key});
  @override
  Widget build(BuildContext context) => const Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(Icons.home_rounded, color: kPrimary, size: 34),
        SizedBox(width: 6),
        Text('sakan', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800, color: kInk)),
      ]);
}

class Pill extends StatelessWidget {
  final String t;
  final Color bg, fg;
  final IconData? icon;
  const Pill(this.t, {super.key, this.bg = kSoft, this.fg = kPrimary, this.icon});
  @override
  Widget build(BuildContext context) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(20)),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        if (icon != null) ...[Icon(icon, size: 14, color: fg), const SizedBox(width: 4)],
        Text(t, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: fg)),
      ]));
}

class Btn extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final IconData? icon;
  final bool outline, small, trailing;
  const Btn(this.label, this.onTap,
      {super.key, this.icon, this.outline = false, this.small = false, this.trailing = false});
  @override
  Widget build(BuildContext context) {
    final fg = outline ? kPrimary : Colors.white;
    final txt = Text(label, style: TextStyle(fontWeight: FontWeight.w700, fontSize: small ? 13 : 15, color: fg));
    final ic = icon == null ? null : Icon(icon, size: small ? 16 : 20, color: fg);
    return InkWell(
        borderRadius: BorderRadius.circular(small ? 12 : 16),
        onTap: onTap,
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: small ? 14 : 20, vertical: small ? 11 : 16),
            decoration: BoxDecoration(
                color: outline ? Colors.white : kPrimary,
                border: outline ? Border.all(color: kLine) : null,
                borderRadius: BorderRadius.circular(small ? 12 : 16),
                boxShadow: outline || small
                    ? null
                    : [BoxShadow(color: kPrimary.withOpacity(.3), blurRadius: 14, offset: const Offset(0, 6))]),
            child: Row(mainAxisSize: small ? MainAxisSize.min : MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center, children: [
              if (ic != null && !trailing) ...[ic, const SizedBox(width: 8)],
              txt,
              if (ic != null && trailing) ...[const SizedBox(width: 8), ic],
            ])));
  }
}

class Photo extends StatelessWidget {
  final Color color;
  final double h;
  final BorderRadius radius;
  const Photo(this.color, {super.key, this.h = 190, this.radius = const BorderRadius.all(Radius.circular(14))});
  @override
  Widget build(BuildContext context) => Container(
      height: h,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: radius,
          gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [color, color.withOpacity(.55)])),
      child: Center(child: Icon(Icons.chair_alt_rounded, size: h * .35, color: Colors.white54)));
}

class SectionTitle extends StatelessWidget {
  final String t;
  final String? action;
  final VoidCallback? onAction;
  const SectionTitle(this.t, {super.key, this.action, this.onAction});
  @override
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 10),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(t, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
        if (action != null)
          GestureDetector(onTap: onAction, child: Text(action!, style: const TextStyle(color: kPrimary, fontWeight: FontWeight.w600))),
      ]));
}

class TipCard extends StatelessWidget {
  final String title, text;
  const TipCard(this.title, this.text, {super.key});
  @override
  Widget build(BuildContext context) => Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(14),
      decoration: boxDeco(color: kSoft),
      child: Row(children: [
        Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
            child: const Mascot(size: 48)),
        const SizedBox(width: 12),
        Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w800, color: kPrimary)),
          const SizedBox(height: 2),
          Text(text, style: const TextStyle(fontSize: 13, color: kMuted)),
        ])),
      ]));
}

class ListingCard extends StatelessWidget {
  final Listing l;
  final bool compare;
  const ListingCard(this.l, {super.key, this.compare = false});
  @override
  Widget build(BuildContext context) {
    final st = AppState.i;
    return AnimatedBuilder(
        animation: st,
        builder: (c, _) {
          final fav = st.favs.contains(l.id);
          final cmp = st.compare.contains(l.id);
          return Container(
              margin: const EdgeInsets.only(bottom: 16),
              decoration: boxDeco(),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Stack(children: [
                  Padding(
                      padding: const EdgeInsets.all(8),
                      child: Photo(l.color, h: 190)),
                  Positioned(
                      left: 18,
                      top: 18,
                      child: Wrap(spacing: 6, children: [
                        if (l.immediate) const Pill('Dispo immédiate', bg: Color(0xFFDFF7EA), fg: kGreen),
                        if (l.verified) const Pill('Vérifié Sakan', icon: Icons.verified),
                      ])),
                  Positioned(
                      right: 18,
                      top: 18,
                      child: InkWell(
                          onTap: () => st.toggleFav(l.id),
                          child: CircleAvatar(
                              radius: 18,
                              backgroundColor: Colors.white,
                              child: Icon(fav ? Icons.favorite : Icons.favorite_border, color: kPrimary, size: 20)))),
                  if (compare)
                    Positioned(
                        left: 18,
                        bottom: 18,
                        child: InkWell(
                            onTap: () => st.toggleCompare(l.id),
                            child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                                child: Row(mainAxisSize: MainAxisSize.min, children: [
                                  Icon(cmp ? Icons.check_box : Icons.check_box_outline_blank, color: kPrimary, size: 18),
                                  const SizedBox(width: 4),
                                  const Text('Comparer', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                                ])))),
                ]),
                Padding(
                    padding: const EdgeInsets.fromLTRB(16, 6, 16, 16),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(l.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                      const SizedBox(height: 4),
                      Row(children: [
                        const Icon(Icons.place_outlined, size: 16, color: kMuted),
                        const SizedBox(width: 4),
                        Expanded(child: Text('${l.loc} (${l.transport})', style: const TextStyle(color: kMuted, fontSize: 13))),
                      ]),
                      const SizedBox(height: 8),
                      Wrap(spacing: 6, runSpacing: 6, children: [
                        for (final t in l.tags.take(3))
                          Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(color: const Color(0xFFF2F0F7), borderRadius: BorderRadius.circular(8)),
                              child: Text(t, style: const TextStyle(fontSize: 11, color: kMuted))),
                      ]),
                      const Divider(height: 24, color: kLine),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          const Text('Loyer mensuel', style: TextStyle(fontSize: 11, color: kMuted)),
                          Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                            Text('${l.price} DH', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: kPrimary)),
                            const Text(' / mois', style: TextStyle(fontSize: 12, color: kMuted)),
                          ]),
                        ]),
                        Btn('Voir détails', () => Navigator.push(c, MaterialPageRoute(builder: (_) => DetailsPage(l))),
                            small: true, icon: Icons.arrow_forward, trailing: true),
                      ]),
                    ])),
              ]));
        });
  }
}
