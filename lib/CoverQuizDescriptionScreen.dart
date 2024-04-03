import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'EpisodesService.dart';

class CoverQuizDescriptionScreen extends StatelessWidget {
  const CoverQuizDescriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: Container(
            color: Colors.black,
            padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
            child: Stack(
              children: [
                Container(
                    color: Colors.black,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    alignment: Alignment.center,
                    child: Text(
                        "Cover Quiz | Beschreibung",
                        style: const TextStyle(color: Colors.white)
                    )
                ),
                Container(
                  height: 50,
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
                        return const EdgeInsets.symmetric(horizontal: 15);
                      }),
                      minimumSize: MaterialStateProperty.resolveWith((states) {
                        return const Size(10,10);
                      }),
                    ),
                    child: const Icon(Icons.arrow_back, size:18),
                  ),
                ),
              ],
            )
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: [
            RichText(
              text: TextSpan(
                  style: TextStyle(
                      fontFamily: "Geist Mono Medium",
                      color: Colors.white
                  ),
                  text: "DAS Drei Fragezeichen Cover Quiz. In diesem Quiz kannst du alle Drei Fragezeichen Hörspiel Cover ",
                  children: [
                    TextSpan(
                        text: "bis Folge ${EpisodesService.getEpisodesAmount()}",
                        style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic)
                    ),
                    TextSpan(
                        text: " anhand kleiner Ausschnitte erraten. Dafür stehen dir "
                    ),
                    TextSpan(
                        text: "pro Cover 8 Tips",
                        style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic)
                    ),
                    TextSpan(
                        text: " zur Verfügung. Der erste Ausschnitt zählt dabei nicht als Tip. Pro Runde kannst du maximal 20 Punkte bekommen. Jeder Tip kostet Punkte, d.h. je weniger Tips du benutzt, desto mehr Punkte hast du."
                    )
                  ]
              ),
            ),
            const SizedBox(height: 10),
            Text("Es gibt drei verschiedene Tip-Größen:", style: TextStyle(color: Colors.white)),
            const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("- ", style: TextStyle(color: Colors.white)),
                Expanded(child: Text("1. und 2. Tip (klein) kostet 1 Punkt.", softWrap: true, style: TextStyle(color: Colors.white))),
              ],
            ),
            const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("- ", style: TextStyle(color: Colors.white)),
                Expanded(child: Text("3., 4. und 5. Tip (mittel) kostet 2 Punkte.", softWrap: true, style: TextStyle(color: Colors.white))),
              ],
            ),
            const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("- ",style: TextStyle(color: Colors.white)),
                Expanded(child: Text("6., 7. und 8. Tip (groß) kostet 4 Punkte.", softWrap: true, style: TextStyle(color: Colors.white))),
              ],
            ),
            const SizedBox(height: 10),
            Text("Benötigst du alle 8 Tips, um ein Cover richtig zu raten, so bekommst du für dieses Cover entsprechend 0 Punkte, kannst aber die Runde weiterspielen.", style: TextStyle(color: Colors.white)),
            const SizedBox(height: 10),
            Text("Du musst keinen einzigen Tip in einer Runde benutzen. Maximal sind also ${EpisodesService.getEpisodesAmount()*20} Punkte möglich.", style: TextStyle(color: Colors.white))
          ],
        ),
      ),
    );
  }
}
