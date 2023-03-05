import '../screens/app_screens/feed_screens/feed_screen.dart';
import '../screens/app_screens/profile_screens/career_screens/generate_career_screen.dart';
import '../screens/app_screens/profile_screens/personal_info.dart';
import '../screens/auth_screens/sign_in_google.dart';
import '../screens/company_screens/company_info.dart';
import '../screens/company_screens/copyright.dart';
import '../screens/company_screens/term_conditions.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../connection/states/user_provider.dart';
import '../constants/route_keys.dart';
import '../screens/app_screens/profile_screens/career_screens/career_screen.dart';
import '../screens/app_screens/profile_screens/profile_screen.dart';
import '../screens/auth_screens/error_screen.dart';

class BuildRouter {
  final UserProvider loginState;
  BuildRouter(this.loginState);

  late final router = GoRouter(
    initialLocation: '/',
    errorBuilder: (context, state){
      return ErrorScreen(error: state.error,);
    },
    routes: [
      GoRoute(
          path: '/login',
          name: 'loginPage',
          builder: (context, state) {
            return const SignInGoogle();
          }),
      GoRoute(
          path: '/',
          name: 'feedPage',
          builder: (context, state) {
            return const FeedScreen();
          }),
      GoRoute(
          path: '/profile',
          name: 'profile',
          builder: (context, state) {
            return ProfileScreen();
          },
          routes:[
            GoRoute(
              path: '/personal',
              name: LOCATION_PERSONAL,
              builder: (context, state) {
                return PersonalInfo();
              }),
            GoRoute(
                path: '/career',
                name: LOCATION_CAREER,
                builder: (context, state) {
                  return CareerScreen();
                }),
            GoRoute(
                path: '/addcareer',
                name: LOCATION_ADD_CAREER,
                builder: (context, state) {
                  return GenerateCareerScreen();
                }),
          ],
      ),
      GoRoute(
        path: '/company',
        name: LOCATION_COMPANY_INFO,
        builder: (context, state) {
          return CompanyInfo();
        },
        routes:[
          GoRoute(
              path: '/copyright',
              name: LOCATION_COMPANY_COPYRIGHT,
              builder: (context, state) {
                return Copyright();
              }),
          GoRoute(
              path: '/termconditions',
              name: LOCATION_COMPANY_TERMCONDITIONS,
              builder: (context, state) {
                return TermConditions();
              }),
        ],
      )
    ],
    redirect: (context, state){
      final loggedIn = loginState.user;
      final inAuthPage = state.subloc.contains('loginPage');

      if(inAuthPage && loggedIn!=null) return '/';
      if(!inAuthPage && loggedIn==null) return '/login';

    },
    refreshListenable: loginState,
    debugLogDiagnostics: true,
  );
}
