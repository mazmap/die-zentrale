import 'package:flutter/material.dart';

class ArchiveEpisodeScreenTile extends StatelessWidget {
  final String title;
  final Widget child;

  const ArchiveEpisodeScreenTile({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(title),
          Container(
            decoration: BoxDecoration(
              border: Border.all()
            ),
            child: child
          )
        ],
      ),
    );
  }
}
