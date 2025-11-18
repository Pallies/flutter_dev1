
    // État de chargement
    if (_isLoading) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    // État d'erreur
    if (_error != null) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Error: $_error'),
              ElevatedButton(
                onPressed: _loadItems,
                child: Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    // État normal
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Groceries'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _addItem(context),
          ),
        ],
      ),
      body: items.isEmpty
          ? Center(child: Text('No items yet!'))
          : ListView.builder(
              itemCount: items.length,
              itemBuilder: (ctx, i) => Dismissible(
                key: ValueKey(items[i].id),
                onDismissed: (_) {
                  ref.read(groceryNotifier.notifier)
                     .removeItem(items[i].id);
                },
                child: ListTile(
                  title: Text(items[i].name),
                  trailing: Text('${items[i].quantity}'),
                ),
              ),
            ),
    );
  }
}
```

---

### Part 8 : Shopping List avec SQLite

**Architecture :**
```
lib/_training_part/part8/
├── database/
│   ├── DatabaseHelper.dart
│   ├── User.dart
│   └── UserRepository.dart
├── data/
│   ├── categories.dart
│   └── dummy_items.dart
├── models/
│   ├── category.model.dart
│   └── grocery_item.model.dart
├── providers/
│   ├── category.provider.dart
│   └── grocery.provider.dart
└── widgets/
    ├── grocery_list.widget.dart
    ├── grocery_future_list.widget.dart
    └── new_grocery_item.widget.dart
```

#### 1. DatabaseHelper (Singleton)
```dart
// database/DatabaseHelper.dart
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('my_database.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        email TEXT NOT NULL UNIQUE
      )
    ''');
    
    await db.execute('''
      CREATE TABLE grocery_items (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        quantity INTEGER NOT NULL,
        category TEXT NOT NULL
      )
    ''');
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
```

---

#### 2. Repository Pattern
```dart
// database/UserRepository.dart
class UserRepository {
  // CREATE
  Future<int> insert(User user) async {
    final db = await DatabaseHelper.instance.database;
    return await db.insert('users', user.toJson());
  }

  // READ
  Future<List<User>> getAll() async {
    final db = await DatabaseHelper.instance.database;
    final result = await db.query('users');
    return result.map((json) => User.fromJson(json)).toList();
  }

  Future<User?> getById(int id) async {
    final db = await DatabaseHelper.instance.database;
    final result = await db.query(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );
    
    if (result.isEmpty) return null;
    return User.fromJson(result.first);
  }

  // UPDATE
  Future<int> update(User user) async {
    final db = await DatabaseHelper.instance.database;
    return await db.update(
      'users',
      user.toJson(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  // DELETE
  Future<int> delete(int id) async {
    final db = await DatabaseHelper.instance.database;
    return await db.delete(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
```

---

#### 3. Initialisation dans main()
```dart
// main.dart
void main() async {
  // Important pour les opérations async avant runApp
  WidgetsFlutterBinding.ensureInitialized();

  // Initialiser la base de données
  final db = await DatabaseHelper.instance.database;
  
  runApp(const ProviderScope(child: App()));
}
```

---

#### 4. StateNotifier avec SQLite
```dart
// providers/grocery.provider.dart
class GroceryNotifier extends StateNotifier<List<GroceryItem>> {
  GroceryNotifier() : super([]) {
    loadItems(); // Charger au démarrage
  }

  Future<void> loadItems() async {
    final db = await DatabaseHelper.instance.database;
    final result = await db.query('grocery_items');
    
    state = result.map((json) => GroceryItem.fromJson(json)).toList();
  }

  Future<void> addItem(GroceryItem item) async {
    final db = await DatabaseHelper.instance.database;
    final id = await db.insert('grocery_items', item.toJson());
    
    final newItem = item.copyWith(id: id);
    state = [...state, newItem];
  }

  Future<void> removeItem(int itemId) async {
    final db = await DatabaseHelper.instance.database;
    await db.delete(
      'grocery_items',
      where: 'id = ?',
      whereArgs: [itemId],
    );
    
    state = state.where((item) => item.id != itemId).toList();
  }

  Future<void> updateItem(GroceryItem item) async {
    final db = await DatabaseHelper.instance.database;
    await db.update(
      'grocery_items',
      item.toJson(),
      where: 'id = ?',
      whereArgs: [item.id],
    );
    
    state = [
      for (final i in state)
        if (i.id == item.id) item else i,
    ];
  }
}
```

---

## 🔄 Comparaison des Approches

### Gestion d'État : Part 6 vs Part 7 vs Part 8

| Aspect | Part 6 (Riverpod Local) | Part 7 (Riverpod + HTTP) | Part 8 (Riverpod + SQLite) |
|--------|-------------------------|--------------------------|----------------------------|
| **Source de données** | Liste statique en mémoire | API REST (Firebase) | Base de données locale |
| **Persistance** | ❌ Non (perte au redémarrage) | ✅ Serveur distant | ✅ Locale sur l'appareil |
| **Async** | Synchrone | Asynchrone (Futures) | Asynchrone (Futures) |
| **Connexion réseau** | ❌ Non requise | ✅ Requise | ❌ Non requise |
| **Offline** | ✅ Fonctionne | ❌ Ne fonctionne pas | ✅ Fonctionne |
| **Partage entre appareils** | ❌ Non | ✅ Oui | ❌ Non |
| **Complexité** | ⭐⭐ Simple | ⭐⭐⭐⭐ Avancée | ⭐⭐⭐⭐⭐ Très avancée |

---

## 🎯 Bonnes Pratiques Riverpod

### 1. Organisation des Providers
```
lib/
├── providers/
│   ├── auth_provider.dart          # Authentification
│   ├── user_provider.dart          # Données utilisateur
│   ├── items_provider.dart         # Liste d'items
│   └── filters_provider.dart       # Filtres et recherche
```

### 2. Nommage des Providers
```dart
// ✅ Bon : Nom descriptif avec suffixe Provider
final userProfileProvider = ...
final groceryItemsProvider = ...
final isLoadingProvider = ...

// ❌ Mauvais : Noms génériques
final data = ...
final list = ...
final user = ...
```

### 3. Séparer Logique et UI
```dart
// ✅ Bon : Logique dans le provider
class TodoNotifier extends StateNotifier<List<Todo>> {
  void addTodo(String title) {
    final newTodo = Todo(id: uuid.v4(), title: title);
    state = [...state, newTodo];
  }
}

// ❌ Mauvais : Logique dans le widget
Widget build(BuildContext context, WidgetRef ref) {
  return ElevatedButton(
    onPressed: () {
      final todos = ref.read(todosProvider);
      ref.read(todosProvider.notifier).state = [
        ...todos,
        Todo(id: uuid.v4(), title: 'New')
      ];
    },
  );
}
```

### 4. Utiliser ref.watch() dans build(), ref.read() dans les handlers
```dart
// ✅ Bon
@override
Widget build(BuildContext context, WidgetRef ref) {
  final count = ref.watch(counterProvider); // Rebuild quand change
  
  return ElevatedButton(
    onPressed: () {
      ref.read(counterProvider.notifier).state++; // Pas de rebuild
    },
    child: Text('$count'),
  );
}
```

### 5. Gérer les Erreurs
```dart
class DataNotifier extends StateNotifier<AsyncValue<List<Item>>> {
  DataNotifier() : super(const AsyncValue.loading()) {
    loadData();
  }

  Future<void> loadData() async {
    state = const AsyncValue.loading();
    
    try {
      final data = await fetchData();
      state = AsyncValue.data(data);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}
```

---

**Document créé pour le projet First App Flutter**  
**Dernière mise à jour : 2025-01-17**  
**Couvre Riverpod avec exemples concrets des Parts 6, 7 et 8**
# 🎯 Guide Complet Riverpod - Gestion d'État en Flutter

> Documentation complète sur Riverpod avec exemples pratiques et fonctionnalités avancées

---

## 📑 Table des Matières

1. [Introduction à Riverpod](#introduction-à-riverpod)
2. [Installation et Configuration](#installation-et-configuration)
3. [Types de Providers](#types-de-providers)
4. [Utilisation dans les Widgets](#utilisation-dans-les-widgets)
5. [Patterns et Exemples Pratiques](#patterns-et-exemples-pratiques)
6. [Fonctionnalités Avancées](#fonctionnalités-avancées)
7. [Ressources et Liens Utiles](#ressources-et-liens-utiles)
8. [Exemples Pratiques des Parts du Projet](#exemples-pratiques-des-parts-du-projet)
   - [Part 6 : Meals Application avec Riverpod](#part-6--meals-application-avec-riverpod)
   - [Part 7 : Shopping List avec HTTP](#part-7--shopping-list-avec-http)
   - [Part 8 : Shopping List avec SQLite](#part-8--shopping-list-avec-sqlite)
9. [Comparaison des Approches](#comparaison-des-approches)
10. [Bonnes Pratiques Riverpod](#bonnes-pratiques-riverpod)

---

## 🎓 Introduction à Riverpod

### Qu'est-ce que Riverpod ?

**Riverpod** est une solution de gestion d'état moderne pour Flutter, créée par Remi Rousselet (créateur de Provider). C'est une amélioration de Provider avec les avantages suivants :

✅ **Compile-time safety** : Détection des erreurs à la compilation  
✅ **Pas de BuildContext** : Pas besoin de contexte pour accéder aux providers  
✅ **Testable** : Facile à tester et à mocker  
✅ **Composable** : Les providers peuvent dépendre d'autres providers  
✅ **Pas de InheritedWidget** : Plus de problèmes de widget tree  
✅ **Scope management** : Gestion des scopes simplifiée  

### Pourquoi Riverpod ?

| Problème avec setState | Solution Riverpod |
|------------------------|-------------------|
| État local au widget | État global accessible partout |
| Difficile à partager | Facile à partager entre widgets |
| Pas de cache | Cache automatique |
| Rebuild inutiles | Rebuild optimisés |
| Difficile à tester | Facilement testable |

---

## 📦 Installation et Configuration

### 1. Installation

**Ajouter la dépendance :**
```yaml
# pubspec.yaml
dependencies:
  flutter_riverpod: ^2.5.1
```

**Installer :**
```bash
flutter pub add flutter_riverpod
```

### 2. Configuration de base

**Wrapper l'application avec ProviderScope :**
```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(  // 🔥 Obligatoire !
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}
```

**Points clés :**
- `ProviderScope` est obligatoire à la racine
- Il stocke l'état de tous les providers
- Un seul `ProviderScope` suffit généralement

---

## 🧩 Types de Providers

### 1. Provider (Données Immuables)

**Utilisation :** Données qui ne changent jamais (constantes, configurations, listes statiques)

**Exemple du projet (mealsProvider) :**
```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:first_app/data/dummy_data.dart';

// Provider pour des listes immuables
final mealsProvider = Provider((ref) {
  return dummyMeals;
});
```

**Caractéristiques :**
- ✅ Simple et léger
- ✅ Données en lecture seule
- ✅ Calculé une seule fois
- ❌ Impossible de modifier l'état

**Cas d'usage :**
```dart
// Constantes
final apiUrlProvider = Provider((ref) => 'https://api.example.com');

// Configuration
final themeProvider = Provider((ref) => ThemeData.dark());

// Données statiques
final categoriesProvider = Provider((ref) => categoriesList);
```

---

### 2. StateProvider (État Simple)

**Utilisation :** État simple qui peut changer (compteur, boolean, string)

**Exemple :**
```dart
// Compteur simple
final counterProvider = StateProvider<int>((ref) => 0);

// Boolean
final isDarkModeProvider = StateProvider<bool>((ref) => false);

// Dans le widget
class CounterScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(counterProvider);
    
    return Column(
      children: [
        Text('Count: $count'),
        ElevatedButton(
          onPressed: () {
            // Modifier directement
            ref.read(counterProvider.notifier).state++;
          },
          child: Text('Increment'),
        ),
      ],
    );
  }
}
```

**Caractéristiques :**
- ✅ Simple à utiliser
- ✅ Mutation directe avec `.state`
- ⚠️ Limité aux types simples
- ❌ Pas de logique métier complexe

---

### 3. StateNotifierProvider (État Complexe avec Logique)

**Utilisation :** État complexe avec logique métier (listes modifiables, objets complexes)

**Exemple du projet (FavoritesMealNotifier) :**
```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class FavoritesMealNotifier extends StateNotifier<List<Meal>> {
  FavoritesMealNotifier() : super([]); // État initial

  void toggleFavorite(Meal meal, context) {
    var message = '';
    ScaffoldMessenger.of(context).clearSnackBars();
    
    if (isFavorite(meal)) {
      // Retirer des favoris
      state = state.where((m) => m.id != meal.id).toList();
      message = 'Meal is no longer a favorite.';
    } else {
      // Ajouter aux favoris
      state = [...state, meal];
      message = 'Marked as a favorite!';
    }
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  bool isFavorite(Meal meal) {
    return state.contains(meal);
  }
}

// StateNotifierProvider pour gérer les listes dynamiques
final favoritesMealsProvider = StateNotifierProvider<FavoritesMealNotifier, List<Meal>>(
  (ref) => FavoritesMealNotifier(),
);
```

**Caractéristiques :**
- ✅ Logique métier encapsulée
- ✅ État immutable (création de nouveau state)
- ✅ Méthodes personnalisées
- ✅ Facile à tester
- ⚠️ Plus verbeux que StateProvider

**Pattern recommandé :**
```dart
class TodoNotifier extends StateNotifier<List<Todo>> {
  TodoNotifier() : super([]);

  void addTodo(String title) {
    state = [...state, Todo(id: uuid(), title: title)];
  }

  void removeTodo(String id) {
    state = state.where((todo) => todo.id != id).toList();
  }

  void toggleTodo(String id) {
    state = [
      for (final todo in state)
        if (todo.id == id)
          todo.copyWith(completed: !todo.completed)
        else
          todo,
    ];
  }
}

final todoProvider = StateNotifierProvider<TodoNotifier, List<Todo>>((ref) {
  return TodoNotifier();
});
```

---

### 4. Provider.family (Providers Paramétrés)

**Utilisation :** Provider qui prend un paramètre (filtrage, détails par ID)

**Exemple du projet (isMealFavoriteProvider) :**
```dart
final isMealFavoriteProvider = Provider.family<bool, Meal>(
  (ref, meal) {
    final favoriteMeals = ref.watch(favoritesMealsProvider);
    return favoriteMeals.contains(meal);
  },
);

// Utilisation dans le widget
class MealDetailsScreen extends ConsumerWidget {
  final Meal meal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavorite = ref.watch(isMealFavoriteProvider(meal));
    
    return Icon(
      isFavorite ? Icons.star : Icons.star_border,
    );
  }
}
```

**Autre exemple :**
```dart
// Provider avec ID
final userProvider = FutureProvider.family<User, String>((ref, userId) async {
  final response = await http.get('/api/users/$userId');
  return User.fromJson(response.data);
});

// Utilisation
final user = ref.watch(userProvider('123'));
```

**Caractéristiques :**
- ✅ Réutilisable avec différents paramètres
- ✅ Cache par paramètre
- ⚠️ Crée une instance par paramètre unique

---

### 5. FutureProvider (Données Asynchrones)

**Utilisation :** Requêtes API, chargement de fichiers, opérations async

**Exemple :**
```dart
// API call
final weatherProvider = FutureProvider<Weather>((ref) async {
  final response = await http.get('https://api.weather.com/current');
  return Weather.fromJson(response.data);
});

// Dans le widget
class WeatherScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherAsync = ref.watch(weatherProvider);
    
    return weatherAsync.when(
      data: (weather) => Text('Temp: ${weather.temperature}°C'),
      loading: () => CircularProgressIndicator(),
      error: (error, stack) => Text('Error: $error'),
    );
  }
}
```

**Avec paramètres :**
```dart
final cityWeatherProvider = FutureProvider.family<Weather, String>((ref, city) async {
  final response = await http.get('https://api.weather.com/$city');
  return Weather.fromJson(response.data);
});

// Utilisation
final weather = ref.watch(cityWeatherProvider('Paris'));
```

---

### 6. StreamProvider (Données en Temps Réel)

**Utilisation :** WebSockets, Firebase, Stream de données

**Exemple :**
```dart
// Firebase Realtime
final messagesProvider = StreamProvider<List<Message>>((ref) {
  return FirebaseDatabase.instance
      .ref('messages')
      .onValue
      .map((event) => parseMessages(event.snapshot.value));
});

// Dans le widget
class MessagesScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messagesAsync = ref.watch(messagesProvider);
    
    return messagesAsync.when(
      data: (messages) => ListView.builder(
        itemCount: messages.length,
        itemBuilder: (ctx, i) => MessageItem(message: messages[i]),
      ),
      loading: () => CircularProgressIndicator(),
      error: (error, stack) => Text('Error: $error'),
    );
  }
}
```

---

### 7. ChangeNotifierProvider (Migration depuis Provider)

**Utilisation :** Compatibilité avec ChangeNotifier (migration facile)

**Exemple :**
```dart
class CartNotifier extends ChangeNotifier {
  final List<Product> _items = [];
  
  List<Product> get items => _items;
  
  void addProduct(Product product) {
    _items.add(product);
    notifyListeners(); // Déclenche rebuild
  }
  
  void removeProduct(String id) {
    _items.removeWhere((item) => item.id == id);
    notifyListeners();
  }
}

final cartProvider = ChangeNotifierProvider((ref) => CartNotifier());
```

**⚠️ Note :** Préférer `StateNotifierProvider` pour du nouveau code

---

## 🎨 Utilisation dans les Widgets

### ConsumerWidget (Recommandé)

**Remplace StatelessWidget pour accéder aux providers**

**Exemple du projet :**
```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoriesScreen extends ConsumerWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ref.watch() pour lire et écouter les changements
    final filteredMeals = ref.watch(filteredMealsProvider);
    
    return GridView.builder(
      itemCount: filteredMeals.length,
      itemBuilder: (_, index) => MealItem(meal: filteredMeals[index]),
    );
  }
}
```

**Avantages :**
- ✅ Simple et clair
- ✅ Accès direct à `ref`
- ✅ Pas de Consumer imbriqués
- ✅ Rebuild optimisé

---

### ConsumerStatefulWidget (Pour État Local)

**Remplace StatefulWidget quand on a besoin d'état local + providers**

**Exemple :**
```dart
class FiltersScreen extends ConsumerStatefulWidget {
  const FiltersScreen({super.key});

  @override
  ConsumerState<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends ConsumerState<FiltersScreen> {
  late bool _glutenFree;

  @override
  void initState() {
    super.initState();
    _glutenFree = ref.read(filterGlutenProvider);
  }

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: _glutenFree,
      onChanged: (value) {
        setState(() => _glutenFree = value);
        ref.read(filterMealsProvider.notifier).setFilter(Filter.glutenFree, value);
      },
      title: Text('Gluten-free'),
    );
  }
}
```

---

### Consumer (Widget Unique)

**Optimisation : rebuild seulement une partie du widget**

**Exemple :**
```dart
class MyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('This won\'t rebuild'),
        Consumer(
          builder: (context, ref, child) {
            final count = ref.watch(counterProvider);
            return Text('Count: $count'); // Seul ce widget rebuild
          },
        ),
        Text('This won\'t rebuild either'),
      ],
    );
  }
}
```

---

### ref.watch() vs ref.read() vs ref.listen()

| Méthode | Usage | Rebuild |
|---------|-------|---------|
| `ref.watch()` | Lire et écouter les changements | ✅ Oui |
| `ref.read()` | Lire une seule fois (event handlers) | ❌ Non |
| `ref.listen()` | Écouter sans rebuild (side effects) | ❌ Non |

**Exemples :**

```dart
@override
Widget build(BuildContext context, WidgetRef ref) {
  // ✅ watch() - Pour afficher des données qui changent
  final meals = ref.watch(mealsProvider);
  
  // ✅ listen() - Pour effets de bord (SnackBar, navigation)
  ref.listen<List<Meal>>(favoritesMealsProvider, (previous, next) {
    if (next.length > previous!.length) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Added to favorites!')),
      );
    }
  });
  
  return ElevatedButton(
    // ✅ read() - Pour actions (pas besoin de rebuild)
    onPressed: () {
      ref.read(favoritesMealsProvider.notifier).toggleFavorite(meal, context);
    },
    child: Text('Toggle Favorite'),
  );
}
```

---

## 🔥 Patterns et Exemples Pratiques

### Pattern 1 : Filtrage de Données

**Exemple du projet (filteredMealsProvider) :**
```dart
class FilterNotifier extends StateNotifier<Map<Filter, bool>> {
  FilterNotifier() : super({
    Filter.glutenFree: false,
    Filter.lactoseFree: false,
    Filter.vegetarian: false,
    Filter.vegan: false,
  });

  void setFilter(Filter filter, bool isActive) {
    state = {
      ...state,
      filter: isActive,
    };
  }
}

final filterMealsProvider = StateNotifierProvider<FilterNotifier, Map<Filter, bool>>((ref) {
  return FilterNotifier();
});

// Provider qui combine meals + filtres
final filteredMealsProvider = Provider<List<Meal>>((ref) {
  final meals = ref.watch(mealsProvider);
  final filters = ref.watch(filterMealsProvider);
  
  return meals.where((meal) {
    if (filters[Filter.glutenFree]! && !meal.isGlutenFree) return false;
    if (filters[Filter.lactoseFree]! && !meal.isLactoseFree) return false;
    if (filters[Filter.vegetarian]! && !meal.isVegetarian) return false;
    if (filters[Filter.vegan]! && !meal.isVegan) return false;
    return true;
  }).toList();
});
```

**Avantages :**
- Séparation des responsabilités
- Réutilisable
- Testable facilement

---

### Pattern 2 : Dépendances entre Providers

**Provider qui dépend d'autres providers :**
```dart
// Provider de base
final userIdProvider = StateProvider<String?>((ref) => null);

// Provider dépendant
final userProfileProvider = FutureProvider<UserProfile?>((ref) async {
  final userId = ref.watch(userIdProvider);
  
  if (userId == null) return null;
  
  final response = await http.get('/api/users/$userId');
  return UserProfile.fromJson(response.data);
});

// Provider qui combine plusieurs sources
final dashboardDataProvider = FutureProvider<DashboardData>((ref) async {
  final user = await ref.watch(userProfileProvider.future);
  final stats = await ref.watch(statsProvider.future);
  
  return DashboardData(user: user, stats: stats);
});
```

---

### Pattern 3 : Provider avec Factory Function

**Exemple du projet :**
```dart
Provider<bool> filterProvider(Filter filter) =>
    Provider<bool>((ref) => ref.watch(filterMealsProvider)[filter]!);

final filterGlutenProvider = filterProvider(Filter.glutenFree);
final filterLactoseProvider = filterProvider(Filter.lactoseFree);
final filterVegetarianProvider = filterProvider(Filter.vegetarian);
final filterVeganProvider = filterProvider(Filter.vegan);
```

**Avantages :**
- Évite la duplication de code
- Création dynamique de providers
- Code plus DRY (Don't Repeat Yourself)

---

### Pattern 4 : Pagination avec Riverpod

```dart
class PaginatedNotifier extends StateNotifier<List<Post>> {
  PaginatedNotifier() : super([]);
  
  int _page = 1;
  bool _isLoading = false;
  
  Future<void> loadMore() async {
    if (_isLoading) return;
    
    _isLoading = true;
    final newPosts = await fetchPosts(page: _page);
    state = [...state, ...newPosts];
    _page++;
    _isLoading = false;
  }
}

final postsProvider = StateNotifierProvider<PaginatedNotifier, List<Post>>((ref) {
  return PaginatedNotifier();
});
```

---

### Pattern 5 : Recherche avec Debounce

```dart
final searchQueryProvider = StateProvider<String>((ref) => '');

final debouncedSearchProvider = Provider<String>((ref) {
  final query = ref.watch(searchQueryProvider);
  
  // Debounce la recherche
  final debounce = Timer(Duration(milliseconds: 500), () {});
  ref.onDispose(() => debounce.cancel());
  
  return query;
});

final searchResultsProvider = FutureProvider<List<Product>>((ref) async {
  final query = ref.watch(debouncedSearchProvider);
  
  if (query.isEmpty) return [];
  
  return await searchProducts(query);
});
```

---

## 🚀 Fonctionnalités Avancées

### 1. AutoDispose (Nettoyage Automatique)

**Libère automatiquement les ressources quand le provider n'est plus utilisé**

```dart
// Provider qui se dispose automatiquement
final tempDataProvider = StateProvider.autoDispose<String>((ref) {
  print('Provider créé');
  
  ref.onDispose(() {
    print('Provider détruit');
  });
  
  return 'Initial value';
});

// FutureProvider avec autoDispose
final userProvider = FutureProvider.autoDispose.family<User, String>((ref, id) async {
  final cancelToken = CancelToken();
  
  ref.onDispose(() {
    cancelToken.cancel(); // Annule la requête si le widget est détruit
  });
  
  return await fetchUser(id, cancelToken);
});
```

**Cas d'usage :**
- Économiser la mémoire
- Annuler les requêtes HTTP
- Fermer les streams

---

### 2. KeepAlive (Garder en Cache)

**Empêche le provider de se disposer même sans listeners**

```dart
final cacheProvider = FutureProvider.autoDispose<List<Product>>((ref) async {
  final link = ref.keepAlive(); // 🔥 Garde en cache
  
  // Auto-dispose après 5 minutes d'inactivité
  Timer(Duration(minutes: 5), () {
    link.close();
  });
  
  return await fetchProducts();
});
```

---

### 3. Refresh Provider

**Recharger les données manuellement**

```dart
// Dans le widget
ElevatedButton(
  onPressed: () {
    // Force le rechargement
    ref.refresh(weatherProvider);
  },
  child: Text('Refresh Weather'),
)

// Ou invalider pour recalculer
ref.invalidate(weatherProvider);
```

---

### 4. Scoped Providers (Providers Locaux)

**Override un provider dans une partie de l'arbre**

```dart
// Provider global
final themeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.light);

// Override dans une partie de l'app
ProviderScope(
  overrides: [
    themeProvider.overrideWith((ref) => ThemeMode.dark),
  ],
  child: AdminPanel(), // Utilise le thème sombre uniquement ici
)
```

---

### 5. Select (Optimisation des Rebuilds)

**Rebuild uniquement quand une propriété spécifique change**

```dart
class User {
  final String id;
  final String name;
  final int age;
}

final userProvider = StateProvider<User>((ref) => User(...));

// Rebuild seulement si le nom change
class UserNameWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final name = ref.watch(userProvider.select((user) => user.name));
    
    return Text(name); // Ne rebuild pas si age change
  }
}
```

---

### 6. Combine Providers

**Créer un provider qui combine plusieurs sources**

```dart
final combinedProvider = Provider<CombinedData>((ref) {
  final user = ref.watch(userProvider);
  final settings = ref.watch(settingsProvider);
  final theme = ref.watch(themeProvider);
  
  return CombinedData(
    user: user,
    settings: settings,
    theme: theme,
  );
});
```

---

### 7. AsyncValue (Gestion des États Async)

**API riche pour gérer loading, data, error**

```dart
final dataProvider = FutureProvider<String>((ref) async {
  await Future.delayed(Duration(seconds: 2));
  return 'Data loaded';
});

class MyWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValue = ref.watch(dataProvider);
    
    // Pattern matching
    return asyncValue.when(
      data: (data) => Text(data),
      loading: () => CircularProgressIndicator(),
      error: (error, stack) => Text('Error: $error'),
    );
    
    // Ou check manuel
    if (asyncValue.isLoading) {
      return CircularProgressIndicator();
    }
    
    if (asyncValue.hasError) {
      return Text('Error: ${asyncValue.error}');
    }
    
    if (asyncValue.hasValue) {
      return Text('Data: ${asyncValue.value}');
    }
    
    return SizedBox();
  }
}
```

---

### 8. Provider Observers (Debugging)

**Logger tous les changements de providers**

```dart
class Logger extends ProviderObserver {
  @override
  void didUpdateProvider(
    ProviderBase provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    print('''
{
  "provider": "${provider.name ?? provider.runtimeType}",
  "previousValue": "$previousValue",
  "newValue": "$newValue"
}''');
  }
}

void main() {
  runApp(
    ProviderScope(
      observers: [Logger()], // 🔥 Active le logging
      child: MyApp(),
    ),
  );
}
```

---

### 9. Testing avec Riverpod

**Mock des providers pour les tests**

```dart
// Test file
void main() {
  test('Counter increments', () {
    final container = ProviderContainer(
      overrides: [
        // Mock le provider
        counterProvider.overrideWith((ref) => StateController(10)),
      ],
    );
    
    expect(container.read(counterProvider), 10);
    
    container.read(counterProvider.notifier).state++;
    
    expect(container.read(counterProvider), 11);
    
    container.dispose();
  });
}
```

---

### 10. Code Generation (Riverpod Generator)

**Génération automatique de code pour moins de boilerplate**

**Installation :**
```yaml
dependencies:
  riverpod_annotation: ^2.3.0

dev_dependencies:
  build_runner: ^2.4.0
  riverpod_generator: ^2.3.0
```

**Utilisation :**
```dart
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'providers.g.dart';

@riverpod
Future<String> fetchData(FetchDataRef ref) async {
  return await api.getData();
}

@riverpod
class Counter extends _$Counter {
  @override
  int build() => 0;
  
  void increment() => state++;
}

// Génère automatiquement fetchDataProvider et counterProvider
```

**Générer le code :**
```bash
flutter pub run build_runner watch
```

---

## 📚 Ressources et Liens Utiles

### Documentation Officielle

- **Site officiel :** https://riverpod.dev/
- **Documentation complète :** https://riverpod.dev/docs/introduction/why_riverpod
- **Migration depuis Provider :** https://riverpod.dev/docs/from_provider/motivation
- **Exemples officiels :** https://github.com/rrousselGit/riverpod/tree/master/examples

### Tutoriels et Guides

- **Getting Started :** https://riverpod.dev/docs/getting_started
- **StateNotifier Guide :** https://riverpod.dev/docs/concepts/providers#statenotifierprovider
- **Best Practices :** https://riverpod.dev/docs/concepts/reading
- **Testing :** https://riverpod.dev/docs/cookbooks/testing

### Packages Complémentaires

- **flutter_riverpod** : https://pub.dev/packages/flutter_riverpod
- **riverpod_annotation** : https://pub.dev/packages/riverpod_annotation
- **riverpod_generator** : https://pub.dev/packages/riverpod_generator
- **hooks_riverpod** : https://pub.dev/packages/hooks_riverpod

### Vidéos et Cours

- **Riverpod Official YouTube :** https://www.youtube.com/@RemiRousselet

---

## 📱 Exemples Pratiques des Parts du Projet

### Part 6 : Meals Application avec Riverpod

**Architecture :**
```
lib/_training_part/part6/
├── data/
│   └── dummy_data.dart          # Données statiques
├── models/
│   ├── meal.dart
│   └── category.dart
├── providers/
│   ├── meals_provider.dart      # Provider simple
│   ├── favorites_provider.dart  # StateNotifier
│   └── filters_provider.dart    # StateNotifier + computed
├── screens/
│   ├── tabs.dart
│   ├── categories.dart
│   ├── meals.dart
│   ├── meal_details.dart
│   └── filters.dart
└── widgets/
    ├── category_grid_item.dart
    ├── meal_item.dart
    └── main_drawer.dart
```

#### 1. Provider Simple (Données Immuables)
```dart
// providers/meals_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:first_app/_training_part/part6/data/dummy_data.dart';

final mealsProvider = Provider((ref) {
  return dummyMeals; // Liste statique de repas
});
```

**Utilisation :** Données qui ne changent jamais (liste de référence)

---

#### 2. StateNotifier pour Favoris
```dart
// providers/favorites_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../models/meal.dart';

class FavoritesMealNotifier extends StateNotifier<List<Meal>> {
  FavoritesMealNotifier() : super([]); // État initial vide

  void toggleFavorite(Meal meal, BuildContext context) {
    var message = '';
    ScaffoldMessenger.of(context).clearSnackBars();
    
    if (isFavorite(meal)) {
      // Retirer des favoris
      state = state.where((m) => m.id != meal.id).toList();
      message = 'Meal is no longer a favorite.';
    } else {
      // Ajouter aux favoris
      state = [...state, meal];
      message = 'Marked as a favorite!';
    }
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  bool isFavorite(Meal meal) {
    return state.contains(meal);
  }
}

final favoritesMealsProvider = 
    StateNotifierProvider<FavoritesMealNotifier, List<Meal>>(
  (ref) => FavoritesMealNotifier(),
);
```

**Points clés :**
- ✅ Immutabilité : `state = [...state, meal]` crée une nouvelle liste
- ✅ Méthodes métier encapsulées
- ✅ Feedback utilisateur avec SnackBar

---

#### 3. StateNotifier pour Filtres
```dart
// providers/filters_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

enum Filter { glutenFree, lactoseFree, vegetarian, vegan }

class FilterNotifier extends StateNotifier<Map<Filter, bool>> {
  FilterNotifier() : super({
    Filter.glutenFree: false,
    Filter.lactoseFree: false,
    Filter.vegetarian: false,
    Filter.vegan: false,
  });

  void setFilter(Filter filter, bool isActive) {
    state = {
      ...state,
      filter: isActive,
    };
  }

  void setFilters(Map<Filter, bool> newFilters) {
    state = newFilters;
  }
}

final filterMealsProvider = 
    StateNotifierProvider<FilterNotifier, Map<Filter, bool>>(
  (ref) => FilterNotifier(),
);
```

---

#### 4. Provider Computed (Dépendances)
```dart
// providers/filters_provider.dart (suite)

// Provider qui combine meals + filtres
final filteredMealsProvider = Provider<List<Meal>>((ref) {
  final meals = ref.watch(mealsProvider);
  final filters = ref.watch(filterMealsProvider);
  
  return meals.where((meal) {
    if (filters[Filter.glutenFree]! && !meal.isGlutenFree) return false;
    if (filters[Filter.lactoseFree]! && !meal.isLactoseFree) return false;
    if (filters[Filter.vegetarian]! && !meal.isVegetarian) return false;
    if (filters[Filter.vegan]! && !meal.isVegan) return false;
    return true;
  }).toList();
});
```

**Avantages :**
- ✅ Séparation des responsabilités
- ✅ Recalcul automatique quand meals ou filters changent
- ✅ Réutilisable dans plusieurs widgets

---

#### 5. Provider.family (Paramétrés)
```dart
// providers/favorites_provider.dart (suite)

// Provider qui vérifie si un repas spécifique est favori
final isMealFavoriteProvider = Provider.family<bool, Meal>(
  (ref, meal) {
    final favoriteMeals = ref.watch(favoritesMealsProvider);
    return favoriteMeals.contains(meal);
  },
);
```

**Utilisation dans un widget :**
```dart
class MealDetailsScreen extends ConsumerWidget {
  final Meal meal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavorite = ref.watch(isMealFavoriteProvider(meal));
    
    return IconButton(
      icon: Icon(isFavorite ? Icons.star : Icons.star_border),
      onPressed: () {
        ref.read(favoritesMealsProvider.notifier)
           .toggleFavorite(meal, context);
      },
    );
  }
}
```

---

#### 6. Factory Function pour Providers
```dart
// providers/filters_provider.dart (suite)

// Fonction factory pour créer des providers de filtres individuels
Provider<bool> filterProvider(Filter filter) =>
    Provider<bool>((ref) => ref.watch(filterMealsProvider)[filter]!);

// Providers individuels
final filterGlutenProvider = filterProvider(Filter.glutenFree);
final filterLactoseProvider = filterProvider(Filter.lactoseFree);
final filterVegetarianProvider = filterProvider(Filter.vegetarian);
final filterVeganProvider = filterProvider(Filter.vegan);
```

**Utilisation dans FiltersScreen :**
```dart
class FiltersScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends ConsumerState<FiltersScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SwitchListTile(
          value: ref.watch(filterGlutenProvider),
          onChanged: (value) {
            ref.read(filterMealsProvider.notifier)
               .setFilter(Filter.glutenFree, value);
          },
          title: Text('Gluten-free'),
        ),
        // Autres switches...
      ],
    );
  }
}
```

---

### Part 7 : Shopping List avec HTTP

**Architecture :**
```
lib/_training_part/part7/
├── data/
│   ├── categories.dart
│   └── dummy_items.dart
├── models/
│   ├── category.model.dart
│   └── grocery_item.model.dart
├── providers/
│   ├── category.provider.dart
│   ├── grocery.provider.dart
│   └── grocery_forms.provider.dart
└── widgets/
    ├── grocery_list.widget.dart
    └── new_grocery_item.widget.dart
```

#### 1. Model avec JSON Parsing
```dart
// models/grocery_item.model.dart
class GroceryItem {
  final String id;
  final String name;
  final int quantity;
  final Category category;

  GroceryItem({
    required this.id,
    required this.name,
    required this.quantity,
    required this.category,
  });

  factory GroceryItem.fromJson(Map<String, dynamic> json) {
    return GroceryItem(
      id: json['id'],
      name: json['name'],
      quantity: json['quantity'],
      category: categories.firstWhere((cat) => cat.id == json['category']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'quantity': quantity,
      'category': category.id,
    };
  }
}
```

---

#### 2. StateNotifier avec HTTP
```dart
// providers/grocery.provider.dart
import 'package:flutter_riverpod/legacy.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GroceryNotifier extends StateNotifier<List<GroceryItem>> {
  GroceryNotifier() : super([]);

  // GET - Charger les items
  Future<void> loadItems() async {
    final url = Uri.https(
      'flutter-prep-default-rtdb.firebaseio.com',
      'shopping-list.json',
    );

    try {
      final response = await http.get(url);
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>?;
        
        if (data == null) {
          state = [];
          return;
        }

        final items = data.entries.map((entry) {
          return GroceryItem.fromJson({
            'id': entry.key,
            ...entry.value,
          });
        }).toList();

        state = items;
      }
    } catch (error) {
      print('Error loading items: $error');
    }
  }

  // POST - Ajouter un item
  Future<void> addItem(GroceryItem item) async {
    final url = Uri.https(
      'flutter-prep-default-rtdb.firebaseio.com',
      'shopping-list.json',
    );

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(item.toJson()),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final data = json.decode(response.body);
        final newItem = GroceryItem(
          id: data['name'], // Firebase génère un ID
          name: item.name,
          quantity: item.quantity,
          category: item.category,
        );
        
        state = [...state, newItem];
      }
    } catch (error) {
      print('Error adding item: $error');
    }
  }

  // DELETE - Supprimer un item
  Future<void> removeItem(String itemId) async {
    final url = Uri.https(
      'flutter-prep-default-rtdb.firebaseio.com',
      'shopping-list/$itemId.json',
    );

    try {
      final response = await http.delete(url);
      
      if (response.statusCode == 200) {
        state = state.where((item) => item.id != itemId).toList();
      }
    } catch (error) {
      print('Error removing item: $error');
    }
  }
}

final groceryNotifier = 
    StateNotifierProvider<GroceryNotifier, List<GroceryItem>>(
  (ref) => GroceryNotifier(),
);
```

---

#### 3. Widget avec États de Chargement
```dart
// widgets/grocery_list.widget.dart
class GroceryList extends ConsumerStatefulWidget {
  @override
  ConsumerState<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends ConsumerState<GroceryList> {
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  Future<void> _loadItems() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      await ref.read(groceryNotifier.notifier).loadItems();
      setState(() => _isLoading = false);
    } catch (error) {
      setState(() {
        _error = error.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final items = ref.watch(groceryNotifier);
- **Flutter Documentation :** https://docs.flutter.dev/data-and-backend/state-mgmt/options#riverpod
- **Riverpod Crash Course :** https://www.youtube.com/results?search_query=riverpod+flutter+tutorial

### Communauté

- **GitHub Repository :** https://github.com/rrousselGit/riverpod
- **Discord Server :** https://discord.gg/Bbumvej
- **Stack Overflow :** https://stackoverflow.com/questions/tagged/riverpod

### Comparaisons

- **Riverpod vs Provider :** https://riverpod.dev/docs/from_provider/motivation
- **Riverpod vs Bloc :** https://riverpod.dev/docs/introduction/why_riverpod
- **State Management Comparison :** https://docs.flutter.dev/data-and-backend/state-mgmt/options

---

## 📊 Tableau Récapitulatif des Providers

| Provider | État | Mutable | Async | Usage Principal |
|----------|------|---------|-------|-----------------|
| **Provider** | Lecture seule | ❌ | ❌ | Constantes, configs |
| **StateProvider** | Simple | ✅ | ❌ | Compteur, boolean |
| **StateNotifierProvider** | Complexe | ✅ | ❌ | Listes, objets complexes |
| **FutureProvider** | Async | ❌ | ✅ | API calls |
| **StreamProvider** | Temps réel | ❌ | ✅ | WebSocket, Firebase |
| **ChangeNotifierProvider** | Legacy | ✅ | ❌ | Migration Provider |

---

## 🎯 Quand Utiliser Quoi ?

```
Données statiques (liste fixe)
└─> Provider

État simple (compteur, boolean)
└─> StateProvider

État complexe avec logique métier
└─> StateNotifierProvider

Requête API (fetch data once)
└─> FutureProvider

Données en temps réel (WebSocket)
└─> StreamProvider

Migration depuis Provider
└─> ChangeNotifierProvider
```

---

## 💡 Conseils et Bonnes Pratiques

### ✅ À Faire

1. **Utiliser `.autoDispose`** pour les données temporaires
2. **Séparer la logique métier** des widgets avec StateNotifier
3. **Utiliser `.family`** pour les providers paramétrés
4. **Tester les providers** indépendamment des widgets
5. **Utiliser `ref.watch()` dans build**, `ref.read()` dans callbacks
6. **Logger les changements** avec ProviderObserver en dev
7. **Utiliser select()** pour optimiser les rebuilds

### ❌ À Éviter

1. ❌ **Ne jamais utiliser `ref.read()` dans `build()`**
2. ❌ **Ne pas muter `state` directement** avec StateNotifier
3. ❌ **Ne pas oublier `.toList()` après `.where()`**
4. ❌ **Ne pas créer de providers dans build()**
5. ❌ **Ne pas oublier `ProviderScope` à la racine**
6. ❌ **Ne pas utiliser ChangeNotifier pour du nouveau code**

---

**Document créé pour First App Flutter - Guide Riverpod**  
**Gestion d'État Moderne avec Riverpod**  
**Dernière mise à jour : 2025-01-17**

