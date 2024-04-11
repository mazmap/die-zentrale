import 'package:flutter/material.dart';
import 'package:quizzly/navigate_to_custom_button.dart';

class CompleteRegistrationMsgTabView extends StatelessWidget {
  final TabController tabController;

  const CompleteRegistrationMsgTabView({super.key, required this.tabController});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop){
        FocusScope.of(context).unfocus(disposition: UnfocusDisposition.scope);
        tabController.animateTo(0);
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
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                alignment: Alignment.centerLeft,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Einrichtung", style: TextStyle(color: Colors.white)),
                      Image.asset("assets/icon/ddf_logo.png")
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
                      Text("Hallo, Kollege/Kollegin! Bei deiner Registrierung hat wohl leider etwas nicht ganz funktioniert. Das tut uns leid. "),
                      const SizedBox(height: 10),
                      Text("Damit du die Zentrale betreten kannst, schließe bitte zunächst deine Registrierung vollends ab. "),
                      const SizedBox(height: 30),
                      NavigateToCustomButton(
                          text: "Registrierung abschließen",
                          customNavigator: () {
                            tabController.animateTo(1);
                          }
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
}
