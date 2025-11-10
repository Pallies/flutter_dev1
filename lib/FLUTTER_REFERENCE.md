# 📚 Guide de Référence Flutter - Par Widgets et Concepts

> Guide organisé par widgets et concepts pour faciliter la recherche d'informations spécifiques.

---

## 📑 Table des Matières

1. [Widgets de Base](#widgets-de-base)
2. [Widgets de Layout](#widgets-de-layout)
3. [Widgets d'Interaction](#widgets-dinteraction)
4. [Widgets de Liste](#widgets-de-liste)
5. [Widgets de Navigation](#widgets-de-navigation)
6. [Widgets de Formulaire](#widgets-de-formulaire)
7. [Widgets de Thème](#widgets-de-thème)
8. [Widgets d'Images](#widgets-dimages)
9. [Concepts Fondamentaux](#concepts-fondamentaux)
10. [Gestion d'État](#gestion-détat)
11. [Techniques Avancées](#techniques-avancées)
12. [Packages Externes](#packages-externes)

---

# 📦 Widgets de Base

## MaterialApp
**Rôle :** Widget racine pour applications Material Design  


**Propriétés principales :**
- `home` : Widget de démarrage
- `theme` : Thème clair
- `darkTheme` : Thème sombre
- `themeMode` : Mode du thème (system, light, dark)

**Exemple :**
```dart
MaterialApp(
  theme: ThemeData().copyWith(colorScheme: kColorScheme),
  darkTheme: ThemeData().copyWith(colorScheme: kColorSchemeDark),
  themeMode: ThemeMode.system,
  home: Scaffold(...),
)
```

**Cas d'usage :**
- Point d'entrée de l'application
- Configuration des thèmes globaux
- Navigation de base

---

## Scaffold
**Rôle :** Structure de base d'une page Material Design  


**Propriétés principales :**
- `appBar` : Barre d'application en haut
- `body` : Contenu principal
- `backgroundColor` : Couleur de fond
- `floatingActionButton` : Bouton flottant

**Exemple :**
```dart
Scaffold(
  appBar: AppBar(
    title: Text('Mon App'),
    actions: [IconButton(...)],
  ),
  body: Container(...),
  backgroundColor: Colors.blue,
)
```

**Cas d'usage :**
- Structure de base de chaque écran
- Gestion de l'AppBar
- Support du SnackBar et Drawer

---

## Text
**Rôle :** Affichage de texte  


**Propriétés principales :**
- `style` : Style du texte (TextStyle)
- `textAlign` : Alignement du texte
- `maxLines` : Nombre de lignes max
- `overflow` : Comportement débordement

**Exemple :**
```dart
Text(
  'Hello Flutter',
  style: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  ),
  textAlign: TextAlign.center,
)
```

**Avec Google Fonts :**
```dart
Text(
  'Hello Flutter',
  style: GoogleFonts.lato(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  ),
)
```

**Cas d'usage :**
- Affichage de titres, labels, descriptions
- Messages utilisateur

---

## Image.asset
**Rôle :** Affichage d'images locales  
**Utilisé dans :** Part 1, 2  

**Propriétés principales :**
- `width` / `height` : Dimensions
- `color` : Filtre de couleur
- `fit` : Mode d'ajustement

**Exemple :**
```dart
Image.asset(
  'assets/images/dice/dice-1.png',
  width: 200,
  height: 200,
)
```

**Avec filtre de couleur :**
```dart
Image.asset(
  'assets/images/quiz/logo.png',
  width: 300,
  color: Color.fromARGB(125, 255, 255, 255),
)
```

**Cas d'usage :**
- Affichage d'images du projet
- Logos, icônes, illustrations

---

## Icon
**Rôle :** Affichage d'icônes Material  
**Utilisé dans :** Part 2, 3  

**Propriétés principales :**
- `size` : Taille de l'icône
- `color` : Couleur de l'icône

**Exemple :**
```dart
Icon(
  Icons.add,
  size: 30,
  color: Colors.white,
)
```

**Avec thème :**
```dart
Icon(
  expense.icon,
  color: Theme.of(context).colorScheme.primary,
)
```

**Cas d'usage :**
- Boutons avec icônes
- Indicateurs visuels
- Navigation

---

# 📐 Widgets de Layout

## Container
**Rôle :** Widget de mise en page polyvalent  


**Propriétés principales :**
- `decoration` : Décoration (BoxDecoration)
- `padding` : Espace intérieur
- `margin` : Espace extérieur
- `width` / `height` : Dimensions
- `child` : Widget enfant

**Exemple :**
```dart
Container(
  decoration: BoxDecoration(
    gradient: LinearGradient(
      colors: [Colors.blue, Colors.purple],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    borderRadius: BorderRadius.circular(10),
  ),
  padding: EdgeInsets.all(20),
  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  child: Text('Hello'),
)
```

**Cas d'usage :**
- Fond avec gradient
- Espacement personnalisé
- Conteneur stylisé

---

## Column
**Rôle :** Organise les widgets verticalement  


**Propriétés principales :**
- `mainAxisAlignment` : Alignement vertical
- `crossAxisAlignment` : Alignement horizontal
- `mainAxisSize` : Taille (min, max)
- `children` : Liste de widgets

**Exemple :**
```dart
Column(
  mainAxisSize: MainAxisSize.min,
  mainAxisAlignment: MainAxisAlignment.center,
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Text('Titre'),
    SizedBox(height: 10),
    Text('Description'),
  ],
)
```

**Cas d'usage :**
- Empilement vertical d'éléments
- Formulaires
- Listes d'informations

---

## Row
**Rôle :** Organise les widgets horizontalement  
**Utilisé dans :** Part 2, 3  

**Propriétés principales :**
- `mainAxisAlignment` : Alignement horizontal
- `crossAxisAlignment` : Alignement vertical
- `children` : Liste de widgets

**Exemple :**
```dart
Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [
    Icon(Icons.star),
    Text('5.0'),
    Spacer(),
    Icon(Icons.favorite),
  ],
)
```

**Cas d'usage :**
- Alignement horizontal d'éléments
- En-têtes avec icônes
- Barres d'actions

---

## Center
**Rôle :** Centre son enfant  


**Exemple :**
```dart
Center(
  child: Text('Centré'),
)
```

**Cas d'usage :**
- Centrer un widget
- Écran de chargement
- Messages vides

---

## Expanded
**Rôle :** Prend tout l'espace disponible dans Row/Column  
**Utilisé dans :** Part 2, 3  

**Propriétés principales :**
- `flex` : Proportion de l'espace
- `child` : Widget enfant

**Exemple :**
```dart
Row(
  children: [
    Expanded(
      flex: 2,
      child: Text('Prend 2/3'),
    ),
    Expanded(
      flex: 1,
      child: Text('Prend 1/3'),
    ),
  ],
)
```

**Cas d'usage :**
- Distribution d'espace dans Row/Column
- Éviter les débordements de texte
- Layouts responsives

---

## Spacer
**Rôle :** Prend tout l'espace vide  
**Utilisé dans :** Part 3  

**Exemple :**
```dart
Row(
  children: [
    Text('Gauche'),
    Spacer(),
    Text('Droite'),
  ],
)
```

**Cas d'usage :**
- Espacer deux widgets aux extrémités
- Alternative à Expanded vide

---

## SizedBox
**Rôle :** Espace ou contrainte de taille fixe  


**Propriétés principales :**
- `width` / `height` : Dimensions
- `child` : Widget enfant

**Exemple :**
```dart
// Espacement
SizedBox(height: 20)

// Largeur maximale
SizedBox(
  width: double.infinity,
  child: Column(...),
)
```

**Cas d'usage :**
- Espacement entre widgets
- Contrainte de taille
- Prendre toute la largeur

---

## Padding
**Rôle :** Ajoute un espace intérieur  
**Utilisé dans :** Part 2, 3  

**Exemple :**
```dart
Padding(
  padding: EdgeInsets.all(16),
  child: Text('Avec padding'),
)
```

**EdgeInsets variants :**
```dart
// Tous les côtés
EdgeInsets.all(20)

// Symétrique
EdgeInsets.symmetric(horizontal: 50, vertical: 10)

// Spécifique
EdgeInsets.only(top: 10, bottom: 20)

// LTRB
EdgeInsets.fromLTRB(20, 10, 20, 10)
```

**Cas d'usage :**
- Espace intérieur personnalisé
- Marges internes

---

## Card
**Rôle :** Carte Material Design avec élévation  
**Utilisé dans :** Part 3  

**Propriétés principales :**
- `margin` : Marge extérieure
- `elevation` : Hauteur de l'ombre
- `color` : Couleur de fond
- `child` : Contenu

**Exemple :**
```dart
Card(
  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  child: Padding(
    padding: EdgeInsets.all(20),
    child: Column(...),
  ),
)
```

**Cas d'usage :**
- Items de liste
- Cartes d'information
- Conteneurs groupés

---

## SingleChildScrollView
**Rôle :** Rend son contenu défilable  
**Utilisé dans :** Part 2, 3  

**Exemple :**
```dart
SingleChildScrollView(
  child: Column(
    children: [
      // Beaucoup de contenu
    ],
  ),
)
```

**Cas d'usage :**
- Éviter les débordements
- Formulaires longs
- Contenu dynamique

---

## FractionallySizedBox
**Rôle :** Dimensionne en fraction du parent  
**Utilisé dans :** Part 3  

**Propriétés principales :**
- `heightFactor` : Fraction de la hauteur (0.0 à 1.0)
- `widthFactor` : Fraction de la largeur
- `child` : Widget enfant

**Exemple :**
```dart
FractionallySizedBox(
  heightFactor: 0.7, // 70% de la hauteur parent
  child: Container(color: Colors.blue),
)
```

**Cas d'usage :**
- Barres de progression
- Graphiques
- Layouts proportionnels

---

## DecoratedBox
**Rôle :** Applique une décoration (plus léger que Container)  
**Utilisé dans :** Part 3  

**Exemple :**
```dart
DecoratedBox(
  decoration: BoxDecoration(
    shape: BoxShape.rectangle,
    borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
    color: Colors.blue,
  ),
)
```

**Cas d'usage :**
- Décoration sans Container complet
- Performance optimisée

---

# 🎯 Widgets d'Interaction

## ElevatedButton
**Rôle :** Bouton avec élévation  
**Utilisé dans :** Part 2, 3  

**Propriétés principales :**
- `onPressed` : Callback au clic
- `style` : Style personnalisé
- `child` : Contenu (texte, icône)

**Exemple :**
```dart
ElevatedButton(
  onPressed: () => print('Cliqué'),
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.blue,
    foregroundColor: Colors.white,
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5),
    ),
  ),
  child: Text('Cliquez-moi'),
)
```

**Cas d'usage :**
- Actions principales
- Boutons de confirmation

---

## OutlinedButton / OutlinedButton.icon
**Rôle :** Bouton avec bordure  
**Utilisé dans :** Part 1, 2  

**Exemple :**
```dart
OutlinedButton(
  onPressed: rollDice,
  style: OutlinedButton.styleFrom(
    foregroundColor: Colors.white,
    side: BorderSide(color: Colors.white),
  ),
  child: Text('Roll Dice'),
)

// Avec icône
OutlinedButton.icon(
  icon: Icon(Icons.arrow_right),
  label: Text('Start'),
  onPressed: () {},
)
```

**Cas d'usage :**
- Actions secondaires
- Boutons discrets avec icône

---

## TextButton / TextButton.icon
**Rôle :** Bouton de texte simple  
**Utilisé dans :** Part 2, 3  

**Exemple :**
```dart
TextButton(
  onPressed: () {},
  child: Text('Cancel'),
)

// Avec icône
TextButton.icon(
  icon: Icon(Icons.refresh),
  label: Text('Restart'),
  onPressed: () {},
)
```

**Cas d'usage :**
- Actions tertiaires
- Dialogues
- Liens

---

## IconButton
**Rôle :** Bouton icône uniquement  
**Utilisé dans :** Part 3  

**Exemple :**
```dart
IconButton(
  icon: Icon(Icons.add),
  onPressed: () {},
  color: Colors.white,
)
```

**Cas d'usage :**
- Actions dans AppBar
- Boutons compacts

---

## Dismissible
**Rôle :** Widget glissable pour actions swipe  
**Utilisé dans :** Part 3  

**Propriétés principales :**
- `key` : Clé unique (ValueKey)
- `direction` : Direction du swipe
- `onDismissed` : Callback après swipe
- `background` : Widget affiché derrière
- `child` : Contenu

**Exemple :**
```dart
Dismissible(
  key: ValueKey(item.id),
  direction: DismissDirection.endToStart,
  onDismissed: (direction) {
    removeItem(item);
  },
  background: Container(
    color: Colors.red,
    alignment: Alignment.centerRight,
    padding: EdgeInsets.only(right: 20),
    child: Icon(Icons.delete, color: Colors.white),
  ),
  child: ListTile(title: Text(item.title)),
)
```

**Cas d'usage :**
- Suppression par swipe
- Actions glissables
- Gestion de liste interactive

---

## CircleAvatar
**Rôle :** Avatar circulaire  
**Utilisé dans :** Part 2  

**Propriétés principales :**
- `radius` : Rayon du cercle
- `backgroundColor` : Couleur de fond
- `child` : Contenu (texte, icône)

**Exemple :**
```dart
CircleAvatar(
  radius: 20,
  backgroundColor: Colors.blue,
  child: Text('1', style: TextStyle(color: Colors.white)),
)
```

**Cas d'usage :**
- Numérotation
- Avatars utilisateur
- Badges

---
## InkWell
**Rôle :** Zone cliquable avec effet d'encre Material Design  
**Utilisé dans :** Part 4  

**Propriétés principales :**
- `onTap` : Callback au clic
- `splashColor` : Couleur de l'effet d'encre
- `borderRadius` : Arrondi des bords
- `child` : Widget enfant

**Exemple :**
```dart
InkWell(
  onTap: () => print('Cliqué'),
  splashColor: Theme.of(context).colorScheme.primary,
  borderRadius: BorderRadius.circular(15),
  child: Container(
    padding: EdgeInsets.all(15),
    child: Text('Cliquez-moi'),
  ),
)
```

**Cas d'usage :**
- Zones cliquables personnalisées
- Effet visuel Material Design
- Alternative à GestureDetector avec feedback visuel

---

## GridView
**Rôle :** Affichage en grille  
**Utilisé dans :** Part 4  

**Propriétés principales :**
- `gridDelegate` : Configuration de la grille
- `children` : Liste de widgets

**GridDelegate principal :**
```dart
SliverGridDelegateWithFixedCrossAxisCount(
  crossAxisCount: 2,          // Nombre de colonnes
  childAspectRatio: 3 / 2,    // Ratio largeur/hauteur
  crossAxisSpacing: 20,       // Espace horizontal
  mainAxisSpacing: 20,        // Espace vertical
)
```

**Exemple :**
```dart
GridView(
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    childAspectRatio: 3 / 2,
    crossAxisSpacing: 20,
    mainAxisSpacing: 20,
  ),
  children: [
    ...items.map((item) => ItemWidget(item: item)),
  ],
)
```

**Cas d'usage :**
- Galeries d'images
- Catégories
- Grilles de produits

**Utilisé dans :** Part 2, 3, 4  

## SwitchListTile
**Rôle :** Switch avec titre et sous-titre intégrés  
**Utilisé dans :** Part 4  

**Utilisé dans :** Part 3, 4  
// Fermer et retourner une valeur
Navigator.pop(context, myData);

- `value` : État du switch (bool)
- `onChanged` : Callback au changement
- `title` : Titre principal
- `subtitle` : Description secondaire
- `activeThumbColor` : Couleur quand activé

// Aller vers un écran et attendre un résultat
final result = await Navigator.push<MyDataType>(
  context,
  MaterialPageRoute(builder: (ctx) => NewScreen()),
);

if (result != null) {
  // Utiliser le résultat
}
- `contentPadding` : Espacement intérieur

**Exemple :**
```dart
SwitchListTile(
- Transfert de données bidirectionnel

---

## BottomNavigationBar
**Rôle :** Barre de navigation par onglets en bas  
**Utilisé dans :** Part 4  

**Propriétés principales :**
- `items` : Liste de BottomNavigationBarItem
- `currentIndex` : Index de l'onglet actif
- `onTap` : Callback au changement d'onglet

**Exemple :**
```dart
Scaffold(
  body: pages[_selectedIndex],
  bottomNavigationBar: BottomNavigationBar(
    onTap: (index) {
      setState(() {
        _selectedIndex = index;
      });
    },
    currentIndex: _selectedIndex,
    items: const [
      BottomNavigationBarItem(
        icon: Icon(Icons.restaurant),
        label: 'Catégories',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.star),
        label: 'Favoris',
      ),
    ],
  ),
)
```

**Cas d'usage :**
- Navigation principale entre 2-5 sections
- Navigation persistante
- Accès rapide aux sections principales

---

## Drawer
**Rôle :** Menu latéral de navigation  
**Utilisé dans :** Part 4  

**Propriétés principales :**
- `child` : Contenu du drawer (généralement Column)

**Exemple :**
```dart
Scaffold(
  drawer: Drawer(
    child: Column(
      children: [
        DrawerHeader(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.blueAccent],
            ),
          ),
          child: Text('Menu'),
        ),
        ListTile(
          leading: Icon(Icons.home),
          title: Text('Accueil'),
          onTap: () {
            Navigator.pop(context); // Ferme le drawer
            // Navigation
          },
        ),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text('Paramètres'),
          onTap: () => _navigateToSettings(),
        ),
      ],
    ),
  ),
)
```

**Cas d'usage :**
- Menu de navigation secondaire
- Paramètres et options
- Informations utilisateur

---

## DrawerHeader
**Rôle :** En-tête stylisé pour Drawer  
**Utilisé dans :** Part 4  

**Propriétés principales :**
- `decoration` : Décoration de fond
- `padding` : Espacement intérieur
- `child` : Contenu de l'en-tête

**Exemple :**
```dart
DrawerHeader(
  padding: EdgeInsets.all(20),
  decoration: BoxDecoration(
    gradient: LinearGradient(
      colors: [
        Theme.of(context).colorScheme.primary,
        Theme.of(context).colorScheme.primary.withAlpha(190),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  ),
  child: Row(
    children: [
      Icon(Icons.fastfood, size: 48, color: Colors.white),
      SizedBox(width: 18),
      Text('App Name', style: TextStyle(color: Colors.white)),
    ],
  ),
)
```

**Cas d'usage :**
- Logo et nom d'application
- Informations utilisateur
- Design cohérent du drawer

---

## PopScope
**Rôle :** Intercepter et gérer le bouton retour  
**Utilisé dans :** Part 4  

**Propriétés principales :**
- `canPop` : Autoriser le retour automatique
- `onPopInvokedWithResult` : Callback avant le retour
- `child` : Widget enfant

**Exemple :**
```dart
PopScope(
  canPop: false, // Empêche le retour automatique
  onPopInvokedWithResult: (bool didPop, dynamic result) {
    if (didPop) return;
    
    // Logique personnalisée (ex: sauvegarder des données)
    Navigator.of(context).pop({
      'data': myData,
      'modified': true,
    });
  },
  child: Scaffold(
    body: MyFormWidget(),
  ),
)
```

**Cas d'usage :**
- Retourner des données à l'écran parent
- Demander confirmation avant de quitter
- Sauvegarder avant de fermer
  value: _isEnabled,
  title: Text('Sans Gluten'),
  subtitle: Text('Seulement les repas sans gluten'),
  activeThumbColor: Theme.of(context).colorScheme.secondary,
  contentPadding: EdgeInsets.symmetric(horizontal: 34, vertical: 8),
  onChanged: (value) {
    setState(() {
      _isEnabled = value;
    });
  },
)
```

**Cas d'usage :**
- Paramètres et filtres
- Options avec description
- Configuration d'application

---


# 📋 Widgets de Liste

## ListView.builder
**Utilisé dans :** Part 3, 4  
**Utilisé dans :** Part 3  

**Propriétés principales :**
- `itemBuilder` : Fonction de construction
- `itemCount` : Nombre d'items
- `scrollDirection` : Direction du scroll

**Exemple :**
```dart
ListView.builder(
  itemCount: items.length,
  itemBuilder: (context, index) {
    return ListTile(
      title: Text(items[index].title),
    );
  },
)
```

**Cas d'usage :**
- Listes longues
- Performance optimisée
- Données dynamiques

---

# 🚀 Widgets de Navigation

## AppBar
**Rôle :** Barre d'application en haut  
**Utilisé dans :** Part 3  

**Propriétés principales :**
- `title` : Titre de l'écran
- `actions` : Widgets à droite
- `leading` : Widget à gauche
- `backgroundColor` : Couleur de fond

**Exemple :**
```dart
AppBar(
  title: Text('Mon App'),
  actions: [
    IconButton(
      icon: Icon(Icons.add),
      onPressed: () {},
    ),
    IconButton(
      icon: Icon(Icons.settings),
      onPressed: () {},
    ),
  ],
)
```

**Cas d'usage :**
- En-tête d'écran
- Navigation
- Actions rapides

---

## Navigator
**Rôle :** Gestion de la navigation  
**Utilisé dans :** Part 2, 3  

**Méthodes principales :**
```dart
// Fermer l'écran actuel
Navigator.pop(context);

// Aller à un nouvel écran
Navigator.push(
  context,
  MaterialPageRoute(builder: (ctx) => NewScreen()),
);
```

**Cas d'usage :**
- Navigation entre écrans
- Fermeture de dialogues/modals

---

## showModalBottomSheet
**Rôle :** Affiche un panneau modal en bas  
**Utilisé dans :** Part 3  

**Propriétés principales :**
- `context` : BuildContext
- `builder` : Fonction retournant le widget
- `isScrollControlled` : Hauteur complète
- `useSafeArea` : Zones sécurisées

**Exemple :**
```dart
showModalBottomSheet(
  context: context,
  isScrollControlled: true,
  useSafeArea: true,
  builder: (ctx) => MyFormWidget(),
)
```

**Cas d'usage :**
- Formulaires
- Options/paramètres
- Sélection

---

## showDialog
**Rôle :** Affiche un dialogue modal  
**Utilisé dans :** Part 3  

**Exemple :**
```dart
showDialog(
  context: context,
  builder: (ctx) => AlertDialog(
    title: Text('Erreur'),
    content: Text('Un problème est survenu.'),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(ctx),
        child: Text('OK'),
      ),
    ],
  ),
)
```

**Cas d'usage :**
- Alertes
- Confirmations
- Messages d'erreur

---

## AlertDialog
**Rôle :** Dialogue d'alerte  
**Utilisé dans :** Part 3  

**Propriétés principales :**
- `title` : Titre du dialogue
# 🖼️ Widgets d'Images

## Image.network
**Rôle :** Afficher une image depuis une URL  
**Utilisé dans :** Part 4  

**Propriétés principales :**
- `url` : URL de l'image
- `fit` : Mode d'ajustement (cover, contain, fill, etc.)
- `width` / `height` : Dimensions
- `loadingBuilder` : Widget pendant le chargement
- `errorBuilder` : Widget en cas d'erreur

**Exemple :**
```dart
Image.network(
  'https://example.com/image.jpg',
  height: 400,
  width: double.infinity,
  fit: BoxFit.cover,
)
```

**Cas d'usage :**
- Images distantes
- Galeries en ligne
- Contenu dynamique

---

## FadeInImage
**Rôle :** Image avec transition de fondu et placeholder  
**Utilisé dans :** Part 4  

**Propriétés principales :**
- `placeholder` : Image pendant le chargement (ImageProvider)
- `image` : Image finale (ImageProvider)
- `fit` : Mode d'ajustement
- `width` / `height` : Dimensions
- `fadeInDuration` : Durée de l'animation

**Exemple :**
```dart
import 'package:transparent_image/transparent_image.dart';

FadeInImage(
  placeholder: MemoryImage(kTransparentImage),
  image: NetworkImage('https://example.com/image.jpg'),
  fit: BoxFit.cover,
  height: 300,
  width: double.infinity,
  fadeInDuration: Duration(milliseconds: 300),
)
```

**Avec AssetImage :**
```dart
FadeInImage(
  placeholder: AssetImage('assets/placeholder.png'),
  image: NetworkImage('https://example.com/image.jpg'),
  fit: BoxFit.cover,
)
```

**Cas d'usage :**
- Images réseau avec meilleure UX
- Transition fluide lors du chargement
- Éviter les flashs blancs

---

## Stack
**Rôle :** Superposer des widgets  
**Utilisé dans :** Part 4  

**Propriétés principales :**
- `children` : Liste de widgets superposés
- `alignment` : Alignement par défaut
- `fit` : Comment dimensionner les enfants

**Exemple :**
```dart
Stack(
  children: [
    Image.network(
      'https://example.com/image.jpg',
      width: double.infinity,
      height: 300,
      fit: BoxFit.cover,
    ),
    Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        color: Colors.black54,
        padding: EdgeInsets.all(16),
        child: Text(
          'Overlay Text',
          style: TextStyle(color: Colors.white),
        ),
      ),
    ),
  ],
)
```

**Cas d'usage :**
- Image avec overlay de texte
- Badges sur images
- Boutons flottants sur contenu

---

## Positioned
**Rôle :** Positionner un widget dans un Stack  
**Utilisé dans :** Part 4  

**Propriétés principales :**
- `top` / `bottom` : Distance du haut/bas
- `left` / `right` : Distance de gauche/droite
- `width` / `height` : Dimensions
- `child` : Widget enfant

**Exemple :**
```dart
Stack(
  children: [
    Image.asset('assets/background.jpg'),
    Positioned(
      top: 20,
      right: 20,
      child: Icon(Icons.favorite, color: Colors.red),
    ),
    Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        color: Colors.black54,
        child: Text('Bottom overlay'),
      ),
    ),
  ],
)
```

**Cas d'usage :**
- Positionnement absolu dans Stack
- Overlays positionnés
- Badges et indicateurs

---

- `content` : Contenu
- `actions` : Boutons d'action

**Exemple :**
```dart
AlertDialog(
  title: Text('Confirmer'),
  content: Text('Voulez-vous continuer ?'),
  actions: [
    TextButton(
      onPressed: () => Navigator.pop(context),
      child: Text('Annuler'),
    ),
    TextButton(
      onPressed: () {
        // Action
        Navigator.pop(context);
      },
      child: Text('OK'),
    ),
  ],
)
```

**Cas d'usage :**
- Confirmations
- Messages informatifs

---

## SnackBar
**Rôle :** Notification temporaire en bas  
**Utilisé dans :** Part 3  

**Propriétés principales :**
- `content` : Contenu du message
- `duration` : Durée d'affichage
- `action` : Action possible (undo)

**Exemple :**
```dart
ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    content: Text('Élément supprimé'),
    duration: Duration(seconds: 3),
    action: SnackBarAction(
      label: 'Annuler',
      onPressed: () {
        // Undo action
      },
    ),
  ),
)
```

**Cas d'usage :**
- Feedback utilisateur
- Notifications temporaires
- Actions avec undo

---

# 📝 Widgets de Formulaire

## TextField
**Rôle :** Champ de saisie de texte  
**Utilisé dans :** Part 3  

**Propriétés principales :**
- `controller` : TextEditingController
- `decoration` : InputDecoration
- `keyboardType` : Type de clavier
- `maxLength` : Longueur maximale
- `obscureText` : Masquer le texte (mot de passe)

**Exemple :**
```dart
TextField(
  controller: _controller,
  decoration: InputDecoration(
    labelText: 'Titre',
    hintText: 'Entrez un titre',
    prefixIcon: Icon(Icons.title),
    suffix: Text('€'),
  ),
  keyboardType: TextInputType.text,
  maxLength: 50,
)
```

**Cas d'usage :**
- Formulaires
- Saisie utilisateur
- Recherche

---

## TextEditingController
**Rôle :** Contrôleur pour TextField  
**Utilisé dans :** Part 3  

**Exemple :**
```dart
class MyWidget extends StatefulWidget {
  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  final _controller = TextEditingController();
  
  @override
  void dispose() {
    _controller.dispose(); // Important!
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      // Accès à la valeur: _controller.text
    );
  }
}
```

**Cas d'usage :**
- Gérer la valeur d'un TextField
- Validation de formulaire

---

## DropdownButton
**Rôle :** Menu déroulant de sélection  
**Utilisé dans :** Part 3  

**Propriétés principales :**
- `value` : Valeur sélectionnée
- `items` : Liste des options
- `onChanged` : Callback au changement

**Exemple :**
```dart
DropdownButton<Category>(
  value: selectedCategory,
  items: Category.values.map((category) =>
    DropdownMenuItem(
      value: category,
      child: Text(category.name.toUpperCase()),
    ),
  ).toList(),
  onChanged: (value) {
    setState(() {
      selectedCategory = value!;
    });
  },
)
```

**Cas d'usage :**
- Sélection dans une liste
- Filtres
- Catégories

---

## showDatePicker
**Rôle :** Dialogue de sélection de date  
**Utilisé dans :** Part 3  

**Propriétés principales :**
- `context` : BuildContext
- `initialDate` : Date initiale
- `firstDate` : Date minimale
- `lastDate` : Date maximale

**Exemple :**
```dart
void _selectDate() async {
  final date = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2020),
    lastDate: DateTime.now(),
  );
  
  if (date != null) {
    setState(() {
      selectedDate = date;
    });
  }
}
```

**Cas d'usage :**
- Sélection de date
- Formulaires avec dates

---

# 🎨 Widgets de Thème

## Theme.of(context)
**Rôle :** Accès au thème actuel  
**Utilisé dans :** Part 3  

**Exemple :**
```dart
Text(
  'Hello',
  style: Theme.of(context).textTheme.titleLarge,
)

Container(
  color: Theme.of(context).colorScheme.primary,
)

Icon(
  Icons.star,
  color: Theme.of(context).colorScheme.secondary,
)
```

**Cas d'usage :**
- Cohérence visuelle
- Adaptation thème clair/sombre

---

## MediaQuery
**Rôle :** Informations sur l'écran et l'appareil  
**Utilisé dans :** Part 3  

**Propriétés utiles :**
```dart
// Dimensions de l'écran
final width = MediaQuery.of(context).size.width;
final height = MediaQuery.of(context).size.height;

// Espace du clavier
final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

// Mode sombre/clair
final isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;

// Orientation
final orientation = MediaQuery.of(context).orientation;
```

**Cas d'usage :**
- Design responsive
- Adaptation au clavier
- Détection du thème système

---

## LayoutBuilder
**Rôle :** Fournit les contraintes du parent  
**Utilisé dans :** Part 3  

**Exemple :**
```dart
LayoutBuilder(
  builder: (context, constraints) {
    final width = constraints.maxWidth;
    
    if (width >= 600) {
      return TabletLayout();
    } else {
      return MobileLayout();
    }
  },
)
```

**Cas d'usage :**
- Layouts adaptatifs
- Responsive design
- Conditions sur la taille

---

# 🧠 Concepts Fondamentaux

## StatelessWidget
**Description :** Widget immuable qui ne change pas  

**Structure :**
```dart
class MyWidget extends StatelessWidget {
  const MyWidget({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
```

**Quand l'utiliser :**
- Widget qui ne change jamais
- Affichage statique
- Performance optimale

**Exemples :** Text, Icon, Image

---

## StatefulWidget
**Description :** Widget qui peut changer au fil du temps  

**Structure :**
```dart
class MyWidget extends StatefulWidget {
  const MyWidget({super.key});
  
  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  int counter = 0;
  
  void increment() {
    setState(() {
      counter++;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Text('$counter');
  }
}
```

**Quand l'utiliser :**
- Widget avec état changeant
- Interactions utilisateur
- Données dynamiques

**Exemples :** Formulaires, compteurs, animations

---

## setState()
**Description :** Met à jour l'état et reconstruit le widget  

**Utilisation :**
```dart
void updateData() {
  setState(() {
    // Modifier les variables d'état ici
    counter++;
    isLoading = false;
  });
}
```

**Points importants :**
- Toujours dans un StatefulWidget
- Déclenche un rebuild
- Modifications dans la fonction callback

---

## Const Constructors
**Description :** Optimisation avec widgets constants  

**Utilisation :**
```dart
const Text('Hello')
const SizedBox(height: 20)
const Icon(Icons.add)
```

**Avantages :**
- Meilleure performance
- Widgets réutilisés
- Moins d'allocations mémoire

**Quand l'utiliser :**
- Widget qui ne changera jamais
- Valeurs fixes

---

# 🔄 Gestion d'État

## Callbacks
**Description :** Fonctions passées en paramètres pour communication  

**Parent → Enfant (données) :**
```dart
// Parent
MyChild(data: myData)

// Enfant
class MyChild extends StatelessWidget {
  final String data;
  const MyChild({required this.data});
}
```

**Enfant → Parent (actions) :**
```dart
// Parent
MyChild(onPressed: handlePress)

void handlePress() {
  print('Bouton pressé');
}

// Enfant
class MyChild extends StatelessWidget {
  final void Function() onPressed;
  const MyChild({required this.onPressed});
  
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text('Cliquez'),
    );
  }
}
```

**Avec paramètres :**
```dart
// Parent
MyChild(onSelect: (value) => handleSelect(value))

void handleSelect(String value) {
  print('Sélectionné: $value');
}

// Enfant
final void Function(String) onSelect;
```

---

## initState() et dispose()
**Description :** Méthodes du cycle de vie d'un StatefulWidget  

**Utilisation :**
```dart
class _MyWidgetState extends State<MyWidget> {
  late TextEditingController _controller;
  
  @override
  void initState() {
    super.initState();
    // Initialisation
    _controller = TextEditingController();
  }
  
  @override
  void dispose() {
    // Nettoyage
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return TextField(controller: _controller);
  }
}
```

**Cas d'usage :**
- Initialiser des contrôleurs
- Libérer des ressources
- Éviter les fuites mémoire

---

# 🚀 Techniques Avancées

## Async/Await
**Description :** Gestion d'opérations asynchrones  

**Utilisation :**
```dart
void fetchData() async {
  final date = await showDatePicker(...);
  
  if (date != null) {
    setState(() {
      selectedDate = date;
    });
  }
}

Future<String> loadData() async {
  await Future.delayed(Duration(seconds: 2));
  return 'Données chargées';
}
```

**Cas d'usage :**
- Dialogues
- Requêtes réseau
- Chargement de fichiers

---

## Opérateur Spread (...)
**Description :** Insère tous les éléments d'une liste  

**Utilisation :**
```dart
Column(
  children: [
    Text('Titre'),
    ...items.map((item) => Text(item)),
    Text('Fin'),
  ],
)
```

**Équivalent à :**
```dart
Column(
  children: [
    Text('Titre'),
    Text(items[0]),
    Text(items[1]),
    // ...
    Text('Fin'),
  ],
)
```

---

## Getters
**Description :** Propriétés calculées  

**Utilisation :**
```dart
class Expense {
  final DateTime date;
  
  String get formattedDate => DateFormat('dd/MM/yyyy').format(date);
  
  IconData get icon => switch (category) {
    Category.food => Icons.fastfood,
    Category.travel => Icons.flight,
    // ...
  };
}
```

**Cas d'usage :**
- Données dérivées
- Formatage
- Calculs

---

## Enum
**Description :** Type avec valeurs prédéfinies  

**Définition :**
```dart
enum Category {
  food,
  travel,
  leisure,
  work,
}
```

**Utilisation :**
```dart
Category selected = Category.food;

// Itérer sur toutes les valeurs
Category.values.forEach((cat) => print(cat.name));

// Switch expression
IconData icon = switch (category) {
  Category.food => Icons.fastfood,
  Category.travel => Icons.flight,
  Category.leisure => Icons.movie,
  Category.work => Icons.work,
};
```

---

## Expressions Ternaires
**Description :** Conditions compactes  

**Utilisation :**
```dart
// Simple
final message = isError ? 'Erreur' : 'Succès';

// Widget
Widget screen = isLoading
    ? CircularProgressIndicator()
    : DataWidget();

// Multiple
Widget getScreen() {
  return screen == 'home'
      ? HomeScreen()
      : screen == 'settings'
      ? SettingsScreen()
      : AboutScreen();
}
```

---

## Validation de Formulaire
**Description :** Vérifier les données avant traitement  

**Utilisation :**
```dart
bool isValid() {
  final title = _titleController.text.trim();
  final amount = double.tryParse(_amountController.text);
  
  return title.isNotEmpty &&
         amount != null &&
         amount > 0 &&
         selectedDate != null;
}

void submit() {
  if (!isValid()) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Erreur'),
        content: Text('Veuillez remplir tous les champs.'),
      ),
    );
    return;
  }
  
  // Traiter les données
}
```

---

## Manipulation de Listes
**Description :** Opérations courantes sur les listes  

**Ajout :**
```dart
list.add(item);
list.addAll([item1, item2]);
list.insert(index, item);
```

**Suppression :**
```dart
list.remove(item);
list.removeAt(index);
list.removeWhere((item) => item.isExpired);
list.clear();
```

**Recherche :**
```dart
final index = list.indexOf(item);
final found = list.firstWhere((item) => item.id == '123');
```

**Transformation :**
```dart
// Map
final titles = items.map((item) => item.title).toList();

// Where (filtrage)
final active = items.where((item) => item.isActive).toList();

// Fold (agrégation)
final total = items
    .map((item) => item.price)
    .fold(0.0, (sum, price) => sum + price);
```

---

## ColorScheme Personnalisé
**Description :** Palette de couleurs cohérente  

**Utilisation :**
```dart
// Dans main.dart
var kColorScheme = ColorScheme.fromSeed(
  seedColor: Colors.deepPurple,
);

var kColorSchemeDark = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: Colors.blueGrey,
);

// Dans MaterialApp
MaterialApp(
  theme: ThemeData().copyWith(
    colorScheme: kColorScheme,
    appBarTheme: AppBarTheme().copyWith(
      backgroundColor: kColorScheme.primary,
    ),
  ),
  darkTheme: ThemeData().copyWith(
    colorScheme: kColorSchemeDark,
  ),
)
```

---

## Thème Global avec copyWith()
**Description :** Personnaliser tous les widgets d'un type  

**Utilisation :**
```dart
MaterialApp(
  theme: ThemeData().copyWith(
    colorScheme: kColorScheme,
    
    // Personnaliser Card
    cardTheme: CardThemeData().copyWith(
      color: kColorScheme.secondaryContainer,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),
    
    // Personnaliser ElevatedButton
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: kColorScheme.primary,
        foregroundColor: Colors.white,
      ),
    ),
    
    // Personnaliser Text
    textTheme: ThemeData().textTheme.copyWith(
      titleLarge: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
    ),
  ),
)
```

---

## Design Responsive
**Description :** Adapter l'UI à la taille de l'écran  

**Utilisation :**
```dart
@override
Widget build(BuildContext context) {
  final width = MediaQuery.of(context).size.width;
  
  return width < 600
      ? Column(
          children: [
            Chart(),
            ExpenseList(),
          ],
        )
      : Row(
          children: [
            Expanded(child: Chart()),
            Expanded(child: ExpenseList()),
          ],
        );
}
```

**Avec LayoutBuilder :**
```dart
LayoutBuilder(
  builder: (ctx, constraints) {
    if (constraints.maxWidth >= 600) {
      return Row(children: [...]);
    } else {
      return Column(children: [...]);
    }
  },
)
```

---

# 📦 Packages Externes

## google_fonts
**Installation :**
```bash
flutter pub add google_fonts
```

**Utilisation :**
```dart
import 'package:google_fonts/google_fonts.dart';

Text(
  'Hello',
  style: GoogleFonts.lato(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  ),
)
```

**Cas d'usage :**
- Polices personnalisées
- Typographie professionnelle

---

## uuid
**Installation :**
```bash
flutter pub add uuid
```

**Utilisation :**
```dart
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class MyModel {
  final String id;
  
  MyModel() : id = uuid.v4();
}
```

**Cas d'usage :**
- Identifiants uniques
- Keys pour listes

---

## intl
**Installation :**
```bash
flutter pub add intl
```

**Utilisation :**
```dart
import 'package:intl/intl.dart';

// Formatage de dates
final formatter = DateFormat('dd/MM/yyyy');
String formatted = formatter.format(DateTime.now());

// Formatage de nombres
final numberFormat = NumberFormat.currency(locale: 'fr_FR', symbol: '€');
String price = numberFormat.format(19.99);
```

**Cas d'usage :**
- Formatage de dates
- Formatage de nombres/devises
- Internationalisation

---

## flutter/services.dart
**Utilisation :**
```dart
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Verrouiller l'orientation
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) => runApp(MyApp()));
}
```

**Cas d'usage :**
- Contrôle de l'orientation
- Barre de statut
- Services système

---

# 📊 Tableaux de Référence Rapide

## Widgets de Layout

| Widget | Usage | Propriétés clés |
|--------|-------|-----------------|
| Container | Conteneur polyvalent | decoration, padding, margin |
| Column | Disposition verticale | mainAxisAlignment, crossAxisAlignment |
| Row | Disposition horizontale | mainAxisAlignment, crossAxisAlignment |
| Center | Centrage | child |
| Expanded | Remplir l'espace | flex, child |
| Spacer | Espace flexible | - |
| SizedBox | Taille fixe/espacement | width, height |
| Padding | Espacement intérieur | padding |

## Widgets d'Interaction

| Widget | Usage | Event |
|--------|-------|-------|
| ElevatedButton | Bouton principal | onPressed |
| OutlinedButton | Bouton secondaire | onPressed |
| TextButton | Bouton tertiaire | onPressed |
| IconButton | Bouton icône | onPressed |
| Dismissible | Swipe actions | onDismissed |

## Widgets de Formulaire

| Widget | Usage | Controller |
|--------|-------|------------|
| TextField | Saisie texte | TextEditingController |
| DropdownButton | Sélection liste | value, onChanged |
| showDatePicker | Sélection date | Future<DateTime?> |

## EdgeInsets Variants

| Méthode | Usage |
|---------|-------|
| `EdgeInsets.all(20)` | Tous les côtés |
| `EdgeInsets.symmetric(horizontal: 10, vertical: 5)` | Symétrique |
| `EdgeInsets.only(top: 10, left: 5)` | Côtés spécifiques |
| `EdgeInsets.fromLTRB(10, 20, 10, 20)` | Left, Top, Right, Bottom |

## MainAxisAlignment Options

| Valeur | Description |
|--------|-------------|
| `start` | Début (haut/gauche) |
| `end` | Fin (bas/droite) |
| `center` | Centre |
| `spaceBetween` | Espacement entre |
| `spaceAround` | Espacement autour |
| `spaceEvenly` | Espacement égal |

---

# 🎯 Exemples de Patterns Courants

## Pattern: Liste avec Actions Swipe
```dart
ListView.builder(
  itemCount: items.length,
  itemBuilder: (ctx, i) => Dismissible(
    key: ValueKey(items[i].id),
    direction: DismissDirection.endToStart,
    onDismissed: (_) => deleteItem(items[i]),
    background: Container(
      color: Colors.red,
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: 20),
      child: Icon(Icons.delete, color: Colors.white),
    ),
    child: ListTile(
      title: Text(items[i].title),
      onTap: () => viewItem(items[i]),
    ),
  ),
)
```

## Pattern: Formulaire Modal
```dart
void openForm() {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (ctx) => Padding(
      padding: EdgeInsets.fromLTRB(
        16, 
        16, 
        16, 
        MediaQuery.of(ctx).viewInsets.bottom + 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _controller,
            decoration: InputDecoration(labelText: 'Titre'),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: Text('Annuler'),
              ),
              ElevatedButton(
                onPressed: () => submitForm(),
                child: Text('Enregistrer'),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
```

## Pattern: Card avec Informations
```dart
Card(
  child: Padding(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          item.title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Icon(item.icon, size: 20),
            SizedBox(width: 8),
            Text('${item.amount} €'),
            Spacer(),
            Text(item.formattedDate),
          ],
        ),
      ],
    ),
  ),
)
```

## Pattern: Layout Responsive
```dart
Widget build(BuildContext context) {
  final width = MediaQuery.of(context).size.width;
  final isMobile = width < 600;
  
  return isMobile
      ? Column(
          children: [
            HeaderWidget(),
            Expanded(child: ContentWidget()),
          ],
        )
      : Row(
          children: [
            Expanded(child: SidebarWidget()),
            Expanded(
              flex: 2,
              child: ContentWidget(),
            ),
          ],
        );
}
```

## Pattern: Validation et Soumission
```dart
void submitForm() {
  // Validation
  if (!_formKey.currentState!.validate()) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Erreur de validation'),
        content: Text('Veuillez corriger les erreurs.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('OK'),
          ),
        ],
      ),
    );
    return;
  }
  
  // Traitement
  final data = MyModel(
    title: _titleController.text,
    amount: double.parse(_amountController.text),
  );
  
  setState(() {
    items.add(data);
  });
  
  // Feedback
  Navigator.pop(context);
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Enregistré avec succès')),
  );
}
```

---

# 🎓 Progression Recommandée

## Niveau Débutant
1. ✅ StatelessWidget / StatefulWidget
2. ✅ setState()
3. ✅ Widgets de base (Text, Image, Icon)
4. ✅ Layouts simples (Column, Row, Container)
5. ✅ Boutons basiques
6. ✅ const pour optimisation

## Niveau Intermédiaire
1. ✅ Navigation multi-écrans
2. ✅ Callbacks parent-enfant
3. ✅ Listes avec ListView
4. ✅ Packages externes (google_fonts)
5. ✅ Modèles de données
6. ✅ Opérateur spread
7. ✅ Getters personnalisés

## Niveau Avancé
1. ✅ Thèmes personnalisés complets
2. ✅ Design responsive (MediaQuery, LayoutBuilder)
3. ✅ CRUD complet
4. ✅ Async/Await
5. ✅ Validation de formulaires
6. ✅ Architecture MVC
7. ✅ Packages avancés (uuid, intl)
8. ✅ Interactions avancées (Dismissible, SnackBar)

---

# 🔍 Index Alphabétique

A
- AlertDialog
- AppBar
- Async/Await

C
- Card
- Callbacks
- Center
- CircleAvatar
- Column
- const
- Container
- ColorScheme

D
- DecoratedBox
- Design Responsive
- Dismissible
- DropdownButton

E
- EdgeInsets
- ElevatedButton
- Enum
- Expanded

F
- FractionallySizedBox

G
- Getters
- google_fonts

I
- Icon
- IconButton
- Image.asset
- initState() / dispose()
- intl

L
- LayoutBuilder
- ListView.builder

M
- MaterialApp
- MediaQuery

N
- Navigator

O
- Opérateur Spread
- OutlinedButton

P
- Padding

R
- Row

S
- Scaffold
- setState()
- showDatePicker
- showDialog
- showModalBottomSheet
- SingleChildScrollView
- SizedBox
- SnackBar
- Spacer
- StatefulWidget
- StatelessWidget

T
- Text
- TextButton
- TextField
- TextEditingController
- Theme.of(context)

U
- uuid

V
- Validation

---

**Document créé pour le projet First App Flutter**  
**Dernière mise à jour : 2025**

