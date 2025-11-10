# 📚 Part 4 - Application de Recettes avec Navigation Avancée

## 🎯 Objectif du Projet
Créer une application complète de recettes avec navigation multi-écrans, système de favoris, filtres personnalisés et navigation par onglets (BottomNavigationBar et Drawer).

---

## 🧩 Concepts et Techniques Abordés

### 1. **Architecture Multi-Écrans Complexe**
- Navigation à plusieurs niveaux (Tabs → Catégories → Repas → Détails)
- Gestion d'état partagé entre plusieurs écrans
- Communication bidirectionnelle parent-enfant

### 2. **Navigation Avancée**
- **BottomNavigationBar** : Navigation par onglets en bas
- **Drawer** : Menu latéral de navigation
- **Navigator.push/pop** : Navigation entre écrans avec retour de données
- **PopScope** : Intercepter le bouton retour pour gérer les données

### 3. **Gestion d'État Complexe**
- État partagé entre plusieurs écrans (favoris, filtres)
- Mise à jour de l'état depuis des écrans enfants
- Retour de données via `Navigator.pop()` avec résultat

### 4. **Filtrage de Données**
- Système de filtres multiples (sans gluten, sans lactose, végétarien, végan)
- Filtrage dynamique d'une liste avec `.where()`
- Persistance des filtres entre les écrans

### 5. **Système de Favoris**
- Ajout/suppression de favoris
- Vérification de l'existence dans une liste
- Feedback utilisateur avec SnackBar

### 6. **Extensions Dart**
- Extension personnalisée sur `String` pour capitalisation
- Utilisation dans les enums pour formater les labels

### 7. **Enums avec Propriétés et Getters**
- Enums avec constructeurs personnalisés
- Propriétés associées aux valeurs d'enum
- Getters pour formater les données

### 8. **Widgets Avancés**
- **GridView** : Grille de catégories
- **Stack** et **Positioned** : Superposition d'éléments
- **FadeInImage** : Chargement progressif d'images
- **InkWell** : Effet d'encre au clic
- **SwitchListTile** : Switch avec titre et sous-titre
- **ListView** : Liste déroulante pour détails de repas
- **DrawerHeader** : En-tête personnalisé du drawer

### 9. **Gestion d'Images Réseau**
- **Image.network** : Affichage d'images depuis Internet
- **transparent_image** package : Image placeholder transparente
- **FadeInImage** : Transition fluide lors du chargement

### 10. **Thématisation Avancée**
- Thème sombre avec Material 3
- ColorScheme généré depuis une couleur de base
- Google Fonts pour la typographie
- Personnalisation cohérente de tous les widgets

---

## 📦 Widgets Utilisés

### Navigation
| Widget | Utilisation | Propriétés clés |
|--------|-------------|-----------------|
| **BottomNavigationBar** | Navigation par onglets | `items`, `currentIndex`, `onTap` |
| **Drawer** | Menu latéral | `child` (Column avec widgets) |
| **DrawerHeader** | En-tête du Drawer | `decoration`, `padding`, `child` |
| **ListTile** | Item de liste/menu | `leading`, `title`, `onTap` |
| **PopScope** | Gestion du retour | `canPop`, `onPopInvokedWithResult` |

### Layout
| Widget | Utilisation | Propriétés clés |
|--------|-------------|-----------------|
| **GridView** | Grille de catégories | `gridDelegate`, `children` |
| **SliverGridDelegateWithFixedCrossAxisCount** | Configuration grille | `crossAxisCount`, `childAspectRatio`, `spacing` |
| **Stack** | Superposition d'éléments | `children` (widgets superposés) |
| **Positioned** | Positionnement dans Stack | `left`, `right`, `top`, `bottom` |
| **ListView** | Liste déroulante | `children` ou `builder` |

### Interaction
| Widget | Utilisation | Propriétés clés |
|--------|-------------|-----------------|
| **InkWell** | Zone cliquable avec effet | `onTap`, `splashColor`, `borderRadius` |
| **SwitchListTile** | Switch avec labels | `value`, `onChanged`, `title`, `subtitle` |

### Images
| Widget | Utilisation | Propriétés clés |
|--------|-------------|-----------------|
| **FadeInImage** | Image avec placeholder | `placeholder`, `image`, `fit` |
| **Image.network** | Image depuis URL | `url`, `fit`, `width`, `height` |
| **MemoryImage** | Image depuis mémoire | `bytes` |
| **NetworkImage** | Provider d'image réseau | `url` |

### Affichage
| Widget | Utilisation | Propriétés clés |
|--------|-------------|-----------------|
| **Card** | Carte avec élévation | `margin`, `shape`, `clipBehavior`, `elevation` |
| **Text** | Affichage de texte | `style`, `maxLines`, `overflow`, `textAlign` |

---

## 🎨 Patterns de Code Importants

### 1. Navigation avec BottomNavigationBar
```dart
class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = _selectedPageIndex == 0 
        ? CategoryScreen() 
        : FavoritesScreen();
    
    return Scaffold(
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.restaurant), label: 'Catégories'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favoris'),
        ],
      ),
    );
  }
}
```

### 2. Drawer avec Navigation
```dart
Drawer(
  child: Column(
    children: [
      DrawerHeader(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.primary.withAlpha(190),
            ],
          ),
        ),
        child: Row(children: [Icon(...), Text(...)]),
      ),
      ListTile(
        leading: Icon(Icons.restaurant),
        title: Text('Repas'),
        onTap: () => onSelectScreen('meals'),
      ),
      ListTile(
        leading: Icon(Icons.settings),
        title: Text('Filtrer'),
        onTap: () => onSelectScreen('filters'),
      ),
    ],
  ),
)
```

### 3. Navigation avec Retour de Données
```dart
// Aller vers l'écran de filtres et récupérer le résultat
void _selectScreen(String identifier) async {
  Navigator.of(context).pop(); // Ferme le drawer
  
  if (identifier == 'filters') {
    final result = await Navigator.of(context).push<Map<FilterOption, bool>>(
      MaterialPageRoute(
        builder: (ctx) => FiltersScreen(filterOptions: _selectedFilters),
      ),
    );
    
    if (result != null) {
      setState(() {
        _selectedFilters = result;
      });
    }
  }
}
```

### 4. PopScope pour Intercepter le Retour
```dart
PopScope(
  canPop: false, // Empêche le retour automatique
  onPopInvokedWithResult: (bool didPop, dynamic result) {
    if (didPop) return;
    
    // Retourner les données au parent
    Navigator.of(context).pop({
      FilterOption.glutenFree: _glutenFreeFilterSet,
      FilterOption.lactoseFree: _lactoseFreeFilterSet,
      FilterOption.vegetarian: _vegetarianFilterSet,
      FilterOption.vegan: _veganFilterSet,
    });
  },
  child: Column(...),
)
```

### 5. Système de Favoris
```dart
final List<Meal> _favoriteMeals = [];

void _toggleFavorite(Meal meal) {
  final isExisting = _favoriteMeals.contains(meal);
  
  setState(() {
    if (isExisting) {
      _favoriteMeals.remove(meal);
      _showMessage('Le plat a été retiré des favoris.');
    } else {
      _favoriteMeals.add(meal);
      _showMessage('Le plat a été ajouté aux favoris.');
    }
  });
}

void _showMessage(String message) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message), duration: Duration(seconds: 3)),
  );
}
```

### 6. Filtrage de Données Complexe
```dart
final availableMeals = mealsData.where((meal) {
  return _selectedFilters[FilterOption.glutenFree]! && !meal.isGlutenFree ||
         _selectedFilters[FilterOption.lactoseFree]! && !meal.isLactoseFree ||
         _selectedFilters[FilterOption.vegetarian]! && !meal.isVegetarian ||
         _selectedFilters[FilterOption.vegan]! && !meal.isVegan
      ? false
      : true;
}).toList();
```

### 7. GridView pour Grille
```dart
GridView(
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    childAspectRatio: 3 / 2,
    crossAxisSpacing: 20,
    mainAxisSpacing: 20,
  ),
  children: [
    ...categoriesData.map(
      (item) => CategoryItem(
        category: item,
        categoryEvent: () => _mealScreenRouter(context, item),
      ),
    ),
  ],
)
```

### 8. Stack avec Positioned (Image + Overlay)
```dart
Stack(
  children: [
    FadeInImage(
      placeholder: MemoryImage(kTransparentImage),
      image: NetworkImage(meal.imageUrl),
      fit: BoxFit.cover,
      height: 300,
      width: double.infinity,
    ),
    Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        color: Colors.black54,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        child: Column(
          children: [
            Text(meal.title, style: TextStyle(color: Colors.white)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                MealItemRow(text: '${meal.duration} min', icon: Icons.schedule),
                MealItemRow(text: meal.complexity.text, icon: Icons.work),
                MealItemRow(text: meal.affordability.text, icon: Icons.attach_money),
              ],
            ),
          ],
        ),
      ),
    ),
  ],
)
```

### 9. InkWell avec Effet d'Encre
```dart
InkWell(
  onTap: categoryEvent,
  splashColor: Theme.of(context).colorScheme.primary,
  borderRadius: BorderRadius.circular(15),
  child: Container(
    padding: EdgeInsets.all(15),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          category.color.withAlpha(178),
          category.color,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(15),
    ),
    child: Text(category.title),
  ),
)
```

### 10. SwitchListTile pour Filtres
```dart
SwitchListTile(
  value: _glutenFreeFilterSet,
  title: Text(
    'Sans Gluten',
    style: Theme.of(context).textTheme.titleLarge!.copyWith(
      color: Theme.of(context).colorScheme.onSurface,
    ),
  ),
  subtitle: Text(
    'Seulement les repas sans gluten',
    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
      color: Theme.of(context).colorScheme.onSurface,
    ),
  ),
  activeThumbColor: Theme.of(context).colorScheme.secondary,
  contentPadding: EdgeInsets.only(left: 34, right: 22),
  onChanged: (isChecked) {
    setState(() {
      _glutenFreeFilterSet = isChecked;
    });
  },
)
```

### 11. Enum avec Propriétés Personnalisées
```dart
enum Complexity {
  simple('simple'),
  challenging('difficile'),
  hard('extrême');

  final String label;
  const Complexity(this.label);

  get text {
    return label.toCapitalize();
  }
}

enum Affordability {
  affordable('abordable'),
  pricey('cher'),
  luxurious('luxueux');

  final String label;
  const Affordability(this.label);

  get text {
    return label.toCapitalize();
  }
}
```

### 12. Extension sur String
```dart
extension StringExtension on String {
  String toCapitalize() {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1).toLowerCase();
  }
}

// Utilisation
final text = 'bonjour'.toCapitalize(); // 'Bonjour'
```

### 13. Modèles de Données Complexes
```dart
class Meal {
  const Meal({
    required this.id,
    required this.categories,
    required this.title,
    required this.imageUrl,
    required this.ingredients,
    required this.steps,
    required this.duration,
    required this.complexity,
    required this.affordability,
    required this.isGlutenFree,
    required this.isLactoseFree,
    required this.isVegan,
    required this.isVegetarian,
  });

  final String id;
  final List<String> categories;
  final String title;
  final String imageUrl;
  final List<String> ingredients;
  final List<String> steps;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;
  final bool isGlutenFree;
  final bool isLactoseFree;
  final bool isVegan;
  final bool isVegetarian;

  bool containsCategories(String category) {
    return categories.contains(category);
  }
}
```

### 14. Gestion d'État avec Map de Filtres
```dart
enum FilterOption {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

const kInitialFilters = {
  FilterOption.glutenFree: false,
  FilterOption.lactoseFree: false,
  FilterOption.vegetarian: false,
  FilterOption.vegan: false,
};

class _TabsScreenState extends State<TabsScreen> {
  Map<FilterOption, bool> _selectedFilters = kInitialFilters;
  
  // Utilisation pour filtrage
  final available = mealsData.where((meal) {
    if (_selectedFilters[FilterOption.glutenFree]! && !meal.isGlutenFree) return false;
    if (_selectedFilters[FilterOption.lactoseFree]! && !meal.isLactoseFree) return false;
    if (_selectedFilters[FilterOption.vegetarian]! && !meal.isVegetarian) return false;
    if (_selectedFilters[FilterOption.vegan]! && !meal.isVegan) return false;
    return true;
  }).toList();
}
```

---

## 🗂️ Structure du Projet

```
part4/
├── main.dart                      # Point d'entrée avec thème
├── data/
│   ├── category.data.dart         # Données des catégories
│   └── meal.data.dart             # Données des repas
├── models/
│   ├── category.model.dart        # Modèle Category
│   ├── meal.model.dart            # Modèle Meal avec enums
│   └── filter_option.model.dart   # Enum FilterOption
├── screens/
│   ├── tabs.screen.dart           # Écran principal avec onglets
│   ├── category.screen.dart       # Grille de catégories
│   ├── meal.screen.dart           # Liste de repas
│   ├── meal_detail.screen.dart    # Détails d'un repas
│   └── filters.screen.dart        # Écran de filtres
├── widgets/
│   ├── category_item.widget.dart  # Item de catégorie
│   ├── meal_item.widget.dart      # Card de repas
│   ├── meal_item_row.dart         # Row d'informations
│   └── main_drawer.dart           # Drawer de navigation
└── extensions/
    └── string.extension.dart      # Extension String
```

---

## 📚 Packages Utilisés

### 1. **google_fonts**
- Typographie personnalisée (Lato)
- Application à tout le thème via `textTheme`

```dart
textTheme: GoogleFonts.latoTextTheme()
```

### 2. **transparent_image**
- Image placeholder transparente pour FadeInImage
- Transition fluide lors du chargement d'images réseau

```dart
import 'package:transparent_image/transparent_image.dart';

FadeInImage(
  placeholder: MemoryImage(kTransparentImage),
  image: NetworkImage(meal.imageUrl),
)
```

---

## 🎓 Concepts Clés à Retenir

### 1. **Navigation Multi-Niveaux**
- Combiner BottomNavigationBar et Drawer pour une navigation riche
- Utiliser PopScope pour gérer le retour avec données
- Navigator.pop() peut retourner des valeurs au parent

### 2. **Gestion d'État Partagé**
- L'état principal (favoris, filtres) doit être au niveau parent commun
- Passer des callbacks pour modifier l'état depuis les enfants
- Utiliser `await Navigator.push()` pour récupérer des données

### 3. **Filtrage de Listes**
- `.where()` pour filtrer avec conditions complexes
- `.contains()` pour vérifier l'existence
- Logique de filtrage avec opérateurs logiques

### 4. **Extensions Dart**
- Ajouter des méthodes à des types existants
- Utile pour formater des données (capitalize, format, etc.)
- Syntaxe propre et réutilisable

### 5. **Enums Avancés**
- Enums avec constructeurs et propriétés
- Getters pour données formatées
- Association valeur-label

### 6. **Stack et Positioned**
- Superposer des widgets (image + overlay)
- Positioned pour placement précis
- Overlay semi-transparent avec Colors.black54

### 7. **InkWell vs GestureDetector**
- InkWell crée un effet d'encre Material Design
- splashColor pour personnaliser la couleur de l'effet
- borderRadius pour adapter la forme

### 8. **SwitchListTile**
- Combinaison Switch + ListTile
- title et subtitle pour contexte
- activeThumbColor pour cohérence thème

### 9. **FadeInImage**
- Chargement progressif d'images
- placeholder pour expérience utilisateur fluide
- Évite l'affichage blanc pendant le chargement

### 10. **GridView**
- Grille responsive avec SliverGridDelegate
- crossAxisCount pour nombre de colonnes
- childAspectRatio pour proportions

---

## 🚀 Progression vs Parts Précédentes

| Concept | Part 1 | Part 2 | Part 3 | Part 4 |
|---------|--------|--------|--------|--------|
| Navigation simple | ✅ | ✅ | ✅ | ✅ |
| Navigation multi-écrans | ❌ | ✅ | ✅ | ✅ |
| BottomNavigationBar | ❌ | ❌ | ❌ | ✅ |
| Drawer | ❌ | ❌ | ❌ | ✅ |
| Navigation avec retour de données | ❌ | ❌ | ❌ | ✅ |
| PopScope | ❌ | ❌ | ❌ | ✅ |
| Système de favoris | ❌ | ❌ | ❌ | ✅ |
| Filtrage complexe | ❌ | ❌ | ❌ | ✅ |
| Extensions Dart | ❌ | ❌ | ❌ | ✅ |
| Enums avec propriétés | ❌ | ❌ | ❌ | ✅ |
| GridView | ❌ | ❌ | ❌ | ✅ |
| Stack/Positioned | ❌ | ❌ | ❌ | ✅ |
| FadeInImage | ❌ | ❌ | ❌ | ✅ |
| InkWell | ❌ | ❌ | ❌ | ✅ |
| SwitchListTile | ❌ | ❌ | ❌ | ✅ |
| Images réseau | ❌ | ❌ | ❌ | ✅ |

---

## 💡 Bonnes Pratiques Illustrées

### 1. **Séparation des Responsabilités**
- Écrans séparés pour chaque vue
- Widgets réutilisables (MealItem, CategoryItem)
- Modèles de données distincts

### 2. **État au Bon Niveau**
- État partagé (favoris, filtres) dans l'écran parent commun
- Callbacks pour communication enfant → parent
- Props pour communication parent → enfant

### 3. **Feedback Utilisateur**
- SnackBar pour confirmer les actions
- clearSnackBars() avant d'afficher un nouveau
- Messages clairs et concis

### 4. **Gestion d'Erreurs**
- Vérifier si le résultat est null après navigation
- Utiliser des valeurs par défaut (kInitialFilters)
- Gérer les cas de liste vide avec widget de fallback

### 5. **Performance**
- const constructors partout où possible
- FadeInImage pour chargement progressif
- ListView.builder si la liste était très longue

### 6. **UX/UI**
- InkWell pour feedback visuel
- Gradient pour design moderne
- Thème cohérent sur toute l'app
- Navigation intuitive (tabs + drawer)

---

## 🎯 Points d'Apprentissage Essentiels

1. **BottomNavigationBar** est idéal pour 2-5 sections principales
2. **Drawer** convient aux options secondaires et paramètres
3. **Navigator.push/pop** peut transférer des données bidirectionnellement
4. **PopScope** intercepte le bouton retour pour logique personnalisée
5. **Map<Enum, bool>** est parfait pour gérer des options multiples
6. **Extensions** enrichissent les types existants sans héritage
7. **Enums avancés** peuvent avoir constructeurs et méthodes
8. **Stack** permet des layouts complexes avec superposition
9. **FadeInImage** améliore l'expérience utilisateur pour images réseau
10. **InkWell** crée des interactions Material Design intuitives

---

**Document créé pour First App Flutter - Part 4**  
**Application de Recettes avec Navigation Avancée**  
**Dernière mise à jour : 2025**

