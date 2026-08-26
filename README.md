# Padel Booking

Client Flutter permettant aux joueurs de consulter les clubs et leurs courts, de visualiser les
créneaux disponibles et de gérer leurs réservations de padel.

## Fonctionnalités

- Création de compte et connexion par e-mail et mot de passe.
- Conservation du jeton JWT dans le stockage sécurisé de l’appareil.
- Consultation des clubs, de leurs horaires et de leurs adresses.
- Navigation vers les courts d’un club et sélection d’une date (jusqu’à un an à l’avance).
- Affichage des créneaux par court et création d’une réservation.
- Consultation des réservations de l’utilisateur connecté.

## Prérequis

- [Flutter](https://docs.flutter.dev/get-started/install) avec le SDK Dart `^3.13.1`.
- Un émulateur ou un appareil compatible Flutter, ou un navigateur pour la cible web.
- Une API Padel Booking disponible et compatible avec les routes décrites ci-dessous.

Vérifiez votre installation Flutter :

```bash
flutter doctor
```

## Installation et lancement

```bash
git clone git@github.com:loicfontaine/padel_booking_front.git
cd padel_booking_front
flutter pub get
flutter run
```

Pour lancer la version web :

```bash
flutter run -d chrome
```

Pour choisir une cible précise, listez les appareils disponibles :

```bash
flutter devices
```

## Configuration de l’API

Le backend associé est disponible dans le
dépôt [padel_booking_backend](https://github.com/loicfontaine/padel_booking_backend). Sa
documentation constitue la référence pour l’installation et le contrat de l’API.

L’URL de base est actuellement définie
dans [lib/services/api_client.dart](lib/services/api_client.dart) :

```dart
BaseOptions
(
baseUrl
:
'
http://localhost:8080/api
'
)
```

L’API attend les routes suivantes :

| Méthode | Route                                      | Usage                                             |
|---------|--------------------------------------------|---------------------------------------------------|
| `POST`  | `/auth/register`                           | Crée un compte et renvoie un jeton.               |
| `POST`  | `/auth/login`                              | Authentifie un utilisateur et renvoie un jeton.   |
| `GET`   | `/clubs`                                   | Liste les clubs.                                  |
| `GET`   | `/courts/club/{clubId}`                    | Liste les courts d’un club.                       |
| `GET`   | `/slots?date=YYYY-MM-DD&courtId={courtId}` | Liste les créneaux d’un court pour une date.      |
| `POST`  | `/bookings`                                | Crée une réservation avec `{ "slotId": ... }`.    |
| `GET`   | `/bookings/user`                           | Liste les réservations de l’utilisateur connecté. |

Après connexion ou inscription, le jeton reçu est envoyé dans l’en-tête
`Authorization: Bearer <token>` des requêtes suivantes.

## Architecture

Le projet suit une organisation simple par responsabilités :

```text
lib/
├── cubits/        # États et logique de présentation (flutter_bloc)
├── models/        # Modèles de données de l’API
├── presentation/
│   ├── screens/   # Écrans de connexion, clubs, courts et réservations
│   └── widgets/   # Composants visuels réutilisables
├── services/      # Client HTTP et accès aux ressources REST
└── main.dart      # Point d’entrée et routage selon l’authentification
```

Principales dépendances :

- `dio` : requêtes HTTP et injection du jeton d’authentification ;
- `flutter_bloc` : gestion d’état avec des cubits ;
- `flutter_secure_storage` : stockage local sécurisé du JWT ;
- `intl` : formatage des dates en français.

## Qualité

Analyse statique :

```bash
flutter analyze
```

Tests :

```bash
flutter test
```
