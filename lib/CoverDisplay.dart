import 'dart:ui' as ui;
import "dart:async";

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizzly/CurrentQuizState.dart';
import 'package:quizzly/utils.dart';

import 'AnswersList.dart';
import 'HintsMask.dart';
import 'HintsNotifier.dart';

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
  late final AnimationController _animationController;
  late final Animation _animation;

  late final Future<ui.Image> image = loadImage(widget.coverAssetPath, MediaQuery.of(context).size); // cannot be called in initState because of MediaQuery

  ui.Image? loadedImage;

  bool _showOverlay = true;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    )..animateTo(1.0, curve: Curves.easeOut);
    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController);

    print("Init State in CoverDisplay: ${widget.coverAssetPath}");
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Selector<CurrentQuizState, bool>(
      selector: (BuildContext context, CurrentQuizState currentQuizState) {
        return currentQuizState.isCurrentQuestionRevealed();
      },
      builder: (BuildContext context, bool isCurrentQuestionRevealed, Widget? child) {
        return Consumer<AnswersList>(
          builder: (context, answersList, child) {
            Widget imageWithHints = Consumer<HintsNotifier>(
                builder: (context, hintsNotifier, child) {
                  return FutureBuilder<ui.Image>(
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
                                  foregroundPainter: HintsMask(loadedImage!, hintsNotifier.hintCoords, isCurrentQuestionRevealed),
                                  size: Size(deviceWidth-32, deviceWidth-32),
                                  child: (!isCurrentQuestionRevealed) ? null : AnimatedBuilder(
                                      animation: _animation,
                                      builder: (BuildContext context, Widget? child) {
                                        return Opacity(opacity: _animation.value, child: child,);
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

              if(_showOverlay){
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _showOverlay = !_showOverlay;
                    });
                  },
                  child: IntrinsicHeight(
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
                  ),
                );
              } else {
                return GestureDetector(
                    onTap: () {
                      setState(() {
                        _showOverlay = !_showOverlay;
                      });
                    },
                    child: imageWithHints
                );
              }
            } else {
              return imageWithHints;
            }
          },
        );
      },
    );
  }
}
