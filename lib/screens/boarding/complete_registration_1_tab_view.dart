import 'package:flutter/material.dart';
import 'package:quizzly/auth/user_service.dart';

import '../../auth/local_user.dart';

class CompleteRegistration1 extends StatefulWidget {
  final TabController tabController;

  const CompleteRegistration1({super.key, required this.tabController});

  @override
  State<CompleteRegistration1> createState() => _CompleteRegistration1State();
}

class _CompleteRegistration1State extends State<CompleteRegistration1> with AutomaticKeepAliveClientMixin {
  final TextEditingController _nameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop){
        // TODO: decide on what to do?
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
                      Text("Einrichtung (1/2)", style: TextStyle(color: Colors.white)),
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
                      Text("Hallo, Kollege/Kollegin! Damit du ein vollwertiges Mitglied der Zentrale werden kannst, müssen wir noch ein paar Dinge von dir wissen. "),
                      const SizedBox(height: 10),
                      Text("Wie würdest du denn gerne als Detektiv unter dem Account zu ${LocalUser.email}, bzw. @${LocalUser.username} genannt werden?"),
                      const SizedBox(height: 10),
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Detektivname"),
                            TextFormField(
                              validator: (text){
                                if (text == null || text.isEmpty) {
                                  return "Dein Detektivname kann nicht leer sein!";
                                }
                                // TODO: Keine Sonderzeichen!!!
                                return null;
                              },
                              style: TextStyle(
                                  fontSize: 14
                              ),
                              controller: _nameController,
                              canRequestFocus: true,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(borderRadius: BorderRadius.zero, borderSide: BorderSide(color: Colors.black, strokeAlign: 2.0)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.zero,
                                    borderSide: BorderSide(color: Colors.black)
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.zero,
                                    borderSide: BorderSide(color: Colors.black)
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 15,
                                    horizontal: 20
                                ),
                                hintText: "Justus Jonas",
                                fillColor: Colors.white,
                                filled: true,
                                errorMaxLines: 10
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text("Dein Detektivname wird öffentlich in der App angezeigt. Du kannst ihn wie deinen Benutzernamen, jederzeit ändern."),
                      const SizedBox(height: 40),
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
                        color: Colors.white,
                        child: InkWell(
                          onTap: (){
                            FocusScope.of(context).unfocus(disposition: UnfocusDisposition.scope);
                            if(_formKey.currentState?.validate() ?? false){
                              UserService.setDetectiveName(_nameController.text);
                              widget.tabController.animateTo(2);
                            }
                          },
                          splashFactory: InkSparkle.splashFactory,
                          child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                              child: Text(
                                  "Weiter",
                                  overflow: TextOverflow.fade,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.black)
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
    );
  }

  @override
  bool get wantKeepAlive => true;
}
