import 'package:flutter/material.dart';

class Listing {
  final int id;
  final String title, loc, city, transport;
  final int price, surface;
  final List<String> tags;
  final bool verified, immediate;
  final Color color;
  const Listing(this.id, this.title, this.loc, this.city, this.price, this.surface,
      this.transport, this.tags, this.color,
      {this.verified = false, this.immediate = false});
}

const listings = <Listing>[
  Listing(0, 'Studio moderne ensoleillé', 'Gauthier, Casablanca', 'Casablanca', 4200, 42,
      '10 min Tramway', ['Wifi Fibre', 'Meublé', 'Balcon'], Color(0xFFB8A58C), verified: true, immediate: true),
  Listing(1, 'Appartement Agdal Campus', 'Agdal, Rabat', 'Rabat', 3800, 55,
      '3 min Université', ['Proche Fac', 'Machine à laver', 'Gardiennage 24/7'], Color(0xFFC9B6A4), verified: true, immediate: true),
  Listing(2, 'Bel Appartement Maarif', 'Maarif Extension, Casablanca', 'Casablanca', 5800, 78,
      '2 min Busway', ['Garage sous-sol'], Color(0xFFB9A7B8)),
  Listing(3, 'Bel appartement 2 pièces rénové', 'Yaakob el mansour, Rabat', 'Rabat', 3000, 60,
      '8 min tramway', ['2 ch', 'Étage 3 avec ascenseur'], Color(0xFFD1C2AE), immediate: true),
  Listing(4, 'Studio cosy tout équipé', 'Av. Al amal, Rabat', 'Rabat', 2300, 35,
      '3 min station', ['Studio meublé', 'Fibre incluse'], Color(0xFFC4AE98), verified: true),
  Listing(5, 'Chambre spacieuse en colocation conviviale', 'Al irfan, Rabat', 'Rabat', 2500, 18,
      '10 min universités', ['Chambre privée 18 m²', 'Charges comprises', 'Coloc 3 pers.'], Color(0xFFBBB3C9)),
  Listing(6, 'Superbe Studio Meublé – Quartier Al irfan', 'Av. Allal Al Fassi, Rabat 11000', 'Rabat', 2500, 42,
      '3 min à pied du Tramway Ibn Rochd', ['Smart TV 43"', 'Climatisation réversible', 'Lave-linge', 'Balcon sans vis-à-vis', 'Concierge & Caméras'],
      Color(0xFFB7A894), verified: true, immediate: true),
];

class AppState extends ChangeNotifier {
  static final AppState i = AppState._();
  AppState._();
  final Set<int> favs = {0, 1, 2};
  final Set<int> compare = {0, 1};
  bool quittance = false;
  void toggleFav(int id) {
    favs.contains(id) ? favs.remove(id) : favs.add(id);
    notifyListeners();
  }

  void toggleCompare(int id) {
    if (compare.contains(id)) {
      compare.remove(id);
    } else if (compare.length < 4) {
      compare.add(id);
    }
    notifyListeners();
  }

  void setQuittance(bool v) {
    quittance = v;
    notifyListeners();
  }
}
