import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizzly/screens/play/cover_quiz/ongoing_quiz_aq_state.dart';
import 'package:quizzly/utils.dart';

import 'hints_mask.dart';

class CoverReviewDisplay extends StatefulWidget {
  final String coverAssetPath;

  const CoverReviewDisplay({super.key, required this.coverAssetPath});

  @override
  State<CoverReviewDisplay> createState() => _CoverReviewDisplayState();
}

class _CoverReviewDisplayState extends State<CoverReviewDisplay> with TickerProviderStateMixin{
  late final AnimationController _revealImageAnimationController;
  late final Animation _revealImageAnimation;

  late final Future<ui.Image> image = loadImage(widget.coverAssetPath, MediaQuery.of(context).size);

  ui.Image? loadedImage;

  @override
  void initState() {
    super.initState();

    _revealImageAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    )..animateTo(1.0, curve: Curves.easeOut);
    _revealImageAnimation = Tween(begin: 0.0, end: 1.0).animate(_revealImageAnimationController);
  }

  @override
  void dispose() {
    _revealImageAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ui.Image>(
        key: UniqueKey(),
        future: image,
        builder: (BuildContext context, AsyncSnapshot<ui.Image> snapshot) {
          double deviceWidth = MediaQuery.of(context).size.width;
          if(snapshot.hasData){
            loadedImage = snapshot.data;
          }

          if(loadedImage != null){
            return Consumer<OngoingQuizAQState>(
              builder: (context, ongoingQuizAQState, child){
                _revealImageAnimationController.reset();
                _revealImageAnimationController.animateTo(1.0, curve: Curves.easeOut);

                return Container(
                  decoration: BoxDecoration(
                      color: Colors.black,
                      border: Border.all(color: Colors.black, width: 1)
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: CustomPaint(
                        foregroundPainter: HintsMask(loadedImage!, ongoingQuizAQState.getLoadedHints(), ongoingQuizAQState.isRevealed()),
                        size: Size(deviceWidth-32, deviceWidth-32),
                        child: (!ongoingQuizAQState.isRevealed()) ? null : AnimatedBuilder(
                            animation: _revealImageAnimation,
                            builder: (BuildContext context, Widget? child) {
                              return Opacity(opacity: _revealImageAnimation.value, child: child,);
                            },
                            child: Image.asset(
                                widget.coverAssetPath,
                                width: deviceWidth-32,
                                height: deviceWidth-32
                            )
                        )
                    ),
                  ),
                );
              },
            );
          }
          return Container(
              color: Colors.black,
              height: deviceWidth-30,
              width: deviceWidth-30,
              child: const Center(
                  child: Text(
                    "Cover wird geladen...",
                    style: TextStyle(color: Colors.white),
                  )
              )
          );
        }
    );
  }
}
