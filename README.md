# Sakan – APK Android (www/index.html + Capacitor)

L'application est dans `www/index.html` (HTML/CSS/JS, fonctionne hors-ligne).
Capacitor l'emballe dans une vraie APK Android.

## Obtenir l'APK
1. Crée un dépôt GitHub et envoies-y **tout le contenu** de ce ZIP (dossier `.github` inclus).
2. Onglet **Actions** → **Build and Deploy Sakan APK** → *Run workflow* (ou un simple push).
3. Quand c'est vert : page du dépôt → **Releases** → télécharge `Sakan.apk`
   (aussi dans l'exécution → Artifacts → `sakan-apk`).

Si la publication échoue : Settings → Actions → General → Workflow permissions → *Read and write*.

L'APK est en mode debug : elle s'installe directement sur le téléphone
(autoriser « sources inconnues »).
