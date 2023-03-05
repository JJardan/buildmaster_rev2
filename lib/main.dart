import 'package:beamer/beamer.dart';
import 'package:buildmaster_rev2/connection/states/departmentCategoryProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show json;
import 'package:provider/provider.dart';
import 'package:logger/logger.dart';
import 'connection/states/shimmer_provider.dart';
import 'connection/states/user_provider.dart';
import 'firebase_options.dart';
import 'router/locations.dart';
import 'router/build_router.dart';
import 'screens/auth_screens/error_screen.dart';
import 'screens/auth_screens/splash_screen.dart';
import 'theme/basicTheme.dart';

FirebaseAuth auth = FirebaseAuth.instance;

get googleSignin => _googleSignIn;
var logger = Logger();

GoogleSignIn _googleSignIn = GoogleSignIn(
  clientId: '529066145890-gk7p8nf0l5j0n9hrelsps7a102pgsilr.apps.googleusercontent.com',
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Provider.debugCheckInvalidValueType = null;
  final state = UserProvider();
  state.initUser();
  logger.d('let`s go buildmaster');

  runApp(MyApp(loginState: state));
}

class MyApp extends StatelessWidget {

  final UserProvider loginState;
  MyApp({super.key, required this.loginState});

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
        ChangeNotifierProvider<DepartmentCategoryProvider>(
          create: (BuildContext context) {
            return DepartmentCategoryProvider();
          },
        ),
        Provider<BuildRouter>(
          lazy: false,
          create: (context) => BuildRouter(loginState),
        )
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

class BuildMaster extends StatefulWidget {
  const BuildMaster({super.key});

  @override
  State<BuildMaster> createState() => BuildMasterState();
}

class BuildMasterState extends State<BuildMaster> {

  get handleSignOut => _handleSignOut;
  get handleSignIn => _handleSignIn;
  get handleGetContact => _handleGetContact;
  get contactText => _contactText;
  get currentUser => _currentUser;

  GoogleSignInAccount? _currentUser;
  String _contactText = '';

  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      setState(() {
        _currentUser = account;
      });
      if (_currentUser != null) {
        _handleGetContact(_currentUser!);
      }
    });
    _googleSignIn.signInSilently();
  }

  Future<void> _handleGetContact(GoogleSignInAccount user) async {
    setState(() {
      _contactText = 'Loading contact info...';
    });
    final http.Response response = await http.get(
      Uri.parse('https://people.googleapis.com/v1/people/me/connections'
          '?requestMask.includeField=person.names'),
      headers: await user.authHeaders,
    );
    if (response.statusCode != 200) {
      setState(() {
        _contactText = 'People API gave a ${response.statusCode} '
            'response. Check logs for details.';
      });
      print('People API ${response.statusCode} response: ${response.body}');
      return;
    }
    final Map<String, dynamic> data =
    json.decode(response.body) as Map<String, dynamic>;
    final String? namedContact = _pickFirstNamedContact(data);
    setState(() {
      if (namedContact != null) {
        _contactText = 'I see you know $namedContact!';
      } else {
        _contactText = 'No contacts to display.';
      }
    });
  }

  String? _pickFirstNamedContact(Map<String, dynamic> data) {
    final List<dynamic>? connections = data['connections'] as List<dynamic>?;
    final Map<String, dynamic>? contact = connections?.firstWhere(
          (dynamic contact) => (contact as Map<Object?, dynamic>)['names'] != null,
      orElse: () => null,
    ) as Map<String, dynamic>?;
    if (contact != null) {
      final List<dynamic> names = contact['names'] as List<dynamic>;
      final Map<String, dynamic>? name = names.firstWhere(
            (dynamic name) =>
        (name as Map<Object?, dynamic>)['displayName'] != null,
        orElse: () => null,
      ) as Map<String, dynamic>?;
      if (name != null) {
        return name['displayName'] as String?;
      }
    }
    return null;
  }

  Future<void> _handleSignIn() async {
    try {
      GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account != null) {
        GoogleSignInAuthentication authentication =
        await account.authentication;

        AuthCredential credential = GoogleAuthProvider.credential(
            idToken: authentication.idToken,
            accessToken: authentication.accessToken);

        UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

        User? user = userCredential.user;
        logger.d(userCredential.additionalUserInfo?.profile?.containsValue(user));

      } else
        print('failed to google sign in');

    } catch (error) {
      print(error);
    }
  }

  Future<void> _handleSignOut() => _googleSignIn.disconnect();

  Widget build(BuildContext context) {
    final router = Provider.of<BuildRouter>(context,listen: false).router;
    return MaterialApp.router(
      title: 'Buildmaster - Find Your Co-workers',
      theme: basicThemeData(context),
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
    );
  }
}