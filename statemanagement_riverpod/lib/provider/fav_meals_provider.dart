import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/meal.dart';

class FavoriteMealsNotifier extends StateNotifier<List<Meal>> {
  FavoriteMealsNotifier() : super([]);

  bool toggleMealFavoriteStatus(Meal meal) {
    //first check if meal is already in favroite list
    final isFavorite = state.contains(meal);

    //if isFavorite is true than keep the meals that doesn't matches to the already present meals
    // in the state
    if (isFavorite) {
      state = state.where((m) => m.id != meal.id).toList();

      return false;
    } else {
      //if meal is not present in the favroite list get all the previously present meal list
      // using spread operator and add the meal that are added to favroite.
      state = [...state, meal];
      return true;
    }
  }
}

final favoriteMealsProvider =
    StateNotifierProvider<FavoriteMealsNotifier, List<Meal>>(
        (ref) => FavoriteMealsNotifier());
