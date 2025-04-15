# Introduction

## Données

107946 observations avec peu de valeurs manquantes.
16 variables avec 2 sous-groupes de 2 variables chacun.

### Les variables:

#### BATI

-   NATURE : nominal, architecture du bâtiment
-   USAGE (certains batiments ayant un usage double, 2 variables donnes cette information) :
    -   USAGE1 : nominal, utilisation du bâtiment (agricole, résidentiel, religieux...)
    -   USAGE2 : nominal (optionnel), utilisation du bâtiment
-   LEGER : booléen, structure légère ?
-   DATE_APP : date d'apparition/construction (pas toujours présent)
-   ACQU_PLANI : nominal, de quelle base provient l'information
-   NB_LOGTS : discrète, nombre de logements
-   NB_ETAGES : discrète, nombre d'étages
-   MAT_MURS : discrète, code des matériaux des murs (à croiser avec le csv materiaux_murs.csv)
-   MAT_TOITS : discrète, code des matériaux de la toiture (à croiser avec le csv materiaux_toits.csv)
-   HAUTEUR : continue, hauteur
-   Z_SOL : continue, altitude du sol
-   Z_TOIT : continue, altitude du toit
-   ETAT : nominal, état du bâtiment (en projet, en construction, en service, en ruine)

#### ADRESSES

-   LOCALISATION (la localisation est séparé en 2 données: la longitude et la latitude):
    -   LONGITUDE : coordonnée GPS
    -   LATITUDE : coordonnée GPS

#### Pourquoi avoir choisi ces variables

Nous avons enlevé les variables qui nous semblaient inutiles ainsi que celles comportant peu de valeurs.
Nous avons aussi enlevé les variables que nous n'avons pas trouvé pertinentes.

### Origines et format des données

La base de données bâtiments est disponible ici: <https://www.data.gouv.fr/fr/datasets/batiments-de-troyes-champagne-metropole/>

Et la base de données des adresses, un csv par département, est ici (adresses-10.csv): <https://adresse.data.gouv.fr/data/ban/adresses/latest/csv>

Les liens, quant à eux sont disponibles sur ce lien: <https://geoservices.ign.fr/ban-plus>

Les données sont stockées au format csv.

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
