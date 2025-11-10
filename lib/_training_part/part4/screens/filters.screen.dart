
import 'package:flutter/material.dart';

import '../models/filter_option.model.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key, required this.filterOptions});

  final Map<FilterOption, bool> filterOptions;

  @override
  State<FiltersScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FiltersScreen> {
  // late bool _glutenFreeFilterSet = widget.filterOptions[FilterOption.glutenFree]!;
  // late bool _lactoseFreeFilterSet = widget.filterOptions[FilterOption.lactoseFree]!;
  // late bool _vegetarianFilterSet = widget.filterOptions[FilterOption.vegetarian]!;
  // late bool _veganFilterSet = widget.filterOptions[FilterOption.vegan]!;
  bool _glutenFreeFilterSet = false;
  bool _lactoseFreeFilterSet = false;
  bool _vegetarianFilterSet = false;
  bool _veganFilterSet = false;

  @override
  void initState() {
    super.initState();
    _glutenFreeFilterSet = widget.filterOptions[FilterOption.glutenFree]!;
    _lactoseFreeFilterSet = widget.filterOptions[FilterOption.lactoseFree]!;
    _vegetarianFilterSet = widget.filterOptions[FilterOption.vegetarian]!;
    _veganFilterSet = widget.filterOptions[FilterOption.vegan]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vos Filtres'),
      ),
      // drawer: MainDrawer(onSelectScreen: (identifier){
      //   Navigator.of(context).pop();
      //   if(identifier=='meals'){
      //     Navigator.of(context).pushReplacementNamed('/');
      //   }
      // }),
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (bool didPop, dynamic result) {
          if (didPop) return;
          Navigator.of(context).pop({
            FilterOption.glutenFree: _glutenFreeFilterSet,
            FilterOption.lactoseFree: _lactoseFreeFilterSet,
            FilterOption.vegetarian: _vegetarianFilterSet,
            FilterOption.vegan: _veganFilterSet,
          });
        },
        child: Column(
          children: [
            SwitchListTile(
              value: _glutenFreeFilterSet,
              title: Text(
                'Sans Gluten',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge!.copyWith(color: Theme.of(context).colorScheme.onSurface),
              ),
              subtitle: Text(
                'Seulement les repas sans gluten',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium!.copyWith(color: Theme.of(context).colorScheme.onSurface),
              ),
              activeThumbColor: Theme.of(context).colorScheme.secondary,
              contentPadding: const EdgeInsets.only(
                left: 34,
                right: 22,
              ),
              onChanged: (isChecked) {
                setState(() {
                  _glutenFreeFilterSet = isChecked;
                });
              },
            ),
            SwitchListTile(
              value: _lactoseFreeFilterSet,
              title: Text(
                'Sans Lactose',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge!.copyWith(color: Theme.of(context).colorScheme.onSurface),
              ),
              subtitle: Text(
                'Seulement les repas sans lactose',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium!.copyWith(color: Theme.of(context).colorScheme.onSurface),
              ),
              activeThumbColor: Theme.of(context).colorScheme.secondary,
              contentPadding: const EdgeInsets.only(
                left: 34,
                right: 22,
              ),
              onChanged: (isChecked) {
                setState(() {
                  _lactoseFreeFilterSet = isChecked;
                });
              },
            ),
            SwitchListTile(
              value: _vegetarianFilterSet,
              title: Text(
                'Végétarien',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge!.copyWith(color: Theme.of(context).colorScheme.onSurface),
              ),
              subtitle: Text(
                'Liste des repas végétariens',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium!.copyWith(color: Theme.of(context).colorScheme.onSurface),
              ),
              activeThumbColor: Theme.of(context).colorScheme.secondary,
              contentPadding: const EdgeInsets.only(
                left: 34,
                right: 22,
              ),
              onChanged: (isChecked) {
                setState(() {
                  _vegetarianFilterSet = isChecked;
                });
              },
            ),
            SwitchListTile(
              value: _veganFilterSet,
              title: Text(
                'Végan',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge!.copyWith(color: Theme.of(context).colorScheme.onSurface),
              ),
              subtitle: Text(
                'Liste des repas végan',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium!.copyWith(color: Theme.of(context).colorScheme.onSurface),
              ),
              activeThumbColor: Theme.of(context).colorScheme.secondary,
              contentPadding: const EdgeInsets.only(
                left: 34,
                right: 22,
              ),
              onChanged: (isChecked) {
                setState(() {
                  _veganFilterSet = isChecked;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
