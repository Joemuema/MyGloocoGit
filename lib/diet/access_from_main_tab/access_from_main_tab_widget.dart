import '/backend/backend.dart';
import '/components/meal_food_item_widget.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'access_from_main_tab_model.dart';
export 'access_from_main_tab_model.dart';

class AccessFromMainTabWidget extends StatefulWidget {
  const AccessFromMainTabWidget({
    super.key,
    this.updatedFoodList,
  });

  final List<FilteredFoodRecord>? updatedFoodList;

  @override
  State<AccessFromMainTabWidget> createState() =>
      _AccessFromMainTabWidgetState();
}

class _AccessFromMainTabWidgetState extends State<AccessFromMainTabWidget> {
  late AccessFromMainTabModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AccessFromMainTabModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.updatedFoodList =
          widget.updatedFoodList!.toList().cast<FilteredFoodRecord>();
      setState(() {});
    });

    _model.foodentrysTextController ??= TextEditingController();
    _model.foodentrysFocusNode ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () async {
            Navigator.pop(context);
          },
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).primaryBackground,
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 7.0,
                      color: Color(0x33000000),
                      offset: Offset(
                        0.0,
                        -2.0,
                      ),
                    )
                  ],
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(0.0),
                    bottomRight: Radius.circular(0.0),
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 5.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 60.0,
                              height: 3.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).primary,
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 5.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  10.0, 0.0, 10.0, 0.0),
                              child: Form(
                                key: _model.formKey1,
                                autovalidateMode: AutovalidateMode.always,
                                child: FlutterFlowChoiceChips(
                                  options: const [
                                    ChipData(
                                        'Breakfast', Icons.emoji_food_beverage),
                                    ChipData('Lunch', Icons.lunch_dining),
                                    ChipData(
                                        'Supper', Icons.food_bank_outlined),
                                    ChipData('Snack')
                                  ],
                                  onChanged: (val) => setState(() => _model
                                      .choiceChipsValue = val?.firstOrNull),
                                  selectedChipStyle: ChipStyle(
                                    backgroundColor:
                                        FlutterFlowTheme.of(context).primary,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Readex Pro',
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          letterSpacing: 0.0,
                                        ),
                                    iconColor: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    iconSize: 18.0,
                                    elevation: 4.0,
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  unselectedChipStyle: ChipStyle(
                                    backgroundColor:
                                        FlutterFlowTheme.of(context).alternate,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Readex Pro',
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          letterSpacing: 0.0,
                                        ),
                                    iconColor: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    iconSize: 18.0,
                                    elevation: 0.0,
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  chipSpacing: 2.0,
                                  rowSpacing: 7.0,
                                  multiselect: false,
                                  alignment: WrapAlignment.center,
                                  controller:
                                      _model.choiceChipsValueController ??=
                                          FormFieldController<List<String>>(
                                    [],
                                  ),
                                  wrapped: false,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          FlutterFlowIconButton(
                            borderColor: FlutterFlowTheme.of(context).primary,
                            borderRadius: 20.0,
                            borderWidth: 1.0,
                            buttonSize: 40.0,
                            icon: Icon(
                              Icons.search_sharp,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 24.0,
                            ),
                            onPressed: () async {
                              context.pushNamed(
                                'Foodsearch',
                                queryParameters: {
                                  'currentFoodList': serializeParam(
                                    _model.updatedFoodList,
                                    ParamType.Document,
                                    isList: true,
                                  ),
                                  'location': serializeParam(
                                    'Sheet',
                                    ParamType.String,
                                  ),
                                }.withoutNulls,
                                extra: <String, dynamic>{
                                  'currentFoodList': _model.updatedFoodList,
                                },
                              );

                              Navigator.pop(context);
                            },
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                10.0, 10.0, 10.0, 7.0),
                            child: Text(
                              'You could also search from our food database',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 14.95,
                                    letterSpacing: 0.0,
                                  ),
                            ),
                          ),
                        ],
                      ),
                      if (!(_model.updatedFoodList.isNotEmpty))
                        Form(
                          key: _model.formKey2,
                          autovalidateMode: AutovalidateMode.disabled,
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                16.0, 16.0, 16.0, 16.0),
                            child: TextFormField(
                              controller: _model.foodentrysTextController,
                              focusNode: _model.foodentrysFocusNode,
                              textCapitalization: TextCapitalization.sentences,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelStyle: FlutterFlowTheme.of(context)
                                    .bodyLarge
                                    .override(
                                      fontFamily: 'Readex Pro',
                                      letterSpacing: 0.0,
                                    ),
                                hintText:
                                    'Your food goes here(estimation cannot be done for manual inputs)',
                                hintStyle: FlutterFlowTheme.of(context)
                                    .labelLarge
                                    .override(
                                      fontFamily: 'Readex Pro',
                                      letterSpacing: 0.0,
                                    ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).accent1,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).primary,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).error,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).error,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                filled: true,
                                fillColor: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                contentPadding: const EdgeInsetsDirectional.fromSTEB(
                                    24.0, 24.0, 20.0, 24.0),
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Roboto',
                                    fontSize: 17.0,
                                    letterSpacing: 0.0,
                                  ),
                              maxLines: 4,
                              cursorColor: FlutterFlowTheme.of(context).primary,
                              validator: _model
                                  .foodentrysTextControllerValidator
                                  .asValidator(context),
                            ),
                          ),
                        ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          if (_model.updatedFoodList.isNotEmpty)
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 10.0, 0.0, 0.0),
                                child: Builder(
                                  builder: (context) {
                                    final foodList =
                                        _model.updatedFoodList.toList();

                                    return ListView.builder(
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount: foodList.length,
                                      itemBuilder: (context, foodListIndex) {
                                        final foodListItem =
                                            foodList[foodListIndex];
                                        return Padding(
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  10.0, 5.0, 10.0, 5.0),
                                          child: wrapWithModel(
                                            model: _model.mealFoodItemModels
                                                .getModel(
                                              foodListItem.reference.id,
                                              foodListIndex,
                                            ),
                                            updateCallback: () =>
                                                setState(() {}),
                                            child: MealFoodItemWidget(
                                              key: Key(
                                                'Key84g_${foodListItem.reference.id}',
                                              ),
                                              foodItem: foodListItem,
                                              removeFoodItem: () async {
                                                _model
                                                    .removeFromUpdatedFoodList(
                                                        foodListItem);
                                                setState(() {});
                                              },
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            16.0, 16.0, 16.0, 16.0),
                        child: FFButtonWidget(
                          onPressed: () async {
                            if (_model.updatedFoodList.isNotEmpty) {
                              if (_model.formKey1.currentState == null ||
                                  !_model.formKey1.currentState!.validate()) {
                                return;
                              }

                              await MealsRecord.collection.doc().set({
                                ...createMealsRecordData(
                                  type: _model.choiceChipsValue,
                                  date: functions.getDate(getCurrentTimestamp),
                                  userID: FFAppState().UserID,
                                ),
                                ...mapToFirestore(
                                  {
                                    'meals': _model.updatedFoodList
                                        .map((e) => e.food)
                                        .toList(),
                                  },
                                ),
                              });
                              Navigator.pop(context);
                            } else {
                              if (_model.formKey1.currentState == null ||
                                  !_model.formKey1.currentState!.validate()) {
                                return;
                              }
                              if (_model.formKey2.currentState == null ||
                                  !_model.formKey2.currentState!.validate()) {
                                return;
                              }

                              await MealsRecord.collection.doc().set({
                                ...createMealsRecordData(
                                  type: _model.choiceChipsValue,
                                  date: functions.getDate(getCurrentTimestamp),
                                  userID: FFAppState().UserID,
                                ),
                                ...mapToFirestore(
                                  {
                                    'meals': [
                                      _model.foodentrysTextController.text
                                    ],
                                  },
                                ),
                              });
                              Navigator.pop(context);
                            }

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Successfully added to plate',
                                  style: TextStyle(
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                  ),
                                ),
                                duration: const Duration(milliseconds: 2650),
                                backgroundColor:
                                    FlutterFlowTheme.of(context).secondary,
                              ),
                            );
                          },
                          text: 'Record meal',
                          options: FFButtonOptions(
                            width: double.infinity,
                            height: 50.0,
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: FlutterFlowTheme.of(context).primary,
                            textStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                                  fontFamily: 'Roboto',
                                  color: Colors.white,
                                  letterSpacing: 0.0,
                                ),
                            elevation: 2.0,
                            borderSide: const BorderSide(
                              color: Colors.transparent,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
