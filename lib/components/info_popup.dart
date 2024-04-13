import 'package:flutter/material.dart';

class InfoPopup extends StatelessWidget {
  final String title;
  final Widget infoWidget;
  final String dismissText;

  const InfoPopup({super.key, required this.title, required this.infoWidget, this.dismissText = "Alles klar"});

  @override
  Widget build(BuildContext context) {
    return Dialog(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        insetPadding: const EdgeInsets.all(40),
        shape: const ContinuousRectangleBorder(),
        child: IntrinsicHeight(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black)
                    ),
                    child: Text(
                        title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        )
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: const BoxDecoration(
                        border: Border(
                            left: BorderSide(color: Colors.black),
                            right: BorderSide(color: Colors.black)
                        )
                    ),
                    child: infoWidget
                  ),

                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black)
                    ),
                    child: Container(
                      decoration: const BoxDecoration(
                          border: Border(
                              right: BorderSide()
                          )
                      ),
                      width: double.infinity,
                      child: FilledButton(
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.resolveWith((states) {
                              if (states.contains(MaterialState.pressed)) {
                                return Colors.black;
                              }
                              return Colors.white;
                            }),
                            foregroundColor: MaterialStateProperty.resolveWith((states) {
                              if (states.contains(MaterialState.pressed)) {
                                return Colors.white;
                              }
                              return Colors.black;
                            }),
                            shape: MaterialStateProperty.resolveWith((states) {
                              return const ContinuousRectangleBorder();
                            }),
                            animationDuration: const Duration(milliseconds: 1),
                          ),
                          child: Text(dismissText)
                      ),
                    ),
                  )
                ]
            )
        )
    );
  }
}
