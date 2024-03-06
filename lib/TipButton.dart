import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizzly/Coord.dart';
import 'package:quizzly/CurrentPoints.dart';
import 'package:quizzly/HintsNotifier.dart';

class TipButton extends StatefulWidget {
  const TipButton({super.key});

  @override
  State<TipButton> createState() => _TipButtonState();
}

class _TipButtonState extends State<TipButton> {
  final Random _random = Random();

  int _tipCounter = 0;
  int _tipCost = 1;

  bool _isTipDeactivated = false;

  @override
  Widget build(BuildContext context) {
    return Consumer2<CurrentPoints, HintsNotifier>(
      builder: (context, currentPoints, hintsNotifier, child) {
        return FilledButton(
            onPressed: _isTipDeactivated ? null : () {
              int size = 0;
              bool toggle = false;
              int newTipCost = 0;
              if(_tipCounter == 0 || _tipCounter == 1){
                size = 40;
              } else if (_tipCounter >=2 && _tipCounter <= 4){
                size = 60;
              } else if (_tipCounter >=5 && _tipCounter <=6){
                size = 80;
              } else {
                size = 80;
                toggle = true;
              }

              currentPoints.setLocalMinus(_tipCost);

              switch(_tipCounter){
                case 0: newTipCost = 1; break;
                case 1:
                case 2:
                case 3: newTipCost = 2; break;
                case 4:
                case 5:
                case 6: newTipCost = 4; break;
              }

              _tipCounter++;

              double x = _random.nextInt(350-size).toDouble();
              double y = _random.nextInt(350-size).toDouble();

              // TODO: Add ChangeNotifyListeners for HintsNotifier
              hintsNotifier.addBox(CoordBox(x, y, size.toDouble()));

              setState(() {
                _isTipDeactivated = toggle;
                _tipCost = newTipCost;
              });
            },
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith((states) {
                  // If the button is pressed, return green, otherwise blue
                  if (states.contains(MaterialState.pressed)) {
                    return Colors.black;
                  }
                  return Colors.white;
                }),
                foregroundColor: MaterialStateProperty.resolveWith((states) {
                  if (states.contains(MaterialState.pressed)) {
                    return Colors.white;
                  }
                  return Colors.black;
                }),
                shape: MaterialStateProperty.resolveWith((states) {
                  return ContinuousRectangleBorder();
                }),
                animationDuration: Duration(milliseconds: 1),
                alignment: Alignment.centerLeft,
                side: MaterialStateProperty.resolveWith((states) {
                  return BorderSide(color: Colors.black);
                }),
                padding: MaterialStateProperty.resolveWith((states) {
                  return EdgeInsets.symmetric(horizontal: 20, vertical: 10);
                })
            ),
            child: _isTipDeactivated ? Text("Kein Tip mehr übrig") : Text("Nächster Tip (-$_tipCost)")
        );
      }
    );
  }
}
