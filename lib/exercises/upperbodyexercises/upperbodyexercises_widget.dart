import '/backend/backend.dart';
import '/exercises/strengthexercises/strengthexercises_widget.dart';
import '/exercises/upperbodycomponent/upperbodycomponent_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'upperbodyexercises_model.dart';
export 'upperbodyexercises_model.dart';

class UpperbodyexercisesWidget extends StatefulWidget {
  const UpperbodyexercisesWidget({super.key});

  @override
  State<UpperbodyexercisesWidget> createState() =>
      _UpperbodyexercisesWidgetState();
}

class _UpperbodyexercisesWidgetState extends State<UpperbodyexercisesWidget> {
  late UpperbodyexercisesModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => UpperbodyexercisesModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primary,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 60.0,
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
              size: 30.0,
            ),
            onPressed: () async {
              context.pop();
            },
          ),
          title: Text(
            'Upper Body Exercises',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'Inter',
                  color: Colors.white,
                  fontSize: 22.0,
                  letterSpacing: 0.0,
                ),
          ),
          actions: const [],
          centerTitle: true,
          elevation: 2.0,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 0.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'Upper body exercises',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Readex Pro',
                            fontSize: 16.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(10.0, 5.0, 10.0, 0.0),
                child: Container(
                  width: double.infinity,
                  height: 109.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(5.0, 5.0, 0.0, 0.0),
                    child: Text(
                      'Upper body exercises target the muscles in the chest, back, shoulders, and arms. These exercises are crucial for building upper body strength, improving posture, and enhancing overall functional fitness. ',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Readex Pro',
                            fontSize: 15.0,
                            letterSpacing: 0.0,
                          ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 0.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'Categories',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Readex Pro',
                            fontSize: 16.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
              ),
              StreamBuilder<List<StrengthexercisesRecord>>(
                stream: queryStrengthexercisesRecord(
                  queryBuilder: (strengthexercisesRecord) =>
                      strengthexercisesRecord.where(
                    'Type',
                    isEqualTo: 'upperbody',
                  ),
                ),
                builder: (context, snapshot) {
                  // Customize what your widget looks like when it's loading.
                  if (!snapshot.hasData) {
                    return Center(
                      child: SizedBox(
                        width: 50.0,
                        height: 50.0,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            FlutterFlowTheme.of(context).primary,
                          ),
                        ),
                      ),
                    );
                  }
                  List<StrengthexercisesRecord>
                      columnStrengthexercisesRecordList = snapshot.data!;

                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    children:
                        List.generate(columnStrengthexercisesRecordList.length,
                            (columnIndex) {
                      final columnStrengthexercisesRecord =
                          columnStrengthexercisesRecordList[columnIndex];
                      return InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          await showModalBottomSheet(
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (context) {
                              return GestureDetector(
                                onTap: () => _model.unfocusNode.canRequestFocus
                                    ? FocusScope.of(context)
                                        .requestFocus(_model.unfocusNode)
                                    : FocusScope.of(context).unfocus(),
                                child: Padding(
                                  padding: MediaQuery.viewInsetsOf(context),
                                  child: StrengthexercisesWidget(
                                    upperbodyexercisedocument:
                                        columnStrengthexercisesRecord,
                                  ),
                                ),
                              );
                            },
                          ).then((value) => safeSetState(() {}));
                        },
                        child: wrapWithModel(
                          model: _model.upperbodycomponentModels.getModel(
                            columnStrengthexercisesRecord.reference.id,
                            columnIndex,
                          ),
                          updateCallback: () => setState(() {}),
                          child: UpperbodycomponentWidget(
                            key: Key(
                              'Keyhl8_${columnStrengthexercisesRecord.reference.id}',
                            ),
                            upperbodydocument: columnStrengthexercisesRecord,
                          ),
                        ),
                      );
                    }),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
