# Étude des bâtiments de Troyes

## Données

Le jeu de données « Bâtiments de Troyes Champagne Métropole » recense l’ensemble des bâtiments situés dans l’agglomération Troyes Champagne Métropole,
à des fins variées telles que l’urbanisme, l’aménagement du territoire, les analyses foncières ou encore la gestion des services publics.
Il a été publié en août 2024 sur la plateforme data.gouv.fr.

Ce jeu de données provient de l’unification des bases BDTOPO® et BD PARCELLAIRE® de l’IGN.
Il comprend 107 946 observations, avec très peu de valeurs manquantes, ce qui en fait une base fiable et complète pour l’analyse spatiale.

Nous avons choisi ce jeu de données, car il nous semble pertinent d’étudier la répartition géographique des bâtiments dans la ville de Troyes.
Afin d’enrichir notre analyse, nous avons décidé d’y associer un second jeu de données : la Base Adresse Nationale (BAN),
qui recense les adresses géolocalisées des bâtiments sur l’ensemble du territoire français (nous utiliserons uniquement les adresses du département nous concernant).

### Origines et format des données

La base de données bâtiments est disponible [ici](https://www.data.gouv.fr/fr/datasets/batiments-de-troyes-champagne-metropole/).
Ce jeu de données a été commandé par "Troyes Champagne Métropole" et a été mise à jour dernièrement en août 2024 dans le but de regrouper les entités géographiques de la métropole troyenne.
Les données proviennent elles-mêmes de deux sources différentes qui ont été fusionnées : BDTOPO® et BD PARCELLAIRE®, les deux étant produits par IGN.

- La BD PARCELLAIRE® fournit l'information cadastrale numérique, géo-référencée et continue sur l'ensemble du territoire français.
  Elle est réalisée à partir de l'assemblage du plan cadastral dématérialisé. Cependant, elle n'est plus entretenue depuis 2019.
- La BDTOPO® est maintenu depuis 2019, elle couvre de manière cohérente l’ensemble des entités géographiques et administratives du territoire national.

Et la base de données des adresses, un csv par département, est [ici](https://adresse.data.gouv.fr/data/ban/adresses/latest/csv)
(adresses-10.csv que nous avons renommé [adresses_aube.csv](data/adresses_aube.csv)).
Les données proviennent de la BAN.
Ces données sont initialement destiné aux services d'urgence pour qu'ils puissent se diriger.
Elle est aussi destiné au raccord aux réseaux d’énergies ou de communication ou encore pour des analyses cartographiques précises.
Sa constitution est copilotée par l’ANCT, la DINUM et l’IGN.

Les liens, quant à eux sont disponibles sur ce [lien](https://geoservices.ign.fr/ban-plus).
Produits aussi par IGN, c'est une base de données qui permet de lier la BAN à son environnement géographique.

### Les variables

Dans notre étude, nous allons considérer 16 variables.

#### BATI

Nous avons sélectionné 14 variables dans le 1er jeu de données.

| Nom        | Type                | Description                                                                                              |
| ---------- | ------------------- | -------------------------------------------------------------------------------------------------------- |
| NATURE     | nominal             | architecture du bâtiment                                                                                 |
| USAGE1     | nominal             | utilisation du bâtiment (agricole, résidentiel, religieux...)                                            |
| USAGE2     | nominal (optionnel) | utilisation du bâtiment                                                                                  |
| LEGER      | discrète            | structure légère ou pas                                                                                  |
| DATE_APP   | discrète            | date d'apparition/construction (pas toujours présent)                                                    |
| ACQU_PLANI | nominal             | de quelle base provient l'information                                                                    |
| NB_LOGTS   | discrète            | nombre de logements dans le bâtiment                                                                     |
| NB_ETAGES  | discrète            | nombre d'étages du bâtiment                                                                              |
| MAT_MURS   | discrète            | code des matériaux des murs (à croiser avec le csv [materiaux_murs.csv](data/materiaux_murs.csv))        |
| MAT_TOITS  | discrète            | code des matériaux de la toiture (à croiser avec le csv [materiaux_toits.csv](data/materiaux_toits.csv)) |
| HAUTEUR    | continue            | hauteur du bâtiment                                                                                      |
| Z_SOL      | continue            | altitude du sol                                                                                          |
| Z_TOIT     | continue            | altitude du toit                                                                                         |
| ETAT       | nominal             | état du bâtiment (en projet, en construction, en service, en ruine)                                      |

#### ADRESSES

Pour la localisation, nous utiliserons 2 variables : la longitude et la latitude.

| Nom       | Type     | Description    |
| --------- | -------- | -------------- |
| LONGITUDE | continue | coordonnée GPS |
| LATITUDE  | continue | coordonnée GPS |

#### Pourquoi avoir choisi ces variables

Nous avons enlevé les variables qui nous semblaient inutiles ainsi que celles comportant peu de valeurs.
Nous avons aussi enlevé les variables que nous n'avons pas trouvées pertinentes.

## Plan d'analyse

### 1. Comment la ville de Troyes s'est étendue géographiquement au fil des années ?

Il s'agit ici de visualiser l'évolution spatiale de la ville de Troyes au fil du temps.
Pour cela, nous utiliserons la variable `date_app` et les variables de coordonnées géographiques : `latitude` et `longitude`.

Comme types de visualisations à envisager, nous avons :

- Une carte avec les bâtiments colorés selon leur date (période) de construction

Les problèmes potentiels :

- l'absence de date de construction pour certains bâtiments

### 2. Y a-t-il un lien entre les matériaux de construction et les dates de construction ?

Il s'agit ici de déterminer s'il existe une relation entre les variables `date_app`, `mat_murs` et `mat_toits`.
L'objectif est de vérifier si les matériaux de construction des bâtiments varient en fonction des époques.

Pour cela, nous envisageons deux types de visualisations :

- Un line chart pour suivre l'évolution du nombre de bâtiments par matériau au fil du temps :
  
   - L'axe des abscisses représenterait les années
   - L'axe des ordonnées représenterait le nombre de bâtiments
   - Chaque ligne représenterait un matériau

- Un violon plot pour étudier la distribution des dates selon chaque matériau :
  
   - L'axe des abscisses représenterait les années
   - L'axe des ordonnées représenterait les matériaux de construction
  
  Les problèmes potentiels sont :
  
   - un grand nombre de catégories de matériaux (risque de graphe illisible)

### 3. Y a-t-il une corrélation entre les matériaux de construction et la hauteur du bâtiment ?

L'objectif ici est de comprendre si l'évolution des matériaux a un impact sur la hauteur des bâtiments.
Nous aimerions comparer la distribution des hauteurs en fonction des matériaux et vérifier si certains matériaux sont associés à des hauteurs spécifiques.
Nous utiliserions de nouveau les variables `mat_murs` et `mat_toits` que nous mettrions en relation avec la variable `hauteur`.

Pour cela, nous envisageons d'utiliser :

- Un violon plot ou box plot :
   - L'axe des abscisses représentant le type de matériau
   - L'axe des ordonnées représentant la hauteur des bâtiments

### 4. Existe-t-il une relation entre la localisation géographique et l'usage des bâtiments ?

L'objectif ici est de déterminer si certains types d'usage des bâtiments sont spécifiquement localisés dans certaines zones de la ville de Troyes.
Pouvons-nous identifier des zones résidentielles, des zones industrielles et des zones commerciales ?
Nous utiliserons les variables de coordonnées géographiques (`longitude` et `latitude`) et les variables `usage1` et `usage2`.

Pour cela, nous envisageons :

- Une carte avec les bâtiments colorés selon leur usage

Les problèmes potentiels :

- il sera peut-être nécessaire de regrouper les usages

### 5. Y a-t-il une liaison entre la hauteur des bâtiments et leur usage ?

Il s'agit de déterminer s'il existe une relation entre la hauteur d'un bâtiment et son usage.
Les variables utilisées sont : la variable `hauteur` et la variable `usage1`.

Pour cela, nous envisageons d'utiliser :

- Un diagramme à barres empilées pour étudier la répartition des usages :
   - L'axe des abscisses représenterait les tranches de hauteur
   - L'axe des ordonnées représenterait le nombre de bâtiments
   - Chaque barre avec une répartition des usages
