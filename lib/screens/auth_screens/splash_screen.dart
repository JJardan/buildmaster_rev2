import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.white,
          body: Container(
              alignment: Alignment.center,
              child: Center(
                child: SizedBox(
                  height: 32,
                  width: 32,
                  child: LoadingIndicator(
                      indicatorType: Indicator.lineScalePulseOutRapid,
                      colors: const [Colors.black],
                      strokeWidth: 10,
                      backgroundColor: Colors.transparent,
                      pathBackgroundColor: Colors.transparent),
                ),
              )),
        ));
  }
}
