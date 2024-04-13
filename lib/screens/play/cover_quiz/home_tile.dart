import 'package:flutter/material.dart';

class HomeTile extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const HomeTile({super.key, required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(Icons.arrow_downward_sharp, size: 18),
              Text(title),
              Icon(Icons.arrow_downward_sharp, size: 18),
            ],
          )
        ),
        const SizedBox(height: 5),
        ...children
      ]
    );
  }
}
