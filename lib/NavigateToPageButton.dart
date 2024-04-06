import 'package:flutter/material.dart';

class NavigateToPageButton extends StatelessWidget {
  final String text;

  const NavigateToPageButton({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: (){},
        splashFactory: InkSparkle.splashFactory,

        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
          ),
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              Expanded(
                child: Text(text, overflow: TextOverflow.fade,),
              ),
              const SizedBox(width: 10),
              Icon(Icons.arrow_forward, size: 18)
            ],
          )
        ),
      ),
    );
  }
}
