import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../constants/data_keys.dart';
import '../constants/route_keys.dart';
import '../screens/app_screens/feed_screens/feed_screen.dart';
import '../screens/auth_screens/sign_in_google.dart';


class AuthLocation extends BeamLocation<BeamState> {
  // AuthLocation(RouteInformation routeInformation) : super(routeInformation);

  @override
  List<Pattern> get pathPatterns => ['/auth'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      BeamPage(
          key: ValueKey(LOCATION_AUTH),
          title: LOCATION_AUTH,
          type: BeamPageType.noTransition,
          child: SignInGoogle())
    ];
  }
}

class FeedLocation extends BeamLocation<BeamState> {
  // FeedLocation(RouteInformation routeInformation) : super(routeInformation);

  @override
  List<Pattern> get pathPatterns => ['/'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      BeamPage(
          key: ValueKey(LOCATION_HOME),
          title: LOCATION_HOME,
          type: BeamPageType.noTransition,
          child: FeedScreen())
    ];
  }
}
//
// class ProfileLocation extends BeamLocation<BeamState> {
//   ProfileLocation(RouteInformation routeInformation) : super(routeInformation);
//
//   @override
//   List<Pattern> get pathPatterns => ['/search'];
//
//   @override
//   List<BeamPage> buildPages(BuildContext context, BeamState state) {
//     return [
//       BeamPage(
//           key: ValueKey(LOCATION_SEARCH),
//           title: LOCATION_SEARCH,
//           type: BeamPageType.noTransition,
//           child: ProfileScreen())
//     ];
//   }
// }