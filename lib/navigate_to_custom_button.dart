import 'package:flutter/material.dart';

class NavigateToCustomButton extends StatelessWidget {
  final String text;
  final bool isPrimary;
  final Function customNavigator;

  const NavigateToCustomButton({super.key, required this.text, this.isPrimary=false, required this.customNavigator});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: (isPrimary) ? Colors.black : Colors.white,
      child: InkWell(
        onTap: (){
          customNavigator();
        },
        splashFactory: InkSparkle.splashFactory,

        child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
            ),
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                      text,
                      overflow: TextOverflow.fade,
                      style: TextStyle(color: (isPrimary)? Colors.white : Colors.black)
                  ),
                ),
                const SizedBox(width: 10),
                Icon(Icons.arrow_forward, size: 18, color: (isPrimary) ? Colors.white : Colors.black,)
              ],
            )
        ),
      ),
    );
  }
}
