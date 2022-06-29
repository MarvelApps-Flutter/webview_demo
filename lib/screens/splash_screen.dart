import 'package:flutter/material.dart';
import 'package:webview_flutter_module/constants/image_constants.dart';
import 'package:webview_flutter_module/constants/text_constants.dart';
import 'package:webview_flutter_module/screens/successive_webview.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Offset> offset;
  late final Animation<double> _animation;
  late AnimationController delayedcontroller;
  late final Animation<double> _delayedAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..forward();

    _animation = CurvedAnimation(
      parent: controller,
      curve: Curves.fastOutSlowIn,
    );

    _delayedAnimation = CurvedAnimation(
      parent: controller,
      curve: const Interval(0.8, 1, curve: Curves.fastOutSlowIn),
    );

    offset = Tween<Offset>(
            begin: const Offset(0.0, -5), end: const Offset(0.0, 0.0))
        .animate(CurvedAnimation(parent: controller, curve: Curves.bounceOut));

    wait();
  }

  Future wait() async {
    await Future.delayed(const Duration(seconds: 6));
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => const SuccessiveWebsiteScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        _marvelAnimatedLogo(context),
        _animatedText(context),
        _footer()
      ],
    ));
  }

  Column _footer() {
    return Column(mainAxisAlignment: MainAxisAlignment.end, children: [
      SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                TextConstants.poweredBy,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black),
              ),
              Image.asset(
                ImageConstant.successiveLogo,
                width: 35,
                height: 35,
                fit: BoxFit.scaleDown,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    TextConstants.successive,
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 3),
                  ),
                  Text(
                    TextConstants.technologies,
                    style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1.2),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ]);
  }

  Center _animatedText(BuildContext context) {
    return Center(
      child: FadeTransition(
        opacity: _delayedAnimation,
        child: Padding(
          padding: const EdgeInsets.only(top: 70, left: 20),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.85,
            child: ShaderMask(
              shaderCallback: (Rect bounds) {
                return const RadialGradient(
                  center: Alignment.topLeft,
                  radius: 1.0,
                  colors: <Color>[
                    Colors.brown,
                    Colors.black,
                    Colors.brown,
                    Colors.black,
                  ],
                  tileMode: TileMode.mirror,
                ).createShader(bounds);
              },
              child: const Padding(
                padding: EdgeInsets.only(right: 15),
                child: Text(
                  TextConstants.apps,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Center _marvelAnimatedLogo(BuildContext context) {
    return Center(
      child: FadeTransition(
        opacity: controller,
        child: ScaleTransition(
          scale: _animation,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.85,
            child: Image.asset(ImageConstant.marvelLogo),
          ),
        ),
      ),
    );
  }
}
