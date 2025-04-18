# Étude des bâtiments de Troyes

## Données

Le jeu de données "Bâtiments de Troyes Champagne Métropole" recense l'ensemble des bâtiments situées dans l'agglomération Troyes Champagne Métropole pour des usages variés tels que l'ubarnisme, l'aménagement du territoire, les analyses foncières et les services publics . Il a été publié en août 2024 sur la plateforme data.gouv.fr. 
Ce jeu de données provient d'une unification des bases BDTOPO et BD PARCELLAIRE de l'IGN et recense 107946 observations avec peu de valeurs manquantes.


Nous avons choisi ce dataset car nous trouvons intéressant d'étudier la repartition géographique des bâtiments dans la ville de Troyes. 
Afin d'enrichir notre étude, nous avons décidé d'associer au jeu de données de bases, un jeu de données aui recense les adresses des bâtiments de Troyes.

### Origines et format des données

La base de données bâtiments est disponible ici: <https://www.data.gouv.fr/fr/datasets/batiments-de-troyes-champagne-metropole/>

Et la base de données des adresses, un csv par département, est ici (adresses-10.csv): <https://adresse.data.gouv.fr/data/ban/adresses/latest/csv>

Les liens, quant à eux sont disponibles sur ce lien: <https://geoservices.ign.fr/ban-plus>

Les données sont stockées au format csv.

### Les variables:

#### BATI

Dans notre étude, nous allons considérer 16 variables.
16 variables avec 2 sous-groupes de 2 variables chacun.

Certains bâtiments ayant un usage double, 2 variables donnent cette information.

| Nom        | Type                | Description                                                                  |
| ---------- | ------------------- | ---------------------------------------------------------------------------- |
| NATURE     | nominal             | architecture du bâtiment                                                     |
| USAGE1     | nominal             | utilisation du bâtiment (agricole, résidentiel, religieux...)                |
| USAGE2     | nominal (optionnel) | utilisation du bâtiment                                                      |
| LEGER      | discrète            | structure légère ?                                                           |
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

La localisation est séparée en 2 données : la longitude et la latitude.

| Nom       | Type     | Description    |
| --------- | -------- | -------------- |
| LONGITUDE | continue | coordonnée GPS |
| LATITUDE  | continue | coordonnée GPS |

#### Pourquoi avoir choisi ces variables

Nous avons enlevé les variables qui nous semblaient inutiles ainsi que celles comportant peu de valeurs.
Nous avons aussi enlevé les variables que nous n'avons pas trouvé pertinentes.



### Sous groupes des données

## Plan d'analyse

Les premières questions :

- Comment Troyes s'est étendu au fil des années ?
- Y a-t-il un lien entre les matériaux et les dates de construction ?
- Corrélation date, matériaux et hauteur ?
- Une liaison entre la géographie et l'usage du bâtiment ?
- Y a-t-il une liaison entre hauteur et usage du bâtiment ?

Les informations que l'on peut obtenir :

- Une carte représentative de l'âge des bâtiments

Quelles variables comparer :

Qu'est ce qui pourrait poser problèmes : Potentiel de bruit important.
