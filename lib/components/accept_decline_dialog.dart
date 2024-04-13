import 'package:flutter/material.dart';

class AcceptDeclineDialog extends StatelessWidget {
  final String acceptText;
  final String declineText;
  final Function onAccept;
  final Function onDecline;

  final String infoText;
  final String title;

  const AcceptDeclineDialog({
    super.key,
    required this.title,
    required this.infoText,
    required this.acceptText,
    required this.declineText,

    required this.onAccept,
    required this.onDecline
  });

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
                  child: Text(
                    infoText,
                    softWrap: true,
                  ),
                ),

                Container(
                  height: 50,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black)
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: const BoxDecoration(
                              border: Border(
                                  right: BorderSide()
                              )
                          ),
                          child: FilledButton(
                              onPressed: (){
                                Navigator.pop(context);
                                onDecline();
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
                              child: Text(declineText)
                          ),
                        ),
                      ),
                      Expanded(
                        child: FilledButton(
                            onPressed: (){
                              Navigator.pop(context);
                              onAccept();
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
                            child: Text(acceptText)
                        ),
                      ),
                    ],
                  ),
                )
              ]
          )
      )
    );
  }
}
