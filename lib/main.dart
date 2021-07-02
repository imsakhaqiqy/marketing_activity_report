import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:kreditpensiun_apps/Screens/launcher/launcher_screen.dart';
import 'package:kreditpensiun_apps/Screens/provider/approval_disbursment_agen_provider.dart';
import 'package:kreditpensiun_apps/Screens/provider/approval_disbursment_provider.dart';
import 'package:kreditpensiun_apps/Screens/provider/approval_interaction_provider.dart';
import 'package:kreditpensiun_apps/Screens/provider/disbursment_akad_provider.dart';
import 'package:kreditpensiun_apps/Screens/provider/filter_report_disbursment_provider.dart';
import 'package:kreditpensiun_apps/Screens/provider/filter_report_disbursment_sl_provider.dart';
import 'package:kreditpensiun_apps/Screens/provider/filter_report_interaction_provider.dart';
import 'package:kreditpensiun_apps/Screens/provider/filter_report_interaction_sl_provider.dart';
import 'package:kreditpensiun_apps/Screens/provider/history_income_provider.dart';
import 'package:kreditpensiun_apps/Screens/provider/modul_provider.dart';
import 'package:kreditpensiun_apps/Screens/provider/pipeline_akad_provider.dart';
import 'package:kreditpensiun_apps/Screens/provider/pipeline_provider.dart';
import 'package:kreditpensiun_apps/Screens/provider/pipeline_submit_provider.dart';
import 'package:kreditpensiun_apps/Screens/provider/planning_interaction_provider.dart';
import 'package:kreditpensiun_apps/Screens/provider/report_disbursment_sl_provider.dart';
import 'package:kreditpensiun_apps/Screens/provider/report_interaction_sl_provider.dart';
import 'package:kreditpensiun_apps/Screens/provider/report_marketing_sl_provider.dart';
import 'package:kreditpensiun_apps/Screens/provider/report_pipeline_sl_provider.dart';
import 'package:kreditpensiun_apps/Screens/provider/simulation_kp74_provider.dart';
import 'package:kreditpensiun_apps/constants.dart';
import 'package:kreditpensiun_apps/Screens/provider/simulation_provider.dart';
import 'package:provider/provider.dart';

import 'Screens/provider/disbursment_provider.dart';
import 'Screens/provider/interaction_provider.dart';
import 'Screens/provider/planning_provider.dart';
import 'Screens/provider/report_disbursment_provider.dart';
import 'Screens/provider/report_interaction_provider.dart';
import 'Screens/provider/berita_provider.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: kPrimaryColor, // status bar color
    statusBarBrightness: Brightness.light, //status bar brigtness
    statusBarIconBrightness: Brightness.light, //status barIcon Brightness
  ));
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(
      debug: true // optional: set false to disable printing logs to console
      );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => SimulationProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => DisbursmentProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => InteractionProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => ReportInteractionProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => ReportDisbursmentProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => PlanningProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => PlanningInteractionProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => HistoryIncomeProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => ModulProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => PipelineProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => ApprovalInteractionProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => ApprovalDisbursmentProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => ApprovalDisbursmentAgenProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => FilterReportInteractionProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => FilterReportDisbursmentProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => ReportDisbursmentSlProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => ReportInteractionSlProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => FilterReportInteractionSlProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => FilterReportDisbursmentSlProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => ReportMarketingSlProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => ReportPipelineSlProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => SimulationKp74Provider(),
          ),
          ChangeNotifierProvider(
            create: (context) => DisbursmentAkadProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => BeritaProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => PipelineSubmitProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => PipelineAkadProvider(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Kredit Pensiun App',
          theme: ThemeData(
            primaryColor: kPrimaryColor,
            scaffoldBackgroundColor: Colors.white,
          ),
          home: LauncherScreen(),
        ));
  }
}
