import 'package:flutter/material.dart';

import 'slide_from_right_route.dart';

class NavigateToPageButton extends StatelessWidget {
  final String text;
  final bool isPrimary;
  final Widget? navigateTo;

  const NavigateToPageButton({super.key, required this.text, this.isPrimary=false, this.navigateTo});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: (isPrimary) ? Colors.black : Colors.white,
      child: InkWell(
        onTap: (){
          if(navigateTo != null){
            Navigator.push(
                context,
                SlideFromRightRoute(page: navigateTo!)
            );
          }
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
                child: Text(text, overflow: TextOverflow.fade, style: TextStyle(color: (isPrimary)? Colors.white : Colors.black)),
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
