import 'package:flutter/material.dart';
import 'package:quizzly/screens/archive/archive_episode_screen_tile.dart';

import '../../episode.dart';

class ArchiveEpisodeScreen extends StatelessWidget {
  final Episode episode;

  const ArchiveEpisodeScreen({super.key, required this.episode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: Container(
            color: Colors.black,
            padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
            child: Stack(
              children: [
                Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    alignment: Alignment.center,
                    child: Text(
                        "Archiv-Kartei",
                      style: TextStyle(color: Colors.white)
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
        padding: EdgeInsets.all(15),
        child: ListView(
          children: [
            ArchiveEpisodeScreenTile(
                title: "Kurzinformationen",
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Table(
                    columnWidths: const {
                      0: IntrinsicColumnWidth(),
                      1: FlexColumnWidth()
                    },
                    children: [
                      TableRow(
                        children: [
                          Text(
                              "Titel",
                            style: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 0.5)
                            )
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: SelectableText(episode.title),
                          )
                        ]
                      ),
                      TableRow(
                          children: [
                            Text(
                                "Nummer",
                                style: TextStyle(
                                    color: Color.fromRGBO(0, 0, 0, 0.5)
                                )
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 20),
                                child: SelectableText(episode.number)
                            )
                          ]
                      ),
                      TableRow(
                          children: [
                            Text(
                              "Erschienen",
                                style: TextStyle(
                                    color: Color.fromRGBO(0, 0, 0, 0.5)
                                )
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 20),
                                child: SelectableText(episode.releaseDate))
                          ]
                      )
                    ],
                  )
                )
            ),
            const SizedBox(height: 10),
            ArchiveEpisodeScreenTile(
                title: "Cover",
                child: Material( // the material is necessary! otherwise the cover "overscrolls" on the top (ignoring the padding)
                  child: InkWell(
                    onTap: () {
                      showGeneralDialog(
                          context: context,
                          barrierDismissible: true,
                          barrierLabel: "image_zoom_popup",
                          pageBuilder: (context, primaryAnimation, secondaryAnimation){
                        return Dialog(
                            shape: const ContinuousRectangleBorder(),
                            insetPadding: const EdgeInsets.all(15),
                          child: InteractiveViewer(
                            maxScale: 10,
                            child: Image.asset(episode.coverAssetPath)
                          )
                        );
                      });
                    },
                    splashFactory: InkSparkle.splashFactory,
                    child: Ink.image(
                      fit: BoxFit.fill,
                      height: MediaQuery.of(context).size.width-32,
                        image: AssetImage(episode.coverAssetPath)
                    ),
                  ),
                )
            ),
            const SizedBox(height: 10),
            ArchiveEpisodeScreenTile(
                title: "Klappentext",
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: SelectableText(episode.description)
                )
            )
          ]
        )
      )
    );
  }
}
