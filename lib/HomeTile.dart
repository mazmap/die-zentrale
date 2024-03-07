import 'package:flutter/cupertino.dart';

class HomeTile extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const HomeTile({super.key, required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(title),
        ...children
      ]
    );
  }
}
