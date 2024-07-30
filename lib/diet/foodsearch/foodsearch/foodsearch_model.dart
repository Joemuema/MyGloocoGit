import '/backend/backend.dart';
import '/diet/foodsearch/foodsearchcomponent/foodsearchcomponent_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:math';
import 'foodsearch_widget.dart' show FoodsearchWidget;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:text_search/text_search.dart';

class FoodsearchModel extends FlutterFlowModel<FoodsearchWidget> {
  ///  Local state fields for this page.

  List<FoodRecord> searchFoodList = [];
  void addToSearchFoodList(FoodRecord item) => searchFoodList.add(item);
  void removeFromSearchFoodList(FoodRecord item) => searchFoodList.remove(item);
  void removeAtIndexFromSearchFoodList(int index) =>
      searchFoodList.removeAt(index);
  void insertAtIndexInSearchFoodList(int index, FoodRecord item) =>
      searchFoodList.insert(index, item);
  void updateSearchFoodListAtIndex(int index, Function(FoodRecord) updateFn) =>
      searchFoodList[index] = updateFn(searchFoodList[index]);

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for Searchbar widget.
  FocusNode? searchbarFocusNode;
  TextEditingController? searchbarTextController;
  String? Function(BuildContext, String?)? searchbarTextControllerValidator;
  List<FoodRecord> simpleSearchResults = [];

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
    searchbarFocusNode?.dispose();
    searchbarTextController?.dispose();
  }
}
