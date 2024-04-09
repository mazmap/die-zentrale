import 'package:flutter/material.dart';
import 'package:quizzly/PlayScreen.dart';

class LoadingScreen extends StatefulWidget {
  final Future<void> Function(void Function(String msg) displayMessage, void Function(String msg) displayErrorMessage) waitFor;

  const LoadingScreen({super.key, required this.waitFor});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> with SingleTickerProviderStateMixin{
  late final AnimationController _pulsingLogoAnimationController;
  late final Animation _pulsingLogoAnimation;

  String _loadingMessage = "";
  String _errorMessage = "";

  @override
  void initState() {
    super.initState();
    _pulsingLogoAnimationController = AnimationController(
        vsync: this,
      duration: const Duration(milliseconds: 1250)
    )..repeat(reverse: true);
    _pulsingLogoAnimation = Tween(begin: 1.0, end: 0.0).animate(_pulsingLogoAnimationController);

    Future.wait([
      widget.waitFor(displayMessage, displayErrorMessage),
      Future.delayed(Duration(seconds: 2)) // so that the loading screen does not just pop off (like flickering)
    ]).then((value){
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => PlayScreen())
        );
      });
    });
  }

  void displayMessage(String msg){
    setState(() {
      _loadingMessage = msg;
    });
  }

  void displayErrorMessage(String msg){
    setState(() {
      _errorMessage = msg;
    });
  }

  @override
  void dispose() {
    _pulsingLogoAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.black,
        image: DecorationImage(
            image: AssetImage("assets/images/episodes-grid.png"),
            fit: BoxFit.fill,
            opacity: .1
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                    height: 50,
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        radius: 1,
                        colors: [
                          Colors.black,
                          Colors.transparent
                        ]
                      )
                    ),
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    alignment: Alignment.center,
                    child: Text("Die Zentrale", style: TextStyle(color: Colors.white))
                ),
                Container(
                    decoration: BoxDecoration(
                        gradient: RadialGradient(
                            radius: 1,
                            colors: [
                              Colors.black,
                              Colors.transparent
                            ]
                        )
                    ),
                    padding: EdgeInsets.symmetric(vertical: 60, horizontal: 60),
                    alignment: Alignment.center,
                    child: AnimatedBuilder(
                      animation: _pulsingLogoAnimation,
                      builder: (BuildContext context, Widget? child) {
                        return Opacity(
                            opacity: _pulsingLogoAnimation.value,
                            child: Image.asset("assets/icon/ddf_logo.png")
                        );
                      },
                    )
                ),
                Container(
                    decoration: BoxDecoration(
                        gradient: RadialGradient(
                            radius: 1,
                            colors: [
                              Colors.black,
                              Colors.transparent
                            ]
                        )
                    ),
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    alignment: Alignment.center,
                    child: Column(
                      children:[
                        Text("Ladevorgang...", style: TextStyle(color: Colors.white)),
                        if(_loadingMessage.isNotEmpty)
                          Text("[${_loadingMessage}]", style: TextStyle(color: Color.fromRGBO(255, 255, 255, .75)))

                      ]
                    )
                ),
              ]
            )
          )
        ),
      )
    );
  }
}
