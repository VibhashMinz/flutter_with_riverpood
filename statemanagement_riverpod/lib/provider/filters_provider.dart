import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'meals_provider.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class FilterMealsNotifier extends StateNotifier<Map<Filter, bool>> {
  FilterMealsNotifier()
      : super({
          Filter.glutenFree: false,
          Filter.lactoseFree: false,
          Filter.vegetarian: false,
          Filter.vegan: false
        });

  void setFilters(Map<Filter, bool> chosenFilters) {
    state = chosenFilters;
  }

  void setFilter(Filter filter, bool isActive) {
    // state[filter] = isActive; Its not allowed!=> since we are mutating the state in memory
    /// what you should do instead is you should set the state to a new map.
    /// And that should, in the end,
    /// be your old map with the updated key.
    /// And one way of creating such a new map here
    /// is to copy the existing map
    state = {...state, filter: isActive};
  }
}

final filterMealsProvider =
    StateNotifierProvider<FilterMealsNotifier, Map<Filter, bool>>(
        (ref) => FilterMealsNotifier());

final filteredMealsProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final activeFilters = ref.watch(filterMealsProvider);
  return meals.where((meal) {
    if (activeFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
      return false;
    }
    if (activeFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
      return false;
    }
    if (activeFilters[Filter.vegetarian]! && !meal.isVegetarian) {
      return false;
    }
    if (activeFilters[Filter.vegan]! && !meal.isVegan) {
      return false;
    }
    return true;
  }).toList();
});
