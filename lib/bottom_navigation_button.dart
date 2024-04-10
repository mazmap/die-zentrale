import 'package:flutter/material.dart';

class BottomNavigationButton extends StatefulWidget {
  final String text;
  final bool activeLock;
  final Widget? navigateTo;

  const BottomNavigationButton({super.key, required this.text, this.activeLock=false, this.navigateTo});

  @override
  State<BottomNavigationButton> createState() => _BottomNavigationButtonState();
}

class _BottomNavigationButtonState extends State<BottomNavigationButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
        onPressed: (){
          setState((){
            _isPressed = true;
          });
          if(!widget.activeLock){
            Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder: (_, __, ___) => widget.navigateTo!));
          }
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
              (widget.activeLock) ? Colors.black : (_isPressed) ? Colors.black : Colors.white
          ),
          foregroundColor: MaterialStateProperty.all(
              (widget.activeLock) ? Colors.white : (_isPressed) ? Colors.white : Colors.black
          ),
          shape: MaterialStateProperty.all(
              const ContinuousRectangleBorder()
          ),
          animationDuration: const Duration(milliseconds: 1),
        ),
        child: Text(widget.text)
    );
  }
}
