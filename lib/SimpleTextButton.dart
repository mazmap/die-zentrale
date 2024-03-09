import 'package:flutter/material.dart';

class SimpleTextButton extends StatefulWidget {
  final void Function() onPressed;
  final List<Color> backgroundColors;
  final List<Color> textColors;
  final String text;
  final bool disabled;

  SimpleTextButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.backgroundColors,
    required this.textColors,
    this.disabled = false,
  });

  @override
  State<SimpleTextButton> createState() => _SimpleTextButtonState();
}

class _SimpleTextButtonState extends State<SimpleTextButton> {
  bool _isTapped = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTapDown: (details) {
            print("Tapped down");
            if(!widget.disabled){
              widget.onPressed();
              setState(() {
                _isTapped = true;
              });
            }
          },
          onTap: () {
            print("Tapped");
          },
          onTapCancel: () {
            print("Canceled!");
          },
          onTapUp: (details) {
            print("Tapped up");
            if(!widget.disabled){
              setState(() {
                _isTapped = false;
              });
            }
          },
          child: Container(
              color: (_isTapped) ? widget.backgroundColors[1] : widget.backgroundColors[0],
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                  widget.text,
                  style: TextStyle(
                      color: (_isTapped) ? widget.textColors[1] : widget.textColors[0]
                  )
              )
          ),
        )
      ],
    );
  }
}
