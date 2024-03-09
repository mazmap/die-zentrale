import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizzly/utils.dart';

import 'HintsMask.dart';
import 'HintsNotifier.dart';

class CoverDisplay extends StatefulWidget {
  final String coverAssetPath;

  const CoverDisplay({super.key, required this.coverAssetPath});

  @override
  State<CoverDisplay> createState() => _CoverDisplayState();
}

class _CoverDisplayState extends State<CoverDisplay> {
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Stack(
        children: [
          ClipRect( // ClipRect is necessary: https://api.flutter.dev/flutter/widgets/BackdropFilter-class.html
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                  Color.fromRGBO(0, 255, 37, 1),
                  BlendMode.color
              ),
              child: Consumer<HintsNotifier>(
                  builder: (context, hintsNotifier, child) {
                    return FutureBuilder<ui.Image>(
                        future: loadImage(widget.coverAssetPath, MediaQuery.of(context).size),
                        builder: (BuildContext context, AsyncSnapshot<ui.Image> snapshot) {
                          double deviceWidth = MediaQuery.of(context).size.width;
                          if(snapshot.hasData){
                            return Container(
                              color: Colors.black,
                              child: Align(
                                alignment: Alignment.center,
                                child: CustomPaint(
                                  foregroundPainter: HintsMask(snapshot.data!, hintsNotifier.hintCoords, hintsNotifier.isRevealed),
                                  size: Size(deviceWidth-30, deviceWidth-30),
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
              ),
            ),
          ),
          Center(
              child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Text(
                    "Richtig!",
                  )
              )
          )
        ],
      ),
    );
  }
}
