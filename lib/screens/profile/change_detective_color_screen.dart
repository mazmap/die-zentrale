import 'package:flutter/material.dart';

class ChangeDetectiveColorScreen extends StatelessWidget {
  const ChangeDetectiveColorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(40), // Set this height
          child: Container(
              padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
              decoration: const BoxDecoration(
                  color: Colors.black,
                  border: Border(
                      bottom: BorderSide(color: Colors.black)
                  )
              ),
              child: Row(
                children: [
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: FilledButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ButtonStyle(
                          alignment: Alignment.center,
                          backgroundColor: MaterialStateProperty.resolveWith((states) {
                            return Colors.black;
                          }),
                          iconColor: MaterialStateProperty.resolveWith((states) {
                            return Colors.white;
                          }),
                          padding: MaterialStateProperty.resolveWith((states) {
                            return const EdgeInsets.symmetric(horizontal: 5);
                          }),
                          minimumSize: MaterialStateProperty.resolveWith((states) {
                            return const Size(10,10);
                          }),
                          shape: MaterialStateProperty.all(
                              const ContinuousRectangleBorder(borderRadius: BorderRadius.all(Radius.zero))
                          )
                      ),
                      child: const Icon(Icons.arrow_back_sharp, size:18),
                    )
                  ),
                  Expanded(
                      child: Container(
                          color: Colors.black,
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          child: Text(
                              "Detektiv-Farbe auswählen",
                              style: const TextStyle(color: Colors.white)
                          )
                      )
                  ),
                ],
              )
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left:15, right: 15, top: 15, bottom: 10),
          child: Column(
            children: [
              Text("Wähle aus den unteren Farben deine Detektivfarbe aus"),
              const SizedBox(height: 10),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Material(
                        type: MaterialType.button,
                        color: Colors.white,
                        child: InkWell(
                          onTap: (){},
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black)
                            ),
                            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                            child: Text("Justus")
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Material(
                        type: MaterialType.button,
                        color: const Color.fromRGBO(227, 6, 19, 1.0),
                        child: InkWell(
                          onTap: (){},
                          child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black)
                              ),
                              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                              child: Text("Peter", style: TextStyle(color: Colors.white),)
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Material(
                        type: MaterialType.button,
                        color: const Color.fromRGBO(0, 159, 228, 1.0),
                        child: InkWell(
                          onTap: (){},
                          child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black)
                              ),
                              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                              child: Text("Bob", style: TextStyle(color: Colors.white),)
                          ),
                        ),
                      )
                    ],
                  )
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
            elevation: 0,
            height: 70,
            padding: EdgeInsets.zero,
            child: Container(
                decoration: const BoxDecoration(
                  border: Border(
                      top: BorderSide(
                          color: Colors.black
                      )
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: FilledButton(
                    onPressed: () {

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
                        return const ContinuousRectangleBorder(side: BorderSide(color: Colors.black));
                      }),
                      animationDuration: const Duration(milliseconds: 1),
                      fixedSize: MaterialStateProperty.resolveWith((states) {
                        return Size(0, 50);
                      }),
                    ),
                    child: const Text("Speichern")
                )
            )
        )
    );
  }
}
