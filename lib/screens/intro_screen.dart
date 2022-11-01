import 'package:coco_meet/screens/welcome_screen.dart';
import 'package:coco_meet/widgets/button_widgets.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  List<PageViewModel> listPagesViewModel = [
    PageViewModel(
      // title: "Grab all events now only in your hands",
      titleWidget: const Text(
        'Grab all events now only in your hands',
        style: TextStyle(
            fontSize: 32,
            color: Color(0xFF584cf4),
            fontWeight: FontWeight.bold),
      ),
      bodyWidget: Container(),
      image: Center(
          child: Stack(
        children: [
          Image.asset('assets/images/Group.png'),
          Image.asset('assets/images/Image1.png'),
        ],
      )),
    ),
    PageViewModel(
      // title: "Easy payment & fast event ticketing",
      titleWidget: const Text(
        "Easy payment & fast event ticketing",
        style: TextStyle(
            fontSize: 32,
            color: Color(0xFF584cf4),
            fontWeight: FontWeight.bold),
      ),
      bodyWidget: Container(),
      image: Center(
          child: Stack(
        children: [
          Image.asset('assets/images/Group.png'),
          Image.asset('assets/images/Image2.png'),
        ],
      )),
    ),
    PageViewModel(
      titleWidget: const Text(
        "Let's go to your favorite event right now!",
        style: TextStyle(
            fontSize: 32,
            color: Color(0xFF584cf4),
            fontWeight: FontWeight.bold),
      ),
      bodyWidget: Container(),
      image: Center(
          child: Stack(
        children: [
          Image.asset('assets/images/Group.png'),
          Image.asset('assets/images/Image3.png'),
        ],
      )),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: IntroductionScreen(
        pages: listPagesViewModel,
        isTopSafeArea: true,
        globalHeader: const SizedBox(
          height: 200,
        ),
        onDone: () {
          // When done button is press
        },
        onSkip: () {
          // You can also override onSkip callback
        },
        showBackButton: false,
        globalFooter: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlueElevatedButton(
            text: 'Done',
            onPressed: () {
              print('ere');
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const WelcomeScreen(),
              ));
            },
          ),
        ),
        showSkipButton: false,
        skip: const Icon(Icons.skip_next),
        next: const Icon(Icons.navigate_next_outlined),
        done: const Text("", style: TextStyle(fontWeight: FontWeight.w600)),
        dotsDecorator: DotsDecorator(
            size: const Size.square(10.0),
            activeSize: const Size(20.0, 10.0),
            // activeColor: theme.accentColor,
            color: Colors.black26,
            spacing: const EdgeInsets.symmetric(horizontal: 3.0),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0))),
      ),
    );
  }
}

