import 'package:cloud_firestore/cloud_firestore.dart';

class News {
  String imagePath;
  String title;
  String source;
  String url;
  String datePublication;
  final DocumentReference reference;

  News.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['imagePath'] != null),
        assert(map['title'] != null),
        assert(map['source'] != null),
        assert(map['url'] != null),
        assert(map['datePublication'] != null),
        imagePath = map['imagePath'],
        title = map['title'],
        source = map['source'],
        url = map['url'],
        datePublication = map['datePublication'];

  News.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);

  @override
  String toString() => "News<$title:$url:$datePublication>";
}
