-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : mar. 17 nov. 2026 à 17:11
-- Version du serveur : 10.4.32-MariaDB
-- Version de PHP : 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `freezenut`
--

-- --------------------------------------------------------

--
-- Structure de la table `alerte`
--

CREATE TABLE `alerte` (
  `id_alerte` int(11) NOT NULL,
  `id_utilisateur` int(11) NOT NULL,
  `id_aliment` int(11) DEFAULT NULL,
  `message` varchar(255) NOT NULL,
  `type_alerte` varchar(50) NOT NULL,
  `date_alerte` datetime NOT NULL DEFAULT current_timestamp(),
  `statut` enum('non_lue','lue') NOT NULL DEFAULT 'non_lue'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `aliment`
--

CREATE TABLE `aliment` (
  `id_aliment` int(11) NOT NULL,
  `id_frigo` int(11) NOT NULL,
  `id_produit` int(11) NOT NULL,
  `quantite` decimal(10,2) NOT NULL DEFAULT 1.00,
  `date_ajout` datetime NOT NULL DEFAULT current_timestamp(),
  `date_peremption` date DEFAULT NULL,
  `emplacement` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `analyse_ia`
--

CREATE TABLE `analyse_ia` (
  `id_analyse` int(11) NOT NULL,
  `id_frigo` int(11) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `resultat` text DEFAULT NULL,
  `date_analyse` datetime NOT NULL DEFAULT current_timestamp(),
  `statut` enum('en_attente','terminee','echec') NOT NULL DEFAULT 'terminee'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `capteur`
--

CREATE TABLE `capteur` (
  `id_capteur` int(11) NOT NULL,
  `id_frigo` int(11) NOT NULL,
  `type_capteur` enum('temperature','humidite','camera','poids','ouverture') NOT NULL,
  `emplacement` varchar(100) DEFAULT NULL,
  `unite_mesure` varchar(20) DEFAULT NULL,
  `actif` tinyint(1) NOT NULL DEFAULT 1,
  `date_installation` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `categorie`
--

CREATE TABLE `categorie` (
  `id_categorie` int(11) NOT NULL,
  `nom_categorie` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `categorie`
--

INSERT INTO `categorie` (`id_categorie`, `nom_categorie`) VALUES
(2, 'Boissons'),
(6, 'Desserts'),
(5, 'Épicerie'),
(3, 'Fruits et légumes'),
(1, 'Produits laitiers'),
(4, 'Viandes et poissons');

-- --------------------------------------------------------

--
-- Structure de la table `detection_ia`
--

CREATE TABLE `detection_ia` (
  `id_detection` int(11) NOT NULL,
  `id_analyse` int(11) NOT NULL,
  `id_produit` int(11) DEFAULT NULL,
  `nom_detecte` varchar(150) NOT NULL,
  `quantite` decimal(10,2) DEFAULT NULL,
  `confiance` decimal(5,2) DEFAULT NULL,
  `date_peremption_estimee` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `frigo`
--

CREATE TABLE `frigo` (
  `id_frigo` int(11) NOT NULL,
  `id_utilisateur` int(11) NOT NULL,
  `nom_frigo` varchar(100) NOT NULL,
  `temperature` decimal(4,1) DEFAULT 4.0,
  `date_creation` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `historique_stock`
--

CREATE TABLE `historique_stock` (
  `id_historique` int(11) NOT NULL,
  `id_aliment` int(11) NOT NULL,
  `quantite_avant` decimal(10,2) DEFAULT NULL,
  `quantite_apres` decimal(10,2) DEFAULT NULL,
  `type_mouvement` varchar(50) NOT NULL,
  `date_mouvement` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `liste_courses`
--

CREATE TABLE `liste_courses` (
  `id_liste` int(11) NOT NULL,
  `id_utilisateur` int(11) NOT NULL,
  `nom_liste` varchar(100) NOT NULL,
  `date_creation` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `liste_courses_item`
--

CREATE TABLE `liste_courses_item` (
  `id_item` int(11) NOT NULL,
  `id_liste` int(11) NOT NULL,
  `id_produit` int(11) DEFAULT NULL,
  `nom_produit` varchar(150) NOT NULL,
  `quantite` decimal(10,2) NOT NULL DEFAULT 1.00,
  `unite` varchar(30) DEFAULT NULL,
  `achete` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `mesure_capteur`
--

CREATE TABLE `mesure_capteur` (
  `id_mesure` int(11) NOT NULL,
  `id_capteur` int(11) NOT NULL,
  `valeur` decimal(10,2) NOT NULL,
  `date_mesure` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `produit`
--

CREATE TABLE `produit` (
  `id_produit` int(11) NOT NULL,
  `nom_produit` varchar(100) NOT NULL,
  `code_barre` varchar(20) DEFAULT NULL,
  `unite_mesure` enum('unite','g','kg','ml','l') NOT NULL DEFAULT 'unite',
  `image` varchar(255) DEFAULT NULL,
  `id_categorie` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `produit`
--

INSERT INTO `produit` (`id_produit`, `nom_produit`, `code_barre`, `unite_mesure`, `image`, `id_categorie`) VALUES
(1, 'Lait demi-écrémé', '3270190021482', 'l', NULL, 1),
(2, 'Yaourt nature', '3017760001234', 'unite', NULL, 1),
(3, 'Fromage râpé', '3256220004567', 'g', NULL, 1),
(4, 'Jus d orange', '3123340001234', 'l', NULL, 2),
(5, 'Eau minérale', '3057640111111', 'l', NULL, 2),
(6, 'Pommes', '2000000000001', 'kg', NULL, 3),
(7, 'Tomates', '2000000000002', 'kg', NULL, 3),
(8, 'Poulet', '2000000000003', 'kg', NULL, 4),
(9, 'Œufs', '3000000000001', 'unite', NULL, 1),
(10, 'Beurre', '3256220009876', 'g', NULL, 1),
(11, 'Pâtes', '3011110001234', 'g', NULL, 5),
(12, 'Crème dessert', '3022220001234', 'unite', NULL, 6);

-- --------------------------------------------------------

--
-- Structure de la table `ticket`
--

CREATE TABLE `ticket` (
  `id_ticket` int(11) NOT NULL,
  `id_utilisateur` int(11) NOT NULL,
  `enseigne` varchar(100) DEFAULT NULL,
  `date_ticket` date DEFAULT NULL,
  `date_scan` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `ticket_ligne`
--

CREATE TABLE `ticket_ligne` (
  `id_ligne` int(11) NOT NULL,
  `id_ticket` int(11) NOT NULL,
  `id_produit` int(11) DEFAULT NULL,
  `nom_produit` varchar(150) NOT NULL,
  `quantite` decimal(10,2) NOT NULL DEFAULT 1.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `utilisateur`
--

CREATE TABLE `utilisateur` (
  `id_utilisateur` int(11) NOT NULL,
  `nom` varchar(50) NOT NULL,
  `prenom` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `mot_de_passe` varchar(250) NOT NULL,
  `role` enum('admin','utilisateur') NOT NULL DEFAULT 'utilisateur',
  `date_inscription` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `alerte`
--
ALTER TABLE `alerte`
  ADD PRIMARY KEY (`id_alerte`),
  ADD KEY `idx_alerte_utilisateur` (`id_utilisateur`),
  ADD KEY `idx_alerte_aliment` (`id_aliment`);

--
-- Index pour la table `aliment`
--
ALTER TABLE `aliment`
  ADD PRIMARY KEY (`id_aliment`),
  ADD KEY `idx_aliment_frigo` (`id_frigo`),
  ADD KEY `idx_aliment_produit` (`id_produit`),
  ADD KEY `idx_aliment_peremption` (`date_peremption`);

--
-- Index pour la table `analyse_ia`
--
ALTER TABLE `analyse_ia`
  ADD PRIMARY KEY (`id_analyse`),
  ADD KEY `idx_analyse_frigo` (`id_frigo`);

--
-- Index pour la table `capteur`
--
ALTER TABLE `capteur`
  ADD PRIMARY KEY (`id_capteur`),
  ADD KEY `idx_capteur_frigo` (`id_frigo`);

--
-- Index pour la table `categorie`
--
ALTER TABLE `categorie`
  ADD PRIMARY KEY (`id_categorie`),
  ADD UNIQUE KEY `uq_categorie_nom` (`nom_categorie`);

--
-- Index pour la table `detection_ia`
--
ALTER TABLE `detection_ia`
  ADD PRIMARY KEY (`id_detection`),
  ADD KEY `idx_detection_analyse` (`id_analyse`),
  ADD KEY `idx_detection_produit` (`id_produit`);

--
-- Index pour la table `frigo`
--
ALTER TABLE `frigo`
  ADD PRIMARY KEY (`id_frigo`),
  ADD KEY `idx_frigo_utilisateur` (`id_utilisateur`);

--
-- Index pour la table `historique_stock`
--
ALTER TABLE `historique_stock`
  ADD PRIMARY KEY (`id_historique`),
  ADD KEY `idx_historique_aliment` (`id_aliment`);

--
-- Index pour la table `liste_courses`
--
ALTER TABLE `liste_courses`
  ADD PRIMARY KEY (`id_liste`),
  ADD KEY `idx_liste_utilisateur` (`id_utilisateur`);

--
-- Index pour la table `liste_courses_item`
--
ALTER TABLE `liste_courses_item`
  ADD PRIMARY KEY (`id_item`),
  ADD KEY `idx_item_liste` (`id_liste`),
  ADD KEY `idx_item_produit` (`id_produit`);

--
-- Index pour la table `mesure_capteur`
--
ALTER TABLE `mesure_capteur`
  ADD PRIMARY KEY (`id_mesure`),
  ADD KEY `idx_mesure_capteur_date` (`id_capteur`,`date_mesure`);

--
-- Index pour la table `produit`
--
ALTER TABLE `produit`
  ADD PRIMARY KEY (`id_produit`),
  ADD UNIQUE KEY `uq_produit_code_barre` (`code_barre`),
  ADD KEY `idx_produit_categorie` (`id_categorie`);

--
-- Index pour la table `ticket`
--
ALTER TABLE `ticket`
  ADD PRIMARY KEY (`id_ticket`),
  ADD KEY `idx_ticket_utilisateur` (`id_utilisateur`);

--
-- Index pour la table `ticket_ligne`
--
ALTER TABLE `ticket_ligne`
  ADD PRIMARY KEY (`id_ligne`),
  ADD KEY `idx_ticket_ligne_ticket` (`id_ticket`),
  ADD KEY `idx_ticket_ligne_produit` (`id_produit`);

--
-- Index pour la table `utilisateur`
--
ALTER TABLE `utilisateur`
  ADD PRIMARY KEY (`id_utilisateur`),
  ADD UNIQUE KEY `uq_utilisateur_email` (`email`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `alerte`
--
ALTER TABLE `alerte`
  MODIFY `id_alerte` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `aliment`
--
ALTER TABLE `aliment`
  MODIFY `id_aliment` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `analyse_ia`
--
ALTER TABLE `analyse_ia`
  MODIFY `id_analyse` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `capteur`
--
ALTER TABLE `capteur`
  MODIFY `id_capteur` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `categorie`
--
ALTER TABLE `categorie`
  MODIFY `id_categorie` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pour la table `detection_ia`
--
ALTER TABLE `detection_ia`
  MODIFY `id_detection` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `frigo`
--
ALTER TABLE `frigo`
  MODIFY `id_frigo` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `historique_stock`
--
ALTER TABLE `historique_stock`
  MODIFY `id_historique` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `liste_courses`
--
ALTER TABLE `liste_courses`
  MODIFY `id_liste` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `liste_courses_item`
--
ALTER TABLE `liste_courses_item`
  MODIFY `id_item` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `mesure_capteur`
--
ALTER TABLE `mesure_capteur`
  MODIFY `id_mesure` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `produit`
--
ALTER TABLE `produit`
  MODIFY `id_produit` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT pour la table `ticket`
--
ALTER TABLE `ticket`
  MODIFY `id_ticket` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `ticket_ligne`
--
ALTER TABLE `ticket_ligne`
  MODIFY `id_ligne` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `utilisateur`
--
ALTER TABLE `utilisateur`
  MODIFY `id_utilisateur` int(11) NOT NULL AUTO_INCREMENT;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `alerte`
--
ALTER TABLE `alerte`
  ADD CONSTRAINT `fk_alerte_aliment` FOREIGN KEY (`id_aliment`) REFERENCES `aliment` (`id_aliment`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_alerte_utilisateur` FOREIGN KEY (`id_utilisateur`) REFERENCES `utilisateur` (`id_utilisateur`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `aliment`
--
ALTER TABLE `aliment`
  ADD CONSTRAINT `fk_aliment_frigo` FOREIGN KEY (`id_frigo`) REFERENCES `frigo` (`id_frigo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_aliment_produit` FOREIGN KEY (`id_produit`) REFERENCES `produit` (`id_produit`) ON UPDATE CASCADE;

--
-- Contraintes pour la table `analyse_ia`
--
ALTER TABLE `analyse_ia`
  ADD CONSTRAINT `fk_analyse_frigo` FOREIGN KEY (`id_frigo`) REFERENCES `frigo` (`id_frigo`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `capteur`
--
ALTER TABLE `capteur`
  ADD CONSTRAINT `fk_capteur_frigo` FOREIGN KEY (`id_frigo`) REFERENCES `frigo` (`id_frigo`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `detection_ia`
--
ALTER TABLE `detection_ia`
  ADD CONSTRAINT `fk_detection_analyse` FOREIGN KEY (`id_analyse`) REFERENCES `analyse_ia` (`id_analyse`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_detection_produit` FOREIGN KEY (`id_produit`) REFERENCES `produit` (`id_produit`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Contraintes pour la table `frigo`
--
ALTER TABLE `frigo`
  ADD CONSTRAINT `fk_frigo_utilisateur` FOREIGN KEY (`id_utilisateur`) REFERENCES `utilisateur` (`id_utilisateur`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `historique_stock`
--
ALTER TABLE `historique_stock`
  ADD CONSTRAINT `fk_historique_aliment` FOREIGN KEY (`id_aliment`) REFERENCES `aliment` (`id_aliment`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `liste_courses`
--
ALTER TABLE `liste_courses`
  ADD CONSTRAINT `fk_liste_utilisateur` FOREIGN KEY (`id_utilisateur`) REFERENCES `utilisateur` (`id_utilisateur`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `liste_courses_item`
--
ALTER TABLE `liste_courses_item`
  ADD CONSTRAINT `fk_item_liste` FOREIGN KEY (`id_liste`) REFERENCES `liste_courses` (`id_liste`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_item_produit` FOREIGN KEY (`id_produit`) REFERENCES `produit` (`id_produit`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Contraintes pour la table `mesure_capteur`
--
ALTER TABLE `mesure_capteur`
  ADD CONSTRAINT `fk_mesure_capteur` FOREIGN KEY (`id_capteur`) REFERENCES `capteur` (`id_capteur`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `produit`
--
ALTER TABLE `produit`
  ADD CONSTRAINT `fk_produit_categorie` FOREIGN KEY (`id_categorie`) REFERENCES `categorie` (`id_categorie`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Contraintes pour la table `ticket`
--
ALTER TABLE `ticket`
  ADD CONSTRAINT `fk_ticket_utilisateur` FOREIGN KEY (`id_utilisateur`) REFERENCES `utilisateur` (`id_utilisateur`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `ticket_ligne`
--
ALTER TABLE `ticket_ligne`
  ADD CONSTRAINT `fk_ticket_ligne_produit` FOREIGN KEY (`id_produit`) REFERENCES `produit` (`id_produit`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_ticket_ligne_ticket` FOREIGN KEY (`id_ticket`) REFERENCES `ticket` (`id_ticket`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
