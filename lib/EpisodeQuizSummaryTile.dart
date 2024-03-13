import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EpisodeQuizSummaryTile extends StatelessWidget {
  final String coverAssetPath;
  final String title;
  final int hints;
  final int points;

  const EpisodeQuizSummaryTile({super.key, required this.coverAssetPath, required this.title, required this.hints, required this.points});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all()
      ),
      height: 50,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Row(
              children: [
                Container(
                  decoration: const BoxDecoration(
                      border: Border(
                          right: BorderSide()
                      )
                  ),
                  child: Image.asset(
                    coverAssetPath,
                    height: 48,
                    width: 48,
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Text(title, overflow: TextOverflow.fade, softWrap: false,)
                ),
              ],
            ),
          ),
          const SizedBox(width: 15),
          Row(
            children: [
              Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black,
                  ),
                  alignment: Alignment.center,
                  child: Text("$hints", style: TextStyle(color: Colors.white))
              ),
              const SizedBox(width: 15),
              Container(
                decoration: const BoxDecoration(
                    border: Border(
                        left: BorderSide()
                    )
                ),
                width: 50,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Text("$points"),
              )
            ],
          )
        ]
      )
    );
  }
}
