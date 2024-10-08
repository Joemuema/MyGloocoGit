import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/diet/access_from_main_tab/access_from_main_tab_widget.dart';
import '/flutter_flow/flutter_flow_charts.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/logs/addactivity/addactivity_widget.dart';
import '/logs/bglogs/bglogs_widget.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'home_model.dart';
export 'home_model.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  late HomeModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomeModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.currentChartDate = getCurrentTimestamp;
      _model.todayReadings = await queryBGreadingsRecordOnce(
        queryBuilder: (bGreadingsRecord) => bGreadingsRecord
            .where(
              'UserID',
              isEqualTo: FFAppState().UserID,
            )
            .where(
              'Date',
              isEqualTo: functions.getDate(_model.currentChartDate!),
            ),
      );
      _model.bloodSugarAvg = valueOrDefault<double>(
        functions.avgSugarReadings(
            _model.todayReadings!.map((e) => e.cGMreading).toList().toList()),
        0.0,
      );
      setState(() {});
      if (FFAppState().medicineRemindersUpdated == false) {
        _model.unmarkedReminders = await queryIndividualRemindersRecordOnce(
          queryBuilder: (individualRemindersRecord) => individualRemindersRecord
              .where(
                'UserID',
                isEqualTo: FFAppState().UserID,
              )
              .where(
                'Status',
                isEqualTo: 'Unset',
              )
              .orderBy('Date'),
        );
        await actions.updateMissedReminders(
          functions
              .combineIndividualReminders(
                  _model.unmarkedReminders!
                      .where((e) =>
                          (functions.stringToDate(e.date) >=
                              FFAppState().lastUpdatedReminders!) &&
                          (functions.stringToDate(e.date) <
                              functions.currentDate(getCurrentTimestamp)))
                      .toList()
                      .toList(),
                  _model.unmarkedReminders!
                      .where((e) =>
                          (functions.stringToDate(e.date) ==
                              functions.currentDate(getCurrentTimestamp)) &&
                          (functions.todayTime(e.time) <
                              functions.currentTimeXHoursBack(
                                  getCurrentTimestamp, 1.0)))
                      .toList()
                      .toList())
              .toList(),
        );
        FFAppState().medicineRemindersUpdated = true;
        FFAppState().lastUpdatedReminders = getCurrentTimestamp;
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AuthUserStreamWidget(
                          builder: (context) => Text(
                            'Hi, ${valueOrDefault<String>(
                              currentUserDisplayName,
                              'User',
                            )}!',
                            style: FlutterFlowTheme.of(context)
                                .titleLarge
                                .override(
                                  fontFamily: 'Inter',
                                  letterSpacing: 0.0,
                                ),
                          ),
                        ),
                        Text(
                          dateTimeFormat("E, d MMMM", getCurrentTimestamp),
                          style:
                              FlutterFlowTheme.of(context).labelSmall.override(
                                    fontFamily: 'Readex Pro',
                                    letterSpacing: 0.0,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 10.0, 10.0, 0.0),
                          child: FlutterFlowIconButton(
                            borderColor: FlutterFlowTheme.of(context).primary,
                            borderRadius: 20.0,
                            borderWidth: 1.0,
                            buttonSize: 40.0,
                            icon: Icon(
                              Icons.person,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 24.0,
                            ),
                            onPressed: () async {
                              context.pushNamed('Settings');
                            },
                          ),
                        ),
                      ].divide(const SizedBox(width: 10.0)),
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 10.0, 0.0, 10.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    10.0, 0.0, 0.0, 0.0),
                                child: Text(
                                  'Blood Glucose chart',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        fontSize: 16.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 10.0, 0.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      'Avg: ',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Readex Pro',
                                            fontSize: 15.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                    Text(
                                      valueOrDefault<String>(
                                        _model.bloodSugarAvg?.toString(),
                                        '0.0',
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Readex Pro',
                                            letterSpacing: 0.0,
                                          ),
                                    ),
                                    Text(
                                      ' mg/dl',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Readex Pro',
                                            letterSpacing: 0.0,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              5.0, 0.0, 5.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  _model.currentChartDate = functions
                                      .decrementDate(_model.currentChartDate!);
                                  setState(() {});
                                  _model.prevDayReadings =
                                      await queryBGreadingsRecordOnce(
                                    queryBuilder: (bGreadingsRecord) =>
                                        bGreadingsRecord
                                            .where(
                                              'UserID',
                                              isEqualTo: FFAppState().UserID,
                                            )
                                            .where(
                                              'Date',
                                              isEqualTo: functions.getDate(
                                                  _model.currentChartDate!),
                                            ),
                                  );
                                  _model.bloodSugarAvg = valueOrDefault<double>(
                                    functions.avgSugarReadings(_model
                                        .prevDayReadings!
                                        .map((e) => e.cGMreading)
                                        .toList()),
                                    0.0,
                                  );
                                  setState(() {});

                                  setState(() {});
                                },
                                child: Icon(
                                  Icons.chevron_left_rounded,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  size: 30.0,
                                ),
                              ),
                              FFButtonWidget(
                                onPressed: () async {
                                  final datePickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: getCurrentTimestamp,
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime(2050),
                                    builder: (context, child) {
                                      return wrapInMaterialDatePickerTheme(
                                        context,
                                        child!,
                                        headerBackgroundColor:
                                            FlutterFlowTheme.of(context)
                                                .primary,
                                        headerForegroundColor:
                                            FlutterFlowTheme.of(context).info,
                                        headerTextStyle:
                                            FlutterFlowTheme.of(context)
                                                .headlineLarge
                                                .override(
                                                  fontFamily: 'Inter',
                                                  fontSize: 32.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                        pickerBackgroundColor:
                                            FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                        pickerForegroundColor:
                                            FlutterFlowTheme.of(context)
                                                .primaryText,
                                        selectedDateTimeBackgroundColor:
                                            FlutterFlowTheme.of(context)
                                                .primary,
                                        selectedDateTimeForegroundColor:
                                            FlutterFlowTheme.of(context).info,
                                        actionButtonForegroundColor:
                                            FlutterFlowTheme.of(context)
                                                .primaryText,
                                        iconSize: 24.0,
                                      );
                                    },
                                  );

                                  if (datePickedDate != null) {
                                    safeSetState(() {
                                      _model.datePicked = DateTime(
                                        datePickedDate.year,
                                        datePickedDate.month,
                                        datePickedDate.day,
                                      );
                                    });
                                  }
                                  _model.currentChartDate = _model.datePicked;
                                  setState(() {});
                                },
                                text: _model.currentChartDate != null
                                    ? dateTimeFormat(
                                        "yMMMd", _model.currentChartDate)
                                    : 'Today',
                                options: FFButtonOptions(
                                  height: 30.0,
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      24.0, 0.0, 24.0, 0.0),
                                  iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  color: FlutterFlowTheme.of(context).alternate,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        letterSpacing: 0.0,
                                      ),
                                  elevation: 3.0,
                                  borderSide: const BorderSide(
                                    color: Colors.transparent,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  _model.currentChartDate = functions
                                      .incrementDate(_model.currentChartDate!);
                                  setState(() {});
                                  _model.nextDayReadings =
                                      await queryBGreadingsRecordOnce(
                                    queryBuilder: (bGreadingsRecord) =>
                                        bGreadingsRecord
                                            .where(
                                              'UserID',
                                              isEqualTo: FFAppState().UserID,
                                            )
                                            .where(
                                              'Date',
                                              isEqualTo: functions.getDate(
                                                  _model.currentChartDate!),
                                            ),
                                  );
                                  _model.bloodSugarAvg = valueOrDefault<double>(
                                    functions.avgSugarReadings(_model
                                        .nextDayReadings!
                                        .map((e) => e.cGMreading)
                                        .toList()),
                                    0.0,
                                  );
                                  setState(() {});

                                  setState(() {});
                                },
                                child: Icon(
                                  Icons.chevron_right,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  size: 30.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              10.0, 20.0, 20.0, 0.0),
                          child: StreamBuilder<List<BGreadingsRecord>>(
                            stream: queryBGreadingsRecord(
                              queryBuilder: (bGreadingsRecord) =>
                                  bGreadingsRecord
                                      .where(
                                        'UserID',
                                        isEqualTo: FFAppState().UserID,
                                      )
                                      .where(
                                        'Date',
                                        isEqualTo: functions.getDate(
                                            _model.currentChartDate != null
                                                ? _model.currentChartDate!
                                                : getCurrentTimestamp),
                                      )
                                      .orderBy('Time'),
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
                              List<BGreadingsRecord>
                                  bgChartBGreadingsRecordList = snapshot.data!;

                              return SizedBox(
                                height:
                                    MediaQuery.sizeOf(context).height * 0.492,
                                child: Stack(
                                  children: [
                                    FlutterFlowLineChart(
                                      data: [
                                        FFLineChartData(
                                          xData: bgChartBGreadingsRecordList
                                              .where((e) =>
                                                  e.period == 'before meal')
                                              .toList()
                                              .map((d) => d.decimalTime)
                                              .toList(),
                                          yData: bgChartBGreadingsRecordList
                                              .where((e) =>
                                                  e.period == 'before meal')
                                              .toList()
                                              .map((d) => d.cGMreading)
                                              .toList(),
                                          settings: LineChartBarData(
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            barWidth: 2.0,
                                            isCurved: true,
                                            preventCurveOverShooting: true,
                                          ),
                                        ),
                                        FFLineChartData(
                                          xData: bgChartBGreadingsRecordList
                                              .where((e) =>
                                                  e.period == 'after meal')
                                              .toList()
                                              .map((d) => d.decimalTime)
                                              .toList(),
                                          yData: bgChartBGreadingsRecordList
                                              .where((e) =>
                                                  e.period == 'after meal')
                                              .toList()
                                              .map((d) => d.cGMreading)
                                              .toList(),
                                          settings: LineChartBarData(
                                            color: FlutterFlowTheme.of(context)
                                                .secondary,
                                            barWidth: 2.0,
                                            isCurved: true,
                                            preventCurveOverShooting: true,
                                          ),
                                        )
                                      ],
                                      chartStylingInfo: ChartStylingInfo(
                                        backgroundColor:
                                            FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                        showGrid: true,
                                        borderColor:
                                            FlutterFlowTheme.of(context)
                                                .secondaryText,
                                        borderWidth: 1.0,
                                      ),
                                      axisBounds: const AxisBounds(),
                                      xAxisLabelInfo: AxisLabelInfo(
                                        title: 'Time (24hr format)',
                                        titleTextStyle: const TextStyle(
                                          fontSize: 12.0,
                                        ),
                                        showLabels: true,
                                        labelTextStyle: const TextStyle(
                                          fontSize: 10.0,
                                        ),
                                        labelInterval: 2.0,
                                        labelFormatter: LabelFormatter(
                                          numberFormat: (val) => formatNumber(
                                            val,
                                            formatType: FormatType.custom,
                                            format: '00',
                                            locale: 'en_US',
                                          ),
                                        ),
                                        reservedSize: 10.0,
                                      ),
                                      yAxisLabelInfo: const AxisLabelInfo(
                                        title: ' Sugar level (mg/dl)',
                                        titleTextStyle: TextStyle(
                                          fontSize: 12.0,
                                        ),
                                        showLabels: true,
                                        labelTextStyle: TextStyle(
                                          fontSize: 10.0,
                                        ),
                                        labelInterval: 50.0,
                                        reservedSize: 17.0,
                                      ),
                                    ),
                                    Align(
                                      alignment:
                                          const AlignmentDirectional(1.0, -1.0),
                                      child: FlutterFlowChartLegendWidget(
                                        entries: [
                                          LegendEntry(
                                              FlutterFlowTheme.of(context)
                                                  .primary,
                                              'Before meal'),
                                          LegendEntry(
                                              FlutterFlowTheme.of(context)
                                                  .secondary,
                                              'After meal'),
                                        ],
                                        width: 100.0,
                                        height: 50.0,
                                        textStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Readex Pro',
                                              fontSize: 11.0,
                                              letterSpacing: 0.0,
                                            ),
                                        textPadding:
                                            const EdgeInsetsDirectional.fromSTEB(
                                                5.0, 0.0, 0.0, 0.0),
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            10.0, 9.0, 5.0, 0.0),
                                        borderWidth: 1.0,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderColor:
                                            FlutterFlowTheme.of(context)
                                                .primaryText,
                                        indicatorSize: 10.0,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                10.0, 10.0, 0.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.add_card,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  size: 24.0,
                                ),
                                Text(
                                  'Add logs',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        fontSize: 15.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ].divide(const SizedBox(width: 8.0)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 10.0, 0.0, 10.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                InkWell(
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
                                          onTap: () =>
                                              FocusScope.of(context).unfocus(),
                                          child: Padding(
                                            padding: MediaQuery.viewInsetsOf(
                                                context),
                                            child: const BglogsWidget(),
                                          ),
                                        );
                                      },
                                    ).then((value) => safeSetState(() {}));
                                  },
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 0.0, 3.0),
                                        child: Icon(
                                          Icons.water_drop,
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          size: 24.0,
                                        ),
                                      ),
                                      Text(
                                        'BG readings',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Readex Pro',
                                              letterSpacing: 0.0,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                                InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    showModalBottomSheet(
                                      isScrollControlled: true,
                                      backgroundColor: Colors.transparent,
                                      context: context,
                                      builder: (context) {
                                        return GestureDetector(
                                          onTap: () =>
                                              FocusScope.of(context).unfocus(),
                                          child: Padding(
                                            padding: MediaQuery.viewInsetsOf(
                                                context),
                                            child: const AccessFromMainTabWidget(),
                                          ),
                                        );
                                      },
                                    ).then((value) => safeSetState(() {}));
                                  },
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 0.0, 3.0),
                                        child: Icon(
                                          Icons.fastfood_outlined,
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          size: 24.0,
                                        ),
                                      ),
                                      Text(
                                        'Food & Drink',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Readex Pro',
                                              letterSpacing: 0.0,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                                InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    showModalBottomSheet(
                                      isScrollControlled: true,
                                      backgroundColor: Colors.transparent,
                                      context: context,
                                      builder: (context) {
                                        return GestureDetector(
                                          onTap: () =>
                                              FocusScope.of(context).unfocus(),
                                          child: Padding(
                                            padding: MediaQuery.viewInsetsOf(
                                                context),
                                            child: const AddactivityWidget(
                                              completed: true,
                                            ),
                                          ),
                                        );
                                      },
                                    ).then((value) => safeSetState(() {}));
                                  },
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 0.0, 3.0),
                                        child: Icon(
                                          Icons.directions_run_rounded,
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          size: 24.0,
                                        ),
                                      ),
                                      Text(
                                        'Activity',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Readex Pro',
                                              letterSpacing: 0.0,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ].divide(const SizedBox(height: 20.0)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
