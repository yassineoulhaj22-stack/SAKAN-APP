# Sakan – App Android (Flutter)

Application de location de logements (Maroc) : onboarding, accueil, recherche + filtres + carte,
détails, prise de visite, confirmation, messagerie, favoris/comparateur, dossier locatif, profil.

## Générer l'APK avec GitHub
1. Crée un dépôt GitHub et envoie-y **tout le contenu** de ce ZIP (le dossier `.github` inclus).
2. Va dans l'onglet **Actions** → workflow **Build Sakan APK** → *Run workflow* (ou fais simplement un push).
3. Quand le build est vert, ouvre l'exécution → **Artifacts** → télécharge `sakan-apk` → `app-release.apk`.

Le workflow génère automatiquement les fichiers Android (`flutter create`) puis compile l'APK.

## En local
```
flutter create --platforms=android --org ma.sakan --project-name sakan .
flutter run
```
