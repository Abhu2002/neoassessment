import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:neoassessment_client/neoassessment_client.dart';
import 'package:neoassessment_flutter/config/navigation/route_paths.dart';
import 'package:neoassessment_flutter/config/theme/theme.dart';
import 'package:neoassessment_flutter/presentation/bloc/candidiates/remote_candidates_bloc.dart';
import 'package:neoassessment_flutter/presentation/bloc/domains/remote_domains_bloc.dart';
import 'package:neoassessment_flutter/presentation/bloc/exams/remote_exam_bloc.dart';
import 'package:neoassessment_flutter/presentation/bloc/levels/remote_levels_bloc.dart';
import 'package:neoassessment_flutter/presentation/bloc/questionCat/remote_questionCat_bloc.dart';
import 'package:neoassessment_flutter/presentation/bloc/questions/remote_questions_bloc.dart';
import 'package:neoassessment_flutter/presentation/bloc/responses/remote_response_bloc.dart';
import 'package:neoassessment_flutter/presentation/bloc/roles/remote_roles_bloc.dart';
import 'package:neoassessment_flutter/presentation/bloc/status/remote_status_bloc.dart';
import 'package:neoassessment_flutter/presentation/bloc/users/remote_users_bloc.dart';
import 'package:neoassessment_flutter/presentation/widgets/navbar/navbar_bloc.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

import 'config/navigation/app_router.dart';
import 'core/utils/sharedPref.dart';
import 'injection_container.dart';

var client = Client('http://localhost:8080/')
  ..connectivityMonitor = FlutterConnectivityMonitor();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Prefs.init();
  await initializeDependencies();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? token;

  @override
  void initState() {
    /* token = Prefs.getAccessToken();
    BlocProvider.of<RemoteUsersBloc>(context).add(
        VerifyTokenEvent(token!));*/
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => GetIt.I.get<RemoteUsersBloc>()),
          BlocProvider(create: (_) => GetIt.I.get<NavbarBloc>()),
          BlocProvider(
            create: (_) => GetIt.I.get<RemoteRolesBloc>(),
          ),
          BlocProvider(create: (_) => GetIt.I.get<RemoteDomainsBloc>()),
          BlocProvider(create: (_) => GetIt.I.get<RemoteLevelsBloc>()),
          BlocProvider(create: (_) => GetIt.I.get<RemoteQuestionBloc>()),
          BlocProvider(create: (_) => GetIt.I.get<RemoteLevelsBloc>()),
          BlocProvider(create: (_) => GetIt.I.get<QuestionCatBloc>()),
          BlocProvider(create: (_) => GetIt.I.get<RemoteExamBloc>()),
          BlocProvider(create: (_) => GetIt.I.get<RemoteCandidatesBloc>()),
          BlocProvider(create: (_) => GetIt.I.get<RemoteResponseBloc>()),
          BlocProvider(create: (_) => GetIt.I.get<RemoteStatusBloc>()),
        ],
        child: MaterialApp(

          title: 'Serverpod Demo',
          theme: appTheme,
          initialRoute: RoutePaths.splashscreen,
          debugShowCheckedModeBanner: false,
          onGenerateRoute: AppRouter.generateRoute,
        ));
  }
}
