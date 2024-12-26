import 'package:flutter/material.dart';
import 'package:quizzly/auth/user_data_field.dart';
import 'package:quizzly/auth/user_service.dart';
import 'package:quizzly/screens/boarding/cr_select_color.dart';
import 'package:quizzly/screens/play/play_screen.dart';

import '../../data/episodes_service.dart';
import '../loading/loading_screen.dart';

class CompleteRegistration2 extends StatefulWidget {
  final TabController tabController;

  const CompleteRegistration2({super.key, required this.tabController});

  @override
  State<CompleteRegistration2> createState() => _CompleteRegistration2State();
}

class _CompleteRegistration2State extends State<CompleteRegistration2> with AutomaticKeepAliveClientMixin {
  final TextEditingController _nameController = TextEditingController();

  final _colorSelectorKey = GlobalKey<CRSelectColorState>();

  String _errorMessage = "";

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop){
        widget.tabController.animateTo(1);
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
                height: 50,
                color: Colors.black,
                alignment: Alignment.centerLeft,
                child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Text("Einrichtung (2/2)", style: TextStyle(color: Colors.white)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          FilledButton(
                            onPressed: () {
                              widget.tabController.animateTo(1);
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
                                return const EdgeInsets.symmetric(horizontal: 15);
                              }),
                              minimumSize: MaterialStateProperty.resolveWith((states) {
                                return const Size(10,10);
                              }),
                            ),
                            child: const Icon(Icons.arrow_back, size:18),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                            child: Image.asset("assets/icon/ddf_logo.png"),
                          )
                        ],
                      ),
                    ]
                )
            ),
            // const SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                reverse: true,
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text("Jeder echte Detektiv braucht eine Farbe, z.B. für Kreidemarkierungen. Welche möchtest du haben?"),
                      const SizedBox(height: 10),
                      CRSelectColor(key: _colorSelectorKey),
                      const SizedBox(height: 10),
                      Text("Sowohl deinen Benutzernamen, deinen Detektivnamen, dein Passwort, als auch deine Detektivfarbe kannst du später jederzeit ändern."),
                      const SizedBox(height: 15),
                      if(_errorMessage.isNotEmpty) Text(_errorMessage, style: TextStyle(color: Colors.red[800])),
                      const SizedBox(height: 15),
                      /*
                      FilledButton(
                          onPressed: (){},
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.white),
                            foregroundColor: MaterialStateProperty.all(Colors.black),
                            overlayColor: MaterialStateProperty.all(Color.fromRGBO(0, 0, 0, .2)),
                            shape: MaterialStateProperty.all(ContinuousRectangleBorder(borderRadius: BorderRadius.all(Radius.zero))),
                            padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 15, horizontal: 20)),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            side: MaterialStateProperty.all(BorderSide(color: Colors.black)),

                          ),
                          child: Text("Weiter")
                      ),
                       */
                      Material(
                        color: Colors.black,
                        child: InkWell(
                          onTap: (){
                            if(_colorSelectorKey.currentState?.validate() ?? false){
                              setState(() {
                                _errorMessage = "";
                              });
                              UserService.setDetectiveColorFromColorCode(_colorSelectorKey.currentState?.getSelectedColor() ?? 0xFFFFFFFF);
                              UserService.setRegistrationComplete();
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => LoadingScreen(
                                    waitFor: (displayMessage, displayErrorMessage) async {
                                      try{
                                        displayMessage("Daten werden gespeichert");
                                        await UserService.syncOnly([UserDataField.detectiveName, UserDataField.detectiveColor, UserDataField.isRegistrationComplete], (error) {
                                          displayErrorMessage("Ein Fehler ist aufgetreten!");
                                        });
                                      } catch (e) {
                                        print(e);
                                        displayErrorMessage("Ein Fehler ist aufgetreten!");
                                      }
                                      try{
                                        displayMessage("Lade neue Episoden");
                                        await EpisodesService.loadEpisodes();
                                      } catch (e) {
                                        displayErrorMessage("Internetverbindung fehlgeschlagen!");
                                      }
                                    },
                                    navigateTo: (result) => const PlayScreen(),
                                  ))
                              );
                            } else {
                              setState(() {
                                _errorMessage = "Du musst eine Farbe auswählen!";
                              });
                            }
                          },
                          splashFactory: InkSparkle.splashFactory,
                          child: Container(
                              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                              child: Text(
                                  "Abschließen & Speichern",
                                  overflow: TextOverflow.fade,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white)
                              )
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );;
  }

  @override
  bool get wantKeepAlive => true;
}
