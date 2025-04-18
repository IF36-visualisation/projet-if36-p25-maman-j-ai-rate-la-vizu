# Étude des bâtiments de Troyes

## Données

Le jeu de données « Bâtiments de Troyes Champagne Métropole » recense l’ensemble des bâtiments situés dans l’agglomération Troyes Champagne Métropole, à des fins variées telles que l’urbanisme, l’aménagement du territoire, les analyses foncières ou encore la gestion des services publics. Il a été publié en août 2024 sur la plateforme data.gouv.fr.

Ce jeu de données provient de l’unification des bases BDTOPO® et BD PARCELLAIRE® de l’IGN. Il comprend 107 946 observations, avec très peu de valeurs manquantes, ce qui en fait une base fiable et complète pour l’analyse spatiale.

Nous avons choisi ce jeu de données car il nous semble pertinent d’étudier la répartition géographique des bâtiments dans la ville de Troyes.
Afin d’enrichir notre analyse, nous avons décidé d’y associer un second jeu de données : la Base Adresse Nationale (BAN),  qui recense les adresses géolocalisées des bâtiments sur l’ensemble du territoire français (on utilisera uniquement les adresses du département nous concernant). 

### Origines et format des données

La base de données bâtiments est disponible ici: <https://www.data.gouv.fr/fr/datasets/batiments-de-troyes-champagne-metropole/>

Et la base de données des adresses, un csv par département, est ici (adresses-10.csv): <https://adresse.data.gouv.fr/data/ban/adresses/latest/csv>

Les liens, quant à eux sont disponibles sur ce lien: <https://geoservices.ign.fr/ban-plus>

Les données sont stockées au format csv.

### Les variables:
Dans notre étude, nous allons considérer 16 variables.

#### BATI

Nous avons sélectionné 14 variables dans le 1er jeu de données.

| Nom        | Type                | Description                                                                  |
| ---------- | ------------------- | ---------------------------------------------------------------------------- |
| NATURE     | nominal             | architecture du bâtiment                                                     |
| USAGE1     | nominal             | utilisation du bâtiment (agricole, résidentiel, religieux...)                |
| USAGE2     | nominal (optionnel) | utilisation du bâtiment                                                      |
| LEGER      | discrète            | structure légère ou pas                                                         |
| DATE_APP   | discrète            | date d'apparition/construction (pas toujours présent)                        |
| ACQU_PLANI | nominal             | de quelle base provient l'information                                        |
| NB_LOGTS   | discrète            | nombre de logements dans le bâtiment                                         |
| NB_ETAGES  | discrète            | nombre d'étages du bâtiment                                                  |
| MAT_MURS   | discrète            | code des matériaux des murs (à croiser avec le csv materiaux_murs.csv)       |
| MAT_TOITS  | discrète            | code des matériaux de la toiture (à croiser avec le csv materiaux_toits.csv) |
| HAUTEUR    | continue            | hauteur du bâtiment                                                          |
| Z_SOL      | continue            | altitude du sol                                                              |
| Z_TOIT     | continue            | altitude du toit                                                             |
| ETAT       | nominal             | état du bâtiment (en projet, en construction, en service, en ruine)          |

#### ADRESSES


Pour la localisation, nous utiliserons 2 variables : la longitude et la latitude.

| Nom       | Type     | Description    |
| --------- | -------- | -------------- |
| LONGITUDE | continue | coordonnée GPS |
| LATITUDE  | continue | coordonnée GPS |

#### Pourquoi avoir choisi ces variables

Nous avons enlevé les variables qui nous semblaient inutiles ainsi que celles comportant peu de valeurs.
Nous avons aussi enlevé les variables que nous n'avons pas trouvé pertinentes.




## Plan d'analyse

1- Comment  la ville de Troyes s'est étendue géographiquement au fil des années?

   Il s'agit ici de visualiser l'évolution spatiale  de la ville de Troyes au fil du temps.
   Pour cela, on utilisera la variable date_app et les variables de coordonnées géographiques: latitude et longitude.
   
   Comme types de visualisations à envisager , on a:
    - Une carte avec les bâtiments colorés selon leur date(période) de construction

   Les problèmes potentiels:
    -  l'absence de date de construction pour certains bâtiments
  
2- Y a-t-il un lien entre les matériaux de construction et les dates de construction ?
  
   Il s'agit ici de déterminer s'il existe une relation entre les variables date_app, mat_murs et mat_toits. L'objectif est de vérifier si les matériaux de construction des bâtiments varient en fonction des époques.
   
  Pour cela, nous envisageons deux types de visualisations :
  - Un line Chart pour suivre l'évolution du nombre de bâtiments par matériau au fil du temps.
        -> L'axe des abscisses représenterait les années
        -> L'axe des ordonnées représenterait le nombre de bâtiments
        -> Chaque ligne représenterait un matériau.
    
  - Un violon plot pour étudier la distribution des dates selon chaque matériau.
        -> L'axe des abscisses représenterait les années
        -> L'axe des ordonnées représenterait les matériaux de construction.

  Les problèmes potentiels sont:
  - un grand nombre de catégories de matériaux (risque de graphe illisible).
    
    
3- Y a-t-il une corrélation entre les matériaux de constructon et la hauteur du bâtiment?

   L'objectif ici est de comprendre si l'évolution des matériaux a un impact sur la hauteur des bâtiments. On aimerait comparer la distribution des hauteurs en fonction des matériaux et vérifier si certains matériaux sont associés à des hauteurs spécifiques.

   Pour cela, on envisage d'utiliser:
    - Un violon plot ou box plot
        -> L'axe des abscisses représentant le type de matériau
        -> L'axe des ordonnées représentant la hauteur des bâtiments
   
      
4-  Existe-t-il une relation entre la localisation géographique et l'usage des bâtiments?
   
   L'objectif ici est de déterminer si certains types d'usage des bâtiments sont spécifiquement localisés dans certaines zones de la ville de Troyes. Peut-on identifier des zones résidentielles, des zones industrielles, des zones commerciales?
   On utilisera les variables de coordonnées géographiques (longitude et latitude) et les variables usage1 et usage2.
   
   Pour cela, nous envisageons:
     -  Une carte avec les bâtiments colorés selon leur usage
     
   Les problèmes potentiels:
     - il sera peut-être nécessaire de regrouper les usages
    

5- Y a-t-il une liaison entre la hauteur des bâtiments et leur usage ?
 
   Il s'agit de déterminer s'il existe une relation entre la hauteur d'un bâtiment et son usage.
   Les variables utilisées sont: la variable hauteur et la variable usage1
   
   Pour cela, nous envisageons d'utiliser:
    - Un diagramme à barres empilées pour étudier la répartition des usages
        -> L'axe des abscisses représenterait les tranches de hauteur
        -> L'axe des ordonnées représenterait le nombre de bâtiments
        -> Chaque barre avec une répartition des usages
 
   


