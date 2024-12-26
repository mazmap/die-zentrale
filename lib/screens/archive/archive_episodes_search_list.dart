import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizzly/data/episodes.dart';

import '../../data/episode.dart';
import '../../data/episodes_service.dart';
import 'archive_episode_tile.dart';

class ArchiveEpisodesSearchList extends StatefulWidget {
  const ArchiveEpisodesSearchList({super.key});

  @override
  State<ArchiveEpisodesSearchList> createState() => _ArchiveEpisodesSearchListState();
}

class _ArchiveEpisodesSearchListState extends State<ArchiveEpisodesSearchList> {
  final TextEditingController _textEditingController = TextEditingController();
  List<Episode> _episodes = [...Episodes.episodes];

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [Expanded(
      child: TextField(
        onTapOutside: (event){
          FocusManager.instance.primaryFocus?.unfocus();
        },
        controller: _textEditingController,
        onChanged: (text){
          // print(text.split(RegExp(r"\s|-")));
          String title;
          _episodes = [];
          for(int i=0; i<EpisodesService.getEpisodesAmount(); i++){
            title = EpisodesService.getNthEpisode(i).title;
            if(title.toLowerCase().contains(text.toLowerCase())){
              _episodes.add(EpisodesService.getNthEpisode(i));
            }
          }
          setState(() {});
        },
        style: TextStyle(
            fontSize: 14
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          isDense: true,
          contentPadding: EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 20
          ),
          hintText: "Nach Episoden suchen...",
          fillColor: Colors.white,
          filled: true,
        ),
      ),
    )];
    if(_textEditingController.text.isNotEmpty){
      children.add(IconButton(onPressed: (){
        _textEditingController.text = "";
        setState(() {
          _episodes = [...Episodes.episodes];
        });
      }, icon: Icon(Icons.close_sharp, size: 16), visualDensity: VisualDensity.compact,));
    }
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black)
            ),
            child: Row(
              children: children
            ),
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: CupertinoScrollbar(
            radius: Radius.zero,
            radiusWhileDragging: Radius.zero,
            child: Padding(
                padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
                child: ListView.separated(
                    itemCount: _episodes.length,
                    addAutomaticKeepAlives: true,
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 10);
                    },
                    itemBuilder: (context, index) {
                      return ArchiveEpisodeTile(episode: _episodes.elementAt(index));
                    }
                )

            ),
          ),
        ),
      ],
    );
  }
}
