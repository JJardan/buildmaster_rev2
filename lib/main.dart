import 'package:beamer/beamer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:logger/logger.dart';
import 'connection/states/shimmer_provider.dart';
import 'connection/states/user_provider.dart';
import 'firebase_options.dart';
import 'router/locations.dart';
import 'screens/auth_screens/error_screen.dart';
import 'screens/auth_screens/splash_screen.dart';
import 'theme/basicTheme.dart';

var logger = Logger();

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Provider.debugCheckInvalidValueType = null;
  logger.d('let`s go buildmaster');
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark));

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(
          create: (BuildContext context) {
            return UserProvider();
          },
        ),
        ChangeNotifierProvider<ShimmerProvider>(
          create: (BuildContext context) {
            return ShimmerProvider();
          },
        ),
        // ChangeNotifierProvider<FormProvider>(
        //   create: (BuildContext context) {
        //     return FormProvider();
        //   },
        // ),
      ],
      child: FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          return AnimatedSwitcher(
            duration: Duration(milliseconds: 1000),
            switchInCurve: Curves.easeInOut,
            switchOutCurve: Curves.easeInOut,
            child: _splashLoadingWidget(snapshot),
          );
        },
      ),
    );
  }

  Widget _splashLoadingWidget(AsyncSnapshot<Object?> snapshot) {
    if (snapshot.hasError) {
      return ErrorScreen();
    } else if (snapshot.connectionState == ConnectionState.done) {
      return BuildMaster();
    } else {
      return SplashScreen();
    }
  }
}

class BuildMaster extends StatelessWidget {
  const BuildMaster({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Buildmaster - Find Your Co-workers',
      theme: basicThemeData(context),
      routeInformationParser: BeamerParser(),
      routerDelegate: _routerDelegate,
      backButtonDispatcher:
      BeamerBackButtonDispatcher(delegate: _routerDelegate),
    );
  }
}

final _routerDelegate = BeamerDelegate(
    guards: [
      BeamGuard(
          pathPatterns: ['/'],
          guardNonMatching: true,
          check: (context, location) {
            return Provider.of<UserProvider>(context, listen: false).user !=
                null;
          },
          beamToNamed: (origin, target) => '/')
    ],
    locationBuilder: BeamerLocationBuilder(beamLocations: [
      FeedLocation(),
      AuthLocation(),
      // ProfileLocation(),
    ]));
