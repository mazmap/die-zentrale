import 'package:cloud_firestore/cloud_firestore.dart';

class Episode {
  final String id;
  final String title;
  final String description;
  final String coverAssetPath;
  final String number;
  final String releaseDate;

  const Episode({
    required this.id,
    required this.title,
    required this.description,
    required this.coverAssetPath,
    required this.number,
    required this.releaseDate
  });

  factory Episode.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
  ){
    final data = snapshot.data();
    return Episode(
      id: snapshot.id,
      title: data?["title"],
      description: data?["description"],
      coverAssetPath: data?["cover_asset_path"],
      number: data?["number"],
      releaseDate: data?["release_date"],
    );
  }

  Map<String, dynamic> toFirestore(){
    return {
      "title": title,
      "description": description,
      "cover_asset_path": coverAssetPath,
      "number": number,
      "release_date": releaseDate
    };
  }

  @override
  bool operator == (Object other){
    if(other is Episode){
      return other.number == number;
    }
    return false;
  }

  @override
  // TODO: implement hashCode
  int get hashCode => super.hashCode;

}