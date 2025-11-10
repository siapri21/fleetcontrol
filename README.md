# FleetControl  
**Projet de gestion de flotte automobile — TP de base de données**

---

##  Contexte
FleetControl est une application de gestion de flotte permettant de suivre les véhicules, leurs trajets, les conducteurs, ainsi que la maintenance et les anomalies techniques.  
Ce projet a été réalisé dans le cadre du module **Base de données** afin de concevoir un modèle relationnel complet et évolutif sous **MySQL**.

---

##  Objectifs du projet
- Concevoir et modéliser une base de données normalisée.  
- Assurer le suivi des véhicules et de leurs trajets.  
- Gérer les interventions techniques et les pièces associées.  
- Ajouter un module d’anomalies dans la version finale.  
- Mettre en œuvre une gestion de version via Git et GitHub.

---

## Structure du dépôt
FLEETCONTROL/
│
├── sql/
│ ├── fleetcontrol_init.sql # Base initiale (sans anomalies)
│ └── fleetcontrol_final.sql # Version finale (avec anomalies)
│
├── docs/
│ ├── mcd.png # MCD (à ajouter)
│ └── mld.png # MLD (à ajouter)
│
└── README.md # Documentation du projet


---

## Description technique

### **Version initiale (`fleetcontrol_init.sql`)**
Tables principales :
- `categorie` : type de véhicule  
- `vehicule` : informations du parc  
- `conducteur` : chauffeurs rattachés aux véhicules  
- `affectation` : lien véhicule/conducteur  
- `trajet` : historique des trajets  
- `technicien`, `fournisseur`, `intervention`, `piece`, `utilise` : maintenance et logistique  

Chaque table est reliée par des **clés étrangères** avec suppression en cascade pour garder la cohérence des données.

### **Version finale (`fleetcontrol_final.sql`)**
Ajout de la table :
```sql
CREATE TABLE anomalie (
    id_anomalie INT AUTO_INCREMENT PRIMARY KEY,
    id_vehicule INT NOT NULL,
    date DATE NOT NULL,
    description TEXT NOT NULL,
    cause VARCHAR(255),
    impact_financier DECIMAL(10,2),
    FOREIGN KEY (id_vehicule) REFERENCES vehicule(id_vehicule) ON DELETE CASCADE
);
