# Part 1 - Résumé des Techniques Flutter

## 📚 Vue d'ensemble
Cette partie couvre les bases de Flutter avec une application de lancement de dés, illustrant les concepts fondamentaux de la création d'interfaces utilisateur et de la gestion d'état.

---

## 🎯 Concepts Fondamentaux Abordés

### 1. **Structure de Base d'une Application Flutter**
- Point d'entrée `main()` avec `runApp()`
- Hiérarchie des widgets : `MaterialApp` → `Scaffold` → Widgets enfants
- Organisation du code en fichiers séparés

### 2. **Types de Widgets**

#### **StatelessWidget**
- Widgets immuables qui ne changent pas après leur création
- Exemples utilisés :
  - `GradientContainer` : conteneur avec gradient personnalisé
  - `StyledText` : widget de texte stylisé réutilisable

**Utilisation :**
```dart
class StyledText extends StatelessWidget {
  const StyledText(this.text, {super.key});
  final String text;
  
  @override
  Widget build(BuildContext context) {
    return Text(text, style: TextStyle(...));
  }
}
```

#### **StatefulWidget**
- Widgets qui peuvent changer leur état au fil du temps
- Exemple utilisé : `DiceRoller`
- Composé de deux classes :
  - La classe widget elle-même
  - La classe State qui contient la logique et l'état

**Utilisation :**
```dart
class DiceRoller extends StatefulWidget {
  @override
  State<DiceRoller> createState() => _DiceRollerState();
}

class _DiceRollerState extends State<DiceRoller> {
  int diceNumber = 1;
  
  void rollDice() {
    setState(() {
      diceNumber = randomizer.nextInt(6) + 1;
    });
  }
  
  @override
  Widget build(BuildContext context) { ... }
}
```

---

## 🧩 Widgets Spécifiques et Leurs Utilisations

### **MaterialApp**
- Widget racine pour les applications Material Design
- Fournit les thèmes et la navigation de base
```dart
MaterialApp(
  home: Scaffold(...)
)
```

### **Scaffold**
- Structure de base d'une page Material Design
- Fournit la structure visuelle de base (AppBar, Body, etc.)
```dart
Scaffold(
  backgroundColor: Colors.blue,
  body: GradientContainer(...)
)
```

### **Container**
- Widget de mise en page polyvalent
- Peut avoir une décoration, des contraintes, des marges, etc.
```dart
Container(
  decoration: BoxDecoration(
    gradient: LinearGradient(...)
  ),
  child: Center(...)
)
```

### **BoxDecoration**
- Permet de décorer un Container
- Utilisé ici pour créer un gradient linéaire
```dart
BoxDecoration(
  gradient: LinearGradient(
    colors: [Colors.blue, Colors.deepOrangeAccent],
    begin: AlignmentGeometry.topLeft,
    end: AlignmentGeometry.bottomRight,
  )
)
```

### **LinearGradient**
- Crée un dégradé de couleurs linéaire
- Propriétés : `colors`, `begin`, `end`

### **Center**
- Centre son widget enfant dans l'espace disponible
```dart
Center(child: DiceRoller())
```

### **Column**
- Organise les widgets verticalement
- `mainAxisSize: MainAxisSize.min` : prend le minimum d'espace nécessaire
```dart
Column(
  mainAxisSize: MainAxisSize.min,
  children: [widget1, widget2, ...]
)
```

### **Image.asset**
- Affiche une image depuis les assets du projet
- Propriétés : `width`, `height`
```dart
Image.asset(
  'assets/images/dice/dice-$diceNumber.png',
  width: 200,
  height: 200,
)
```

### **SizedBox**
- Crée un espace vide de taille fixe
- Utilisé pour l'espacement entre widgets
```dart
SizedBox(height: 20)
```

### **OutlinedButton**
- Bouton avec bordure et fond transparent
- Propriétés : `onPressed`, `style`, `child`
```dart
OutlinedButton(
  onPressed: rollDice,
  style: TextButton.styleFrom(
    padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
    foregroundColor: Colors.white,
    textStyle: TextStyle(fontSize: 28),
  ),
  child: Text('Roll Dice'),
)
```

### **Text**
- Affiche du texte stylisé
```dart
Text(
  'Hello',
  style: TextStyle(fontSize: 35, color: Colors.white),
  textAlign: TextAlign.center,
)
```

---

## 🔧 Techniques Importantes

### 1. **Gestion d'État avec setState()**
- Méthode pour mettre à jour l'interface utilisateur
- Déclenche un nouveau build du widget
```dart
void rollDice() {
  setState(() {
    diceNumber = randomizer.nextInt(6) + 1;
  });
}
```

### 2. **Passage de Paramètres**
- Via le constructeur pour personnaliser les widgets
```dart
class GradientContainer extends StatelessWidget {
  const GradientContainer(this.colors, {super.key});
  final List<Color> colors;
}
```

### 3. **Utilisation de Variables Globales**
- `final randomizer = Random()` : instance réutilisable
- Évite de créer plusieurs instances

### 4. **Interpolation de Chaînes**
- Utilisation de `$variable` dans les strings
```dart
'assets/images/dice/dice-$diceNumber.png'
```

### 5. **Styling des Widgets**
- `TextStyle` : personnalisation du texte
- `TextButton.styleFrom()` : personnalisation des boutons
- `EdgeInsets` : gestion des marges et paddings

### 6. **Organisation du Code**
- Séparation en fichiers distincts par widget
- Import de fichiers locaux : `import 'dice_roller.dart';`
- Convention de nommage : fichiers en snake_case, classes en PascalCase

### 7. **Const Constructors**
- Utilisation du mot-clé `const` pour l'optimisation
- Widgets qui ne changeront jamais
```dart
const StyledText(this.text, {super.key});
const SizedBox(height: 20);
```

---

## 📦 Librairies Utilisées

- **dart:math** : Pour générer des nombres aléatoires avec `Random()`
- **flutter/material.dart** : Pour tous les widgets Material Design

---

## 🎨 Résultat Final

Application de lancement de dés avec :
- ✅ Interface avec gradient de couleurs
- ✅ Image de dé qui change dynamiquement
- ✅ Bouton interactif pour lancer le dé
- ✅ État géré avec StatefulWidget
- ✅ Code modulaire et réutilisable

---

## 💡 Points Clés à Retenir

1. **StatelessWidget** pour les composants immuables
2. **StatefulWidget** pour les composants interactifs
3. **setState()** pour mettre à jour l'interface
4. **const** pour optimiser les performances
5. Organisation en widgets réutilisables
6. Passage de paramètres via constructeurs
7. Material Design comme base de l'UI

---
---

# Part 2 - Application Quiz Flutter

## 📚 Vue d'ensemble
Cette partie approfondit les concepts de Flutter avec une application de quiz complète, illustrant la navigation entre écrans, la gestion d'état avancée, les callbacks, et l'utilisation de packages externes.

---

## 🎯 Concepts Avancés Abordés

### 1. **Navigation Multi-Écrans**
- Gestion de plusieurs écrans dans une seule application
- Changement dynamique d'écran basé sur l'état
- Trois écrans : Start, Questions, Results

### 2. **Gestion d'État Avancée**
- État partagé entre plusieurs écrans
- Gestion d'une liste de réponses utilisateur
- Réinitialisation de l'état

### 3. **Callbacks et Fonctions comme Paramètres**
- Passage de fonctions entre widgets parent et enfant
- Communication ascendante (child → parent)
```dart
final void Function() onPressed;
final void Function(String answer) onSelectAnswer;
```

### 4. **Architecture Multi-Fichiers**
- Organisation en dossiers : `components/`, `data/`, `models/`
- Séparation des responsabilités
- Modèles de données personnalisés

### 5. **Manipulation de Listes**
- Ajout dynamique : `list.add()`
- Filtrage : `.where()`
- Mapping : `.map()`
- Opérateur spread : `...list`

### 6. **Getters Personnalisés**
```dart
List<String> get shuffleList {
  List<String> listSuffle = List.of(answers);
  listSuffle.shuffle();
  return listSuffle;
}
```

### 7. **Expressions Ternaires pour la Navigation**
```dart
return activeScreen == 'start-screen'
    ? StartScreen(onPressed: switchScreen)
    : activeScreen == 'question-screen'
    ? QuestionScreen(onSelectAnswer: respondToAnswer)
    : ResultScreen(selectedAnswers: selectedAnswers);
```

---

## 🧩 Nouveaux Widgets et Leurs Utilisations

### **SizedBox avec double.infinity**
- Prend toute la largeur disponible
- Utile pour centrer le contenu horizontalement
```dart
SizedBox(
  width: double.infinity,
  child: Column(...)
)
```

### **ElevatedButton**
- Bouton avec élévation (ombre)
- Plus visible qu'un OutlinedButton
```dart
ElevatedButton(
  onPressed: onPressed,
  style: ElevatedButton.styleFrom(
    padding: EdgeInsets.only(top: 10, bottom: 10),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5),
    ),
  ),
  child: Text(text),
)
```

### **OutlinedButton.icon**
- Variante d'OutlinedButton avec icône
- Combinaison texte + icône
```dart
OutlinedButton.icon(
  icon: Icon(Icons.arrow_right_alt),
  onPressed: onPressed,
  label: Text('Start Quiz'),
)
```

### **TextButton.icon**
- Bouton de texte simple avec icône
```dart
TextButton.icon(
  onPressed: onRestart,
  label: Text('Restart Quiz'),
  icon: Icon(Icons.refresh),
)
```

### **SingleChildScrollView**
- Permet le défilement d'un contenu unique
- Essentiel pour éviter les débordements
```dart
SingleChildScrollView(
  child: Column(children: [...])
)
```

### **CircleAvatar**
- Widget circulaire pour afficher du contenu
- Utilisé ici pour numéroter les questions
```dart
CircleAvatar(
  radius: 15,
  backgroundColor: isCorrect ? Colors.green : Colors.red,
  child: Text('1'),
)
```

### **Expanded**
- Prend tout l'espace disponible dans un Row/Column
- Empêche les débordements de texte
```dart
Expanded(
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [...]
  ),
)
```

### **Row**
- Organise les widgets horizontalement
- Complémentaire à Column
```dart
Row(
  children: [CircleAvatar(...), SizedBox(...), Expanded(...)]
)
```

### **Image.asset avec Color**
- Applique un filtre de couleur à une image
```dart
Image.asset(
  'assets/images/quiz/quiz-logo.png',
  width: 300,
  color: Color.fromARGB(125, 255, 255, 255),
)
```

### **Container avec margin et padding**
- `margin` : espace extérieur
- `padding` : espace intérieur
```dart
Container(
  margin: EdgeInsets.symmetric(horizontal: 50, vertical: 2),
  padding: EdgeInsets.only(left: 25, right: 25),
  child: Widget(),
)
```

---

## 🔧 Techniques Avancées

### 1. **Gestion d'État Multi-Écrans**
```dart
class _QuizState extends State<Quiz> {
  String activeScreen = 'start-screen';
  List<String> selectedAnswers = [];
  
  void switchScreen() {
    setState(() {
      if (activeScreen == 'start-screen') {
        activeScreen = 'question-screen';
      } else {
        selectedAnswers = [];
        activeScreen = 'start-screen';
      }
    });
  }
}
```

### 2. **Callbacks pour Communication Parent-Enfant**
```dart
// Dans le parent
void respondToAnswer(String answer) {
  selectedAnswers.add(answer);
  if (selectedAnswers.length == questions.length) {
    setState(() {
      activeScreen = 'result-screen';
    });
  }
}

// Passage au child
QuestionScreen(onSelectAnswer: respondToAnswer)

// Dans le child
widget.onSelectAnswer(answer);
```

### 3. **Modèle de Données avec Getter**
```dart
class QuizQuestion {
  final String text;
  final List<String> answers;
  
  const QuizQuestion(this.text, this.answers);
  
  List<String> get shuffleList {
    List<String> listSuffle = List.of(answers);
    listSuffle.shuffle();
    return listSuffle;
  }
}
```

### 4. **Opérateur Spread pour Listes Dynamiques**
```dart
...currentQuestion.shuffleList.map(
  (el) => Container(
    child: AnswerButton(text: el, onPressed: () => nextQuestion(el)),
  ),
)
```

### 5. **Getters avec Logique Complexe**
```dart
List<Map<String, Object>> get summaryData {
  List<Map<String, Object>> summary = [];
  for (var i = 0; i < selectedAnswers.length; i++) {
    summary.add({
      'index': i,
      'question': questions[i].text,
      'correctAnswer': questions[i].answers[0],
      'userAnswer': selectedAnswers[i],
      'isCorrect': questions[i].answers[0] == selectedAnswers[i],
    });
  }
  return summary;
}
```

### 6. **Fonctions Locales dans build()**
```dart
@override
Widget build(BuildContext context) {
  int successfulAnswers() {
    return summaryData
        .where((data) => data['isCorrect'] as bool)
        .length;
  }
  return Widget(...);
}
```

### 7. **EdgeInsets Variants**
```dart
// Symétrique
EdgeInsets.symmetric(horizontal: 50, vertical: 2)

// Seulement certains côtés
EdgeInsets.only(top: 10, bottom: 10, left: 25, right: 25)

// Tous les côtés
EdgeInsets.all(20)

// LTRB (Left, Top, Right, Bottom)
EdgeInsets.fromLTRB(20, 10, 20, 10)
```

### 8. **Styling avec RoundedRectangleBorder**
```dart
shape: RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(5),
)
```

### 9. **Google Fonts Package**
- Utilisation de polices Google personnalisées
```dart
style: GoogleFonts.lato(
  color: Colors.white,
  fontSize: 24,
  fontWeight: FontWeight.bold,
)
```

### 10. **Manipulation de Types avec Cast**
```dart
(data['index'] as int) + 1
(data['isCorrect'] as bool)
data['question'] as String
```

---

## 📦 Packages Externes Utilisés

### **google_fonts**
- Permet d'utiliser des polices Google Fonts
- Installation : `flutter pub add google_fonts`
```dart
import 'package:google_fonts/google_fonts.dart';

GoogleFonts.lato(
  fontSize: 24,
  fontWeight: FontWeight.bold,
)
```

---

## 🏗️ Architecture de l'Application

### **Structure des Dossiers**
```
part2/
├── main.dart                    # Point d'entrée
├── quiz.dart                    # Widget principal avec gestion d'état
├── start_screen.dart           # Écran de démarrage
├── question_screen.dart        # Écran des questions
├── result_screen.dart          # Écran des résultats
├── components/
│   ├── answer_button.dart      # Bouton de réponse réutilisable
│   └── questions_summary.dart  # Résumé des réponses
├── models/
│   └── quiz_question.dart      # Modèle de question
└── data/
    └── questions.dart          # Données des questions
```

### **Flux de Navigation**
1. **StartScreen** → Bouton "Start Quiz"
2. **QuestionScreen** → Répond aux questions une par une
3. **ResultScreen** → Affiche les résultats avec option de redémarrage

### **Flux de Données**
```
Quiz (Parent)
  ↓ selectedAnswers
  ↓ switchScreen()
  ↓ respondToAnswer()
  ├─→ StartScreen
  ├─→ QuestionScreen
  │     ↑ onSelectAnswer callback
  └─→ ResultScreen
        ↑ onRestart callback
```

---

## 🎨 Résultat Final

Application de quiz complète avec :
- ✅ Écran de démarrage avec logo et bouton
- ✅ Questions avec réponses mélangées
- ✅ Écran de résultats avec score
- ✅ Résumé détaillé des réponses (correctes/incorrectes)
- ✅ Option de redémarrage du quiz
- ✅ Interface fluide avec défilement
- ✅ Utilisation de polices Google personnalisées

---

## 💡 Points Clés à Retenir - Part 2

1. **Navigation multi-écrans** avec gestion d'état conditionnelle
2. **Callbacks** pour la communication parent-enfant
3. **Opérateur spread (...)** pour insérer des listes dans des widgets
4. **Getters** pour calculer des données dérivées
5. **Map<String, Object>** pour structurer les données
6. **Packages externes** pour étendre les fonctionnalités
7. **SingleChildScrollView** pour gérer les débordements
8. **Modèles de données** pour organiser l'information
9. **Architecture en dossiers** pour la scalabilité
10. **Fonctions comme paramètres** pour la modularité

---

## 🆚 Comparaison Part 1 vs Part 2

| Aspect | Part 1 | Part 2 |
|--------|---------|---------|
| **Complexité** | Basique | Intermédiaire |
| **Écrans** | 1 écran | 3 écrans |
| **Navigation** | Aucune | Multi-écrans |
| **État** | Simple (1 variable) | Complexe (liste + écrans) |
| **Callbacks** | Aucun | Multiples |
| **Architecture** | Fichiers plats | Dossiers organisés |
| **Packages** | Aucun | google_fonts |
| **Widgets** | 11 types | 18+ types |
| **Modèles** | Aucun | QuizQuestion |
| **Données** | Intégrées | Fichier séparé |

---
---

# Part 3 - Application Expense Tracker (Gestionnaire de Dépenses)

## 📚 Vue d'ensemble
Cette partie présente une application avancée de gestion de dépenses, couvrant des concepts professionnels tels que les thèmes personnalisés, le design responsive, les opérations CRUD, et les interactions utilisateur complexes.

---

## 🎯 Concepts Professionnels Abordés

### 1. **Thèmes et Personnalisation Complète**
- ColorScheme personnalisé (clair et sombre)
- Thèmes globaux pour toute l'application
- Mode sombre automatique
- Cohérence visuelle avec Theme.of(context)

### 2. **Design Responsive**
- Adaptation aux différentes tailles d'écran
- MediaQuery pour obtenir les dimensions
- LayoutBuilder pour des layouts conditionnels
- Layouts différents pour mobile et tablette

### 3. **Opérations CRUD Complètes**
- **C**reate : Ajout de dépenses
- **R**ead : Affichage de la liste
- **U**pdate : Non implémenté ici
- **D**elete : Suppression avec undo

### 4. **Enum en Dart**
- Définition de types personnalisés
- Switch expressions modernes
- Utilisation avec pattern matching

### 5. **Packages Externes Avancés**
- **uuid** : Génération d'identifiants uniques
- **intl** : Formatage de dates internationalisé

### 6. **Gestion du Keyboard**
- viewInsets pour l'espace du clavier
- useSafeArea pour zones sécurisées
- isScrollControlled pour modal complet

### 7. **Architecture Séparée**
- Séparation Model-View-Controller (MVC-like)
- Classes utilitaires (ExpenseCrud, ExpenseController)
- Organisation en modules fonctionnels

---

## 🧩 Nouveaux Widgets et Leurs Utilisations

### **AppBar**
- Barre d'application en haut de l'écran
- Supporte titre et actions
```dart
AppBar(
  title: Text('Flutter Expenses Tracker'),
  actions: [
    IconButton(
      onPressed: _openAddExpenseOverlay,
      icon: Icon(Icons.add),
    ),
  ],
)
```

### **Card**
- Widget Material Design pour contenu groupé
- Élévation et ombre automatiques
```dart
Card(
  child: Padding(
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    child: Column(...),
  ),
)
```

### **ListView.builder**
- Liste performante avec construction paresseuse
- Optimisée pour grandes listes
```dart
ListView.builder(
  itemBuilder: (ctx, i) => ExpenseItem(expenses[i]),
  itemCount: expenses.length,
)
```

### **Dismissible**
- Widget glissable pour supprimer
- Geste swipe pour actions
- Background personnalisable
```dart
Dismissible(
  key: ValueKey(expenses[i]),
  direction: DismissDirection.endToStart,
  onDismissed: (direction) => onRemoveExpense(expenses[i]),
  background: Container(
    color: Theme.of(context).colorScheme.error,
    child: Icon(Icons.delete),
  ),
  child: ExpenseItem(expenses[i]),
)
```

### **showModalBottomSheet**
- Affiche un panneau modal en bas
- Pour formulaires ou options
```dart
showModalBottomSheet(
  useSafeArea: true,
  isScrollControlled: true,
  context: context,
  builder: (ctx) => ExpenseFactory(...),
)
```

### **TextField**
- Champ de saisie de texte
- Controller pour gérer la valeur
```dart
TextField(
  controller: _titleController,
  maxLength: 50,
  decoration: InputDecoration(labelText: 'Title'),
  keyboardType: TextInputType.text,
)
```

### **TextEditingController**
- Contrôleur pour TextField
- Accès et modification du texte
```dart
final _titleController = TextEditingController();
// Utilisation
_titleController.text
// N'oubliez pas de dispose()
```

### **DropdownButton**
- Menu déroulant de sélection
- Liste d'options prédéfinies
```dart
DropdownButton(
  value: _expenseController.category,
  items: Category.values.map(
    (category) => DropdownMenuItem(
      value: category,
      child: Text(category.name.toUpperCase()),
    ),
  ).toList(),
  onChanged: (value) => setState(() => category = value),
)
```

### **showDatePicker**
- Dialogue de sélection de date
- Retourne une Future<DateTime?>
```dart
final date = await showDatePicker(
  context: context,
  initialDate: DateTime.now(),
  firstDate: DateTime(DateTime.now().year - 1),
  lastDate: DateTime.now(),
)
```

### **AlertDialog**
- Dialogue d'alerte modal
- Pour confirmations et erreurs
```dart
AlertDialog(
  title: Text('Invalid Input'),
  content: Text('Please fill all fields correctly.'),
  actions: [
    TextButton(
      onPressed: () => Navigator.pop(context),
      child: Text('Okay'),
    ),
  ],
)
```

### **SnackBar**
- Notification en bas de l'écran
- Temporaire avec action possible
```dart
ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    content: Text('Expense deleted.'),
    duration: Duration(seconds: 3),
    action: SnackBarAction(
      label: 'Undo',
      onPressed: () => /* restaurer */,
    ),
  ),
)
```

### **MediaQuery**
- Accès aux informations de l'écran
- Dimensions, orientation, thème
```dart
final width = MediaQuery.of(context).size.width;
final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
final isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;
```

### **LayoutBuilder**
- Widget qui fournit les contraintes
- Pour layouts adaptatifs
```dart
LayoutBuilder(
  builder: (ctx, constraints) {
    final width = constraints.maxWidth;
    return width >= 600 ? TabletLayout() : MobileLayout();
  },
)
```

### **Spacer**
- Prend tout l'espace disponible
- Pour espacer des widgets
```dart
Row(
  children: [
    Text('Left'),
    Spacer(),
    Text('Right'),
  ],
)
```

### **FractionallySizedBox**
- Dimensionne en fraction du parent
- Utile pour barres de progression
```dart
FractionallySizedBox(
  heightFactor: 0.7, // 70% de la hauteur
  child: Container(...),
)
```

### **DecoratedBox**
- Applique une décoration sans être un Container
- Plus léger que Container
```dart
DecoratedBox(
  decoration: BoxDecoration(
    shape: BoxShape.rectangle,
    borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
    color: Colors.blue,
  ),
)
```

---

## 🔧 Techniques Avancées Professionnelles

### 1. **ColorScheme Personnalisé**
```dart
var kColorScheme = ColorScheme.fromSeed(
  seedColor: Colors.deepPurpleAccent,
);

var kColorSchemeDark = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: Colors.blueGrey,
);
```

### 2. **Thème Global avec copyWith()**
```dart
theme: ThemeData().copyWith(
  colorScheme: kColorScheme,
  appBarTheme: AppBarTheme().copyWith(
    backgroundColor: kColorScheme.onPrimaryContainer,
    foregroundColor: kColorScheme.primaryContainer,
  ),
  cardTheme: CardThemeData().copyWith(
    color: kColorScheme.secondaryContainer,
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  ),
  textTheme: ThemeData().textTheme.copyWith(
    titleLarge: TextStyle(
      fontWeight: FontWeight.bold,
      color: kColorScheme.onSecondaryContainer,
    ),
  ),
)
```

### 3. **Enum avec Extension**
```dart
enum Category {
  food,
  travel,
  leisure,
  work,
}

// Utilisation dans un getter
IconData get icon => switch (category) {
  Category.food => Icons.fastfood,
  Category.leisure => Icons.movie,
  Category.travel => Icons.flight_takeoff,
  Category.work => Icons.work,
};
```

### 4. **UUID pour Identifiants Uniques**
```dart
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Expense {
  final String id;
  
  Expense({...}) : id = uuid.v4();
}
```

### 5. **Formatage de Dates avec intl**
```dart
import 'package:intl/intl.dart';

final DateFormat formatter = DateFormat('dd/MM/yyyy');

String get formatDate => formatter.format(date);
```

### 6. **Constructeur Named avec Filtrage**
```dart
ExpenseBucket.forCategory(
  List<Expense> allExpenses,
  this.category,
) : expenses = allExpenses
        .where((expense) => expense.category == category)
        .toList();
```

### 7. **Fold pour Calculs Agrégés**
```dart
double get totalExpenses {
  return expenses
    .map((expense) => expense.amount)
    .fold(0.0, (previous, element) => previous + element);
}
```

### 8. **Layout Responsive Conditionnel**
```dart
Widget build(BuildContext context) {
  final width = MediaQuery.of(context).size.width;
  
  return width < 600
    ? Column(children: [...]) // Mobile
    : Row(children: [...]); // Tablette/Desktop
}
```

### 9. **Gestion du Clavier dans Modal**
```dart
Widget build(BuildContext context) {
  final keyBoardSpace = MediaQuery.of(context).viewInsets.bottom;
  
  return Padding(
    padding: EdgeInsets.fromLTRB(16, 16, 16, keyBoardSpace + 16),
    child: Column(...),
  );
}
```

### 10. **Navigation et Fermeture**
```dart
Navigator.pop(context); // Ferme l'écran actuel
Navigator.pop(ctx); // Ferme un dialog
```

### 11. **ScaffoldMessenger pour Messages**
```dart
ScaffoldMessenger.of(context).clearSnackBars();
ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(content: Text('Message')),
);
```

### 12. **Validation de Formulaire**
```dart
bool isValid() {
  final enteredTitle = _titleController.text.trim();
  final enteredAmount = double.tryParse(_amountController.text);
  final amountIsValid = enteredAmount != null && enteredAmount > 0;
  final dateIsValid = date != null;
  
  return enteredTitle.isNotEmpty && amountIsValid && dateIsValid;
}
```

### 13. **Insert avec Index (Undo)**
```dart
void removeExpense(Expense expense) {
  var index = _expenses.indexOf(expense);
  _expenses.remove(expense);
  
  // Undo
  _expenses.insert(index, expense);
}
```

### 14. **Async/Await pour Dialogues**
```dart
void _showDatePicker() async {
  final date = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(DateTime.now().year - 1),
    lastDate: DateTime.now(),
  );
  setState(() {
    _expenseController.date = date;
  });
}
```

### 15. **Theme.of(context) pour Cohérence**
```dart
Text(
  expense.title,
  style: Theme.of(context).textTheme.titleLarge,
)

Container(
  color: Theme.of(context).colorScheme.error,
)
```

### 16. **withValues() pour Opacité (Flutter 3.27+)**
```dart
color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3)
```

### 17. **Orientation Lock (Optionnel)**
```dart
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((fn) => runApp(MyApp()));
}
```

---

## 📦 Packages Externes Utilisés

### **uuid**
- Génération d'identifiants uniques universels
- Installation : `flutter pub add uuid`
```dart
import 'package:uuid/uuid.dart';

const uuid = Uuid();
String id = uuid.v4();
```

### **intl**
- Internationalisation et formatage
- Installation : `flutter pub add intl`
```dart
import 'package:intl/intl.dart';

final DateFormat formatter = DateFormat('dd/MM/yyyy');
String formatted = formatter.format(DateTime.now());
```

### **flutter/services.dart**
- Services système (orientation, etc.)
```dart
import 'package:flutter/services.dart';

SystemChrome.setPreferredOrientations([...]);
```

---

## 🏗️ Architecture de l'Application

### **Structure des Dossiers**
```
part3/
├── main.dart                           # Configuration thème + point d'entrée
├── models/
│   ├── expense.dart                    # Modèle Expense
│   ├── enum/
│   │   └── category.enum.dart         # Enum Category
│   └── data/
│       └── expenses-list.dart         # Données initiales
├── widgets/
│   ├── expenses.dart                  # Widget principal avec état
│   ├── Expense_bucket.dart            # Agrégation par catégorie
│   ├── chart/
│   │   ├── chart.dart                 # Graphique des dépenses
│   │   └── chart_bar.dart             # Barre du graphique
│   └── expenses_list/
│       ├── expense_list.dart          # Liste avec Dismissible
│       ├── expense_item.dart          # Item de la liste
│       ├── expense_factory.dart       # Formulaire d'ajout
│       ├── expense_controller.dart    # Contrôleur de formulaire
│       └── expense_crud.dart          # Opérations CRUD
```

### **Flux de Données**
```
main.dart
  ↓ Theme
Expenses (StatefulWidget)
  ├─→ AppBar (avec bouton +)
  ├─→ Chart (graphique par catégorie)
  └─→ ExpenseList
        ├─→ ListView.builder
        └─→ Dismissible
              └─→ ExpenseItem

ExpenseFactory (Modal)
  ├─→ TextField (title)
  ├─→ TextField (amount)
  ├─→ DropdownButton (category)
  ├─→ DatePicker (date)
  └─→ Buttons (Cancel / Save)
```

### **Pattern MVC-Like**
- **Model** : `Expense`, `ExpenseBucket`, `Category`
- **View** : `ExpenseList`, `ExpenseItem`, `Chart`
- **Controller** : `ExpenseController`, `ExpenseCrud`

---

## 🎨 Résultat Final

Application de gestion de dépenses complète avec :
- ✅ Interface professionnelle avec thèmes clair/sombre
- ✅ Design responsive (mobile et tablette)
- ✅ Ajout de dépenses via formulaire modal
- ✅ Suppression par swipe avec undo
- ✅ Graphique visuel par catégorie
- ✅ Validation de formulaire
- ✅ Gestion du clavier
- ✅ Messages de feedback (SnackBar)
- ✅ Formatage international des dates
- ✅ Architecture modulaire et maintenable

---

## 💡 Points Clés à Retenir - Part 3

1. **ColorScheme** pour cohérence des couleurs
2. **Theme.of(context)** pour accès au thème global
3. **MediaQuery** pour informations d'écran et responsive
4. **LayoutBuilder** pour layouts conditionnels
5. **ListView.builder** pour listes performantes
6. **Dismissible** pour interactions swipe
7. **showModalBottomSheet** pour formulaires modaux
8. **TextEditingController** pour gérer les inputs
9. **Async/Await** pour dialogues et pickers
10. **SnackBar** pour feedback utilisateur
11. **Enum** pour types métier
12. **uuid** et **intl** pour fonctionnalités avancées
13. **Architecture MVC** pour séparation des responsabilités
14. **Validation** avant opérations critiques
15. **Undo** pour améliorer l'expérience utilisateur

---

## 🆚 Comparaison Part 1 vs Part 2 vs Part 3

| Aspect | Part 1 | Part 2 | Part 3 |
|--------|---------|---------|---------|
| **Complexité** | Basique | Intermédiaire | Avancé |
| **Écrans** | 1 écran | 3 écrans | 1 écran + modals |
| **Navigation** | Aucune | Multi-écrans | Modals + Dialogs |
| **État** | Simple | Liste + écrans | Liste + CRUD |
| **Callbacks** | Aucun | Multiples | Multiples + async |
| **Architecture** | Fichiers plats | Dossiers | MVC-like |
| **Packages** | Aucun | google_fonts | uuid, intl |
| **Widgets** | 11 types | 18+ types | 30+ types |
| **Modèles** | Aucun | 1 modèle | 2+ modèles + Enum |
| **Thème** | Couleurs basiques | Aucun | Thème complet |
| **Responsive** | Non | Non | Oui (mobile/tablette) |
| **CRUD** | Non | Read only | Create + Delete |
| **Validation** | Non | Basique | Complète |
| **Feedback** | Non | Non | SnackBar + Dialogs |
| **Formatage** | Basique | Aucun | intl (dates) |
| **UX** | Simple | Moyenne | Professionnelle |

---

## 🎓 Concepts Clés par Niveau

### **Débutant (Part 1)**
- StatelessWidget / StatefulWidget
- setState()
- Widgets de base
- Layout simple

### **Intermédiaire (Part 2)**
- Navigation multi-écrans
- Callbacks
- Packages externes
- Modèles de données
- Opérateur spread

### **Avancé (Part 3)**
- Thèmes personnalisés
- Design responsive
- CRUD complet
- Architecture MVC
- Async/Await
- Validation
- UX professionnelle
- Formatage international

---

# 🎯 Gestion d'État avec Riverpod

## 📚 Vue d'ensemble
Riverpod est une solution moderne de gestion d'état pour Flutter, offrant une alternative robuste et type-safe à Provider et autres solutions de state management.

---

## 🔑 Pourquoi Riverpod ?

### Avantages Principaux
✅ **Compile-time safety** : Détection des erreurs à la compilation  
✅ **Pas de BuildContext requis** : Accès global aux providers  
✅ **Testabilité** : Mock et test faciles  
✅ **Composabilité** : Providers dépendants  
✅ **Performance** : Rebuilds optimisés automatiquement  
✅ **Pas de InheritedWidget** : Architecture simplifiée  

---

## 📦 Types de Providers Utilisés dans le Projet

### 1. **Provider** (Données Immuables)
**Usage :** Données statiques qui ne changent jamais

```dart
// Provider pour une liste de repas
final mealsProvider = Provider((ref) => dummyMeals);
```

**Caractéristiques :**
- Lecture seule
- Calculé une seule fois
- Idéal pour constantes et configurations

---

### 2. **StateNotifierProvider** (État Complexe)
**Usage :** État avec logique métier

**Exemple : Gestion des Favoris**
```dart
class FavoritesMealNotifier extends StateNotifier<List<Meal>> {
  FavoritesMealNotifier() : super([]);

  void toggleFavorite(Meal meal, context) {
    if (isFavorite(meal)) {
      state = state.where((m) => m.id != meal.id).toList();
    } else {
      state = [...state, meal];
    }
    // Afficher message
  }

  bool isFavorite(Meal meal) => state.contains(meal);
}

final favoritesMealsProvider = StateNotifierProvider<FavoritesMealNotifier, List<Meal>>(
  (ref) => FavoritesMealNotifier(),
);
```

**Exemple : Gestion des Filtres**
```dart
class FilterNotifier extends StateNotifier<Map<Filter, bool>> {
  FilterNotifier() : super({
    Filter.glutenFree: false,
    Filter.lactoseFree: false,
    Filter.vegetarian: false,
    Filter.vegan: false,
  });

  void setFilter(Filter filter, bool isActive) {
    state = {...state, filter: isActive};
  }
}

final filterMealsProvider = StateNotifierProvider<FilterNotifier, Map<Filter, bool>>(
  (ref) => FilterNotifier(),
);
```

**Caractéristiques :**
- Logique métier encapsulée
- État immutable
- Méthodes personnalisées
- Facile à tester

---

### 3. **Provider.family** (Providers Paramétrés)
**Usage :** Provider qui prend un paramètre

```dart
final isMealFavoriteProvider = Provider.family<bool, Meal>(
  (ref, meal) {
    final favoriteMeals = ref.watch(favoritesMealsProvider);
    return favoriteMeals.contains(meal);
  },
);

// Utilisation
final isFavorite = ref.watch(isMealFavoriteProvider(meal));
```

**Caractéristiques :**
- Réutilisable avec différents paramètres
- Cache par paramètre
- Optimisation automatique

---

### 4. **Provider Combiné** (Dépendances)
**Usage :** Provider qui dépend d'autres providers

```dart
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

**Caractéristiques :**
- Combine plusieurs sources
- Recalcule automatiquement
- Séparation des responsabilités

---

## 🎨 Utilisation dans les Widgets

### ConsumerWidget
**Remplace StatelessWidget pour accéder aux providers**

```dart
class CategoriesScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filteredMeals = ref.watch(filteredMealsProvider);
    
    return GridView.builder(
      itemCount: filteredMeals.length,
      itemBuilder: (_, index) => MealItem(meal: filteredMeals[index]),
    );
  }
}
```

### ConsumerStatefulWidget
**Remplace StatefulWidget quand on a besoin d'état local + providers**

```dart
class FiltersScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends ConsumerState<FiltersScreen> {
  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: ref.watch(filterGlutenProvider),
      onChanged: (value) {
        ref.read(filterMealsProvider.notifier).setFilter(Filter.glutenFree, value);
      },
    );
  }
}
```

---

## 🔄 ref.watch() vs ref.read() vs ref.listen()

| Méthode | Usage | Rebuild | Contexte |
|---------|-------|---------|----------|
| `ref.watch()` | Lire et écouter | ✅ Oui | Dans `build()` |
| `ref.read()` | Lire une fois | ❌ Non | Dans callbacks |
| `ref.listen()` | Écouter sans rebuild | ❌ Non | Side effects |

**Exemples :**
```dart
@override
Widget build(BuildContext context, WidgetRef ref) {
  // ✅ watch() - Afficher des données qui changent
  final meals = ref.watch(mealsProvider);
  
  // ✅ listen() - Effets de bord (SnackBar, navigation)
  ref.listen<List<Meal>>(favoritesMealsProvider, (previous, next) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Favoris mis à jour!')),
    );
  });
  
  return ElevatedButton(
    // ✅ read() - Actions (pas besoin de rebuild)
    onPressed: () {
      ref.read(favoritesMealsProvider.notifier).toggleFavorite(meal, context);
    },
    child: Text('Toggle Favorite'),
  );
}
```

---

## 🏗️ Architecture de l'Application avec Riverpod

### Structure des Providers
```
providers/
├── meal.provider.dart          → Provider (données statiques)
├── filters.provider.dart       → StateNotifierProvider (filtres)
└── favorites.provider.dart     → StateNotifierProvider (favoris)
```

### Flux de Données
```
mealsProvider (Liste complète de repas)
      ↓
filterMealsProvider (État des filtres)
      ↓
filteredMealsProvider (Liste filtrée combinée)
      ↓
CategoriesScreen (Affichage avec ConsumerWidget)
```

### Interaction Utilisateur
```
User Toggle Filter
      ↓
ref.read(filterMealsProvider.notifier).setFilter(...)
      ↓
State Change dans FilterNotifier
      ↓
ref.watch(filteredMealsProvider) détecte le changement
      ↓
Widget Rebuild automatiquement
      ↓
UI mise à jour
```

---

## 💡 Bonnes Pratiques Riverpod

### ✅ À Faire
1. Utiliser `ConsumerWidget` au lieu de `StatelessWidget` pour accéder aux providers
2. Utiliser `ref.watch()` dans `build()` pour écouter les changements
3. Utiliser `ref.read()` dans les callbacks et event handlers
4. Séparer la logique métier dans des `StateNotifier`
5. Utiliser `.family` pour les providers paramétrés
6. Combiner les providers pour des calculs dérivés

### ❌ À Éviter
1. ❌ Ne jamais utiliser `ref.read()` dans `build()`
2. ❌ Ne pas muter `state` directement dans StateNotifier
3. ❌ Ne pas oublier `.toList()` après `.where()`
4. ❌ Ne pas créer de providers dans `build()`
5. ❌ Ne pas oublier `ProviderScope` à la racine

---

## 📚 Pour Aller Plus Loin

### Guide Complet
📖 **Consultez le guide détaillé :** [`RIVERPOD_GUIDE.md`](./RIVERPOD_GUIDE.md)

Ce guide complet couvre :
- Tous les types de providers (StateProvider, FutureProvider, StreamProvider, etc.)
- Fonctionnalités avancées (AutoDispose, KeepAlive, Select, etc.)
- Patterns et exemples pratiques
- Testing avec Riverpod
- Code Generation
- Ressources et liens officiels

### Liens Utiles
- **Documentation officielle :** https://riverpod.dev/
- **GitHub Repository :** https://github.com/rrousselGit/riverpod
- **Exemples officiels :** https://github.com/rrousselGit/riverpod/tree/master/examples
- **Pub.dev Package :** https://pub.dev/packages/flutter_riverpod

---

## 🎯 Avantages Riverpod vs setState

| Aspect | setState | Riverpod |
|--------|----------|----------|
| Portée | Widget local | Global |
| Partage d'état | Difficile | Facile |
| Testabilité | Complexe | Simple |
| Performance | Rebuilds inutiles | Optimisé |
| Code | Verbeux | Concis |
| Type safety | ❌ | ✅ |
| Cache | ❌ | ✅ |

---

**Document mis à jour avec Riverpod**  
**Dernière mise à jour : Novembre 2025**

---

