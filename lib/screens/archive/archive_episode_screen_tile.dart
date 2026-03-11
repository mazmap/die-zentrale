import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ArchiveEpisodeScreenTile extends StatelessWidget {
  final String title;
  final Widget child;

  const ArchiveEpisodeScreenTile({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(width: 5),
                right: BorderSide(),
                bottom: BorderSide(),
                left: BorderSide()
              ),
              boxShadow: [
                BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.5),
                    blurRadius: 5,
                    offset: Offset(0,-4),
                )
              ]
            ),
            child: Material(
              child: InkWell(
                onTap: (){},
                splashFactory: InkSparkle.splashFactory,
                splashColor: Colors.black,
                child: Stack(
                  children: [
                    child,
                    Container(
                      color: Colors.white.withOpacity(.45),
                    )
                  ],
                ),
              ),
            )
          ),
        ),
        Positioned(
          right: 5,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(),
                right: BorderSide(),
                left: BorderSide(),
              )
            ),
            child: Text(title),
          ),
        ),
      ],
    );
  }
}
