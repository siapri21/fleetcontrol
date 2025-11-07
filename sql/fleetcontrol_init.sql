-- FleetControl Initial Database Schema
-- MySQL Script for Initial Model

CREATE DATABASE IF NOT EXISTS fleetcontrol;
USE fleetcontrol;

-- Table: categorie
CREATE TABLE categorie (
    id_categorie INT AUTO_INCREMENT PRIMARY KEY,
    nom_categorie VARCHAR(50) NOT NULL UNIQUE
);

-- Table: vehicule
CREATE TABLE vehicule (
    id_vehicule INT AUTO_INCREMENT PRIMARY KEY,
    id_categorie INT NOT NULL,
    date_achat DATE NOT NULL,
    kilometrage INT DEFAULT 0,
    statut ENUM('actif', 'maintenance', 'reforme', 'vendu') DEFAULT 'actif',
    site VARCHAR(100),
    FOREIGN KEY (id_categorie) REFERENCES categorie(id_categorie) ON DELETE CASCADE
);

-- Table: conducteur
CREATE TABLE conducteur (
    id_conducteur INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(50) NOT NULL,
    prenom VARCHAR(50) NOT NULL,
    date_naissance DATE
);

-- Table: affectation
CREATE TABLE affectation (
    id_affectation INT AUTO_INCREMENT PRIMARY KEY,
    id_vehicule INT NOT NULL,
    id_conducteur INT NOT NULL,
    type_affectation ENUM('fixe', 'partage') DEFAULT 'partage',
    date_debut DATE NOT NULL,
    date_fin DATE,
    FOREIGN KEY (id_vehicule) REFERENCES vehicule(id_vehicule) ON DELETE CASCADE,
    FOREIGN KEY (id_conducteur) REFERENCES conducteur(id_conducteur) ON DELETE CASCADE
);

-- Table: trajet
CREATE TABLE trajet (
    id_trajet INT AUTO_INCREMENT PRIMARY KEY,
    id_vehicule INT NOT NULL,
    id_conducteur INT NOT NULL,
    date_debut DATETIME NOT NULL,
    date_fin DATETIME,
    mission VARCHAR(255),
    cout DECIMAL(10,2),
    FOREIGN KEY (id_vehicule) REFERENCES vehicule(id_vehicule) ON DELETE CASCADE,
    FOREIGN KEY (id_conducteur) REFERENCES conducteur(id_conducteur) ON DELETE CASCADE
);

-- Table: fournisseur
CREATE TABLE fournisseur (
    id_fournisseur INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    adresse VARCHAR(255)
);

-- Table: technicien
CREATE TABLE technicien (
    id_technicien INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    type ENUM('interne', 'externe') DEFAULT 'interne',
    id_fournisseur INT,
    FOREIGN KEY (id_fournisseur) REFERENCES fournisseur(id_fournisseur) ON DELETE SET NULL
);

-- Table: intervention
CREATE TABLE intervention (
    id_intervention INT AUTO_INCREMENT PRIMARY KEY,
    id_vehicule INT NOT NULL,
    id_technicien INT NOT NULL,
    date DATE NOT NULL,
    type VARCHAR(50),
    description TEXT,
    cout DECIMAL(10,2),
    FOREIGN KEY (id_vehicule) REFERENCES vehicule(id_vehicule) ON DELETE CASCADE,
    FOREIGN KEY (id_technicien) REFERENCES technicien(id_technicien) ON DELETE CASCADE
);

-- Table: piece
CREATE TABLE piece (
    id_piece INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    stock INT DEFAULT 0
);

-- Table: utilise (many-to-many between intervention and piece)
CREATE TABLE utilise (
    id_intervention INT NOT NULL,
    id_piece INT NOT NULL,
    quantite INT NOT NULL DEFAULT 1,
    PRIMARY KEY (id_intervention, id_piece),
    FOREIGN KEY (id_intervention) REFERENCES intervention(id_intervention) ON DELETE CASCADE,
    FOREIGN KEY (id_piece) REFERENCES piece(id_piece) ON DELETE CASCADE
);
