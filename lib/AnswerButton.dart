import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnswerButton extends StatefulWidget {
  const AnswerButton({super.key, });

  @override
  State<AnswerButton> createState() => _AnswerButtonState();
}

class _AnswerButtonState extends State<AnswerButton> {
  Color _backgroundColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("Button pressed!");
      },
      onLongPress: () {
        print("Long Press!");
      },

      child: Container(
        color: _backgroundColor,
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Text("A"),
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(
                    color: Colors.black
                  )
                )
              ),
            ),
            SizedBox(width: 20),
            Text("und der Superpapagei (001)")
          ],
        )
      ),
    );
  }
}
