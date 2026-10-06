# FreezeNut 🧊

Frigo et congélateur intelligent avec IA projet réalisé dans le cadre de l'épreuve **E5** du BTS SIO (2ᵉ année, option SLAM).

## 👥 Équipe

- Albert Lame
- Yacine Bensassi
- Ibrahima Kan

## 🎯 Problématique

On oublie souvent ce qu'il y a dans son frigo ou son congélateur : dates de péremption, quantités restantes, produits en double... Résultat : gaspillage alimentaire, achats inutiles et perte de temps.

## 💡 Solution

FreezeNut est un réfrigérateur/congélateur connecté capable de suivre automatiquement les produits qu'il contient (pas seulement leur présence, mais aussi les quantités restantes et leur évolution), grâce à :

- des **caméras** qui voient les produits,
- une **IA** qui les reconnaît,
- des **capteurs** qui mesurent les quantités,
- une **application web** qui informe l'utilisateur en temps réel,
- un **cloud** qui synchronise les données.

## ⚙️ Fonctionnalités prévues (MVP)

- Compte / Connexion
- Gestion des produits
- Gestion des quantités
- Suivi des dates de péremption
- Scan de ticket de caisse
- Liste de courses automatique
- Alertes

**Ce qui change par rapport à un frigo classique :**

| Classique | FreezeNut |
|---|---|
| Saisie manuelle | Inventaire quasi automatique |
| Quantités approximatives | Suivi plus précis et intelligent |
| Oublis fréquents | Alertes et anticipation |

## 🏗️ Architecture technique

```
Utilisateur → Application Web (HTML/CSS/JS) → Back-end PHP → Base de données MySQL/MariaDB → Serveur d'hébergement
```

**Stack :**
- Frontend : HTML / CSS / JavaScript
- Backend : PHP
- Base de données : MySQL / MariaDB
- Hébergement : prestataire tiers (HTTPS, pare-feu, sauvegardes, accès admin sécurisé)

## 📎 Contexte

Projet réalisé pour l'épreuve E5 du BTS SIO.
