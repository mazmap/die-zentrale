import 'package:flutter/material.dart';

class SimpleTextButton extends StatelessWidget {
  final String text;
  final bool isPrimary;
  final Function? onPressed;

  const SimpleTextButton({super.key, this.isPrimary=false, required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: (isPrimary) ? Colors.black : Colors.white,
      child: InkWell(
        onTap: (){
          if(onPressed != null){
            onPressed!();
          }
        },
          splashFactory: InkSparkle.splashFactory,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black)
          ),
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          child: Text(
            text,
            overflow: TextOverflow.fade,
            style: TextStyle(
              color: (isPrimary) ? Colors.white : Colors.black
            )
          )
        )
      )
    );
  }
}

