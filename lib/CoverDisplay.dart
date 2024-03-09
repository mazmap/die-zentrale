import 'dart:ui' as ui;
import "dart:async";

import 'package:async/async.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizzly/utils.dart';

import 'AnswersList.dart';
import 'HintsMask.dart';
import 'HintsNotifier.dart';

class CoverDisplay extends StatefulWidget {
  final String coverAssetPath;

  const CoverDisplay({super.key, required this.coverAssetPath});

  @override
  State<CoverDisplay> createState() => _CoverDisplayState();
}

class _CoverDisplayState extends State<CoverDisplay> with TickerProviderStateMixin{
  late final AnimationController _animationController = AnimationController(
    duration: const Duration(milliseconds: 200),
    vsync: this,
  )..animateTo(1.0, curve: Curves.easeOut);
  late final _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController);

  late final Future<ui.Image> image = loadImage(widget.coverAssetPath, MediaQuery.of(context).size);

  ui.Image? loadedImage;

  bool _showOverlay = true;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                        color: Colors.black,
                        child: Align(
                          alignment: Alignment.center,
                          child: CustomPaint(
                              foregroundPainter: HintsMask(loadedImage!, hintsNotifier.hintCoords, hintsNotifier.isRevealed),
                              size: Size(deviceWidth-30, deviceWidth-30),
                              child: (!answersList.isRevealed()) ? null : AnimatedBuilder(
                                  animation: _animation,
                                  builder: (BuildContext context, Widget? child) {
                                    return Opacity(opacity: _animation.value, child: child,);
                                  },
                                  child: Image.asset(
                                      widget.coverAssetPath,
                                      width: deviceWidth-30,
                                      height: deviceWidth-30
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

        if(answersList.isRevealed()){
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
                            (isCorrect) ? Color.fromRGBO(64, 255, 92, 1) : Color.fromRGBO(255, 64, 110, 1),
                            BlendMode.color
                        ),
                        child: imageWithHints,
                      ),
                    ),
                    Center(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                          child: Text(
                            (isCorrect) ? "Richtig!" : "Leider falsch :(",
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            color: Colors.white,
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
  }
}
