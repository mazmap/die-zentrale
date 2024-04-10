import "dart:async";
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizzly/current_quiz_state.dart';
import 'package:quizzly/utils.dart';

import 'answers_list.dart';
import 'coord_box.dart';
import 'hints_mask.dart';

class CoverDisplay extends StatefulWidget {
  final String coverAssetPath;

  CoverDisplay({super.key, required this.coverAssetPath}) {
    print("Constructor in CoverDisplay: $coverAssetPath");
  }

  @override
  State<CoverDisplay> createState() {
    print("Create State in CoverDisplay: $coverAssetPath");
    return _CoverDisplayState();
  }
}

class _CoverDisplayState extends State<CoverDisplay> with TickerProviderStateMixin{
  late final AnimationController _revealImageAnimationController;
  late final Animation _revealImageAnimation;

  late final AnimationController _hideOverlayAnimationController;
  late final Animation _hideOverlayAnimation;

  late final Future<ui.Image> image = loadImage(widget.coverAssetPath, MediaQuery.of(context).size); // cannot be called in initState because of MediaQuery

  ui.Image? loadedImage;

  bool _showOverlay = true;

  @override
  void initState() {
    super.initState();
    _revealImageAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    )..animateTo(1.0, curve: Curves.easeOut);
    _revealImageAnimation = Tween(begin: 0.0, end: 1.0).animate(_revealImageAnimationController);

    _hideOverlayAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..animateTo(1.0, curve: Curves.elasticIn);
    _hideOverlayAnimation = Tween(begin: 1.0, end: 0.0).animate(_hideOverlayAnimationController);

    print("Init State in CoverDisplay: ${widget.coverAssetPath}");
  }

  @override
  void dispose() {
    _revealImageAnimationController.dispose();
    _hideOverlayAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Selector<CurrentQuizState, bool>(
      selector: (BuildContext context, CurrentQuizState currentQuizState) {
        return currentQuizState.isCurrentQuestionRevealed();
      },
      builder: (BuildContext context, bool isCurrentQuestionRevealed, Widget? child) {
        _revealImageAnimationController.reset();
        _revealImageAnimationController.animateTo(1.0, curve: Curves.easeOut);
        _hideOverlayAnimationController.reset();
        _hideOverlayAnimationController.animateTo(1.0, curve: Curves.easeOut);

        return Consumer<AnswersList>(
          builder: (context, answersList, child) {
            Widget imageWithHints = Selector<CurrentQuizState, List<CoordBox>>(
              selector: (context, currentQuizState) {
                return currentQuizState.getHintsOfCurrentQuestion();
              },
              builder: (context, hints, child) {
                return FutureBuilder<ui.Image>(
                    key: UniqueKey(),
                    future: image,
                    builder: (BuildContext context, AsyncSnapshot<ui.Image> snapshot) {
                      double deviceWidth = MediaQuery.of(context).size.width;
                      if(snapshot.hasData){
                        loadedImage = snapshot.data;
                      }

                      if(loadedImage != null){
                        return Container(
                          decoration: BoxDecoration(
                              color: Colors.black,
                              border: Border.all(color: Colors.black)
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: CustomPaint(
                                foregroundPainter: HintsMask(loadedImage!, hints, isCurrentQuestionRevealed),
                                size: Size(deviceWidth-32, deviceWidth-32),
                                child: (!isCurrentQuestionRevealed) ? null : AnimatedBuilder(
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
            );

            if(isCurrentQuestionRevealed){
              bool isCorrect = answersList.isCorrectAnswerSelected();

              double deviceWidth = MediaQuery.of(context).size.width;

              return GestureDetector(
                onTap: () {
                  _hideOverlayAnimationController.animateTo(1.0, duration: Duration(milliseconds: 100));
                },
                child: IntrinsicHeight(
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.black,
                            border: Border.all(color: Colors.black)
                        ),
                        child: Image.asset(
                            widget.coverAssetPath,
                            width: deviceWidth-32,
                            height: deviceWidth-32
                        ),
                      ),
                      AnimatedBuilder(
                        animation: _hideOverlayAnimation,
                        builder: (context, child){
                          return Opacity(opacity: _hideOverlayAnimation.value, child: child);
                        },
                        child: Stack(
                          children: [
                            ClipRect( // ClipRect is necessary: https://api.flutter.dev/flutter/widgets/BackdropFilter-class.html
                              child: ColorFiltered(
                                colorFilter: ColorFilter.mode(
                                    (isCorrect) ? const Color.fromRGBO(64, 255, 92, 1) : const Color.fromRGBO(255, 64, 110, 1),
                                    BlendMode.color
                                ),
                                child: imageWithHints,
                              ),
                            ),
                            Center(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    color: Colors.white,
                                  ),
                                  child: Text(
                                    (isCorrect) ? "Richtig!" : "Leider falsch :(",
                                  ),
                                )
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            } else {
              return imageWithHints;
            }
          },
        );
      },
    );
  }
}
