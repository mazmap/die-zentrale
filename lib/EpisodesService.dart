import 'package:cloud_firestore/cloud_firestore.dart';

import 'Episode.dart';
import 'Episodes.dart';

class EpisodesService {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static int getEpisodesAmount() {
    return Episodes.episodes.length;
  }
  
  static Future<void> loadEpisodes() async {
    Episodes.episodes = await _db.collection("episodes").orderBy("number").get().then((value) {
      List<Episode> episodes = [];
      for(int i=0; i<value.size; i++){
        episodes.add(Episode.fromFirestore(value.docs.elementAt(i)));
      }
      return episodes.getRange(0, 201).toList();
    });
  }

  static Episode getNthEpisode(int n){
    return Episodes.episodes.elementAt(n);
  }
}