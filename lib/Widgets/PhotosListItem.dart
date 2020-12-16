import 'package:flutter/material.dart';
import 'package:flutter_firebase_demo/Model/Photos.dart';


class PhotosListItem extends StatelessWidget {
  final Photos photo;

  PhotosListItem({@required this.photo});

  @override
  Widget build(BuildContext context) {
    var title = Text(photo.rover.name ?? "");
    print("title: ${title}");
    return Column(
      children: <Widget>[
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
          title: title,
        ),
        Divider(),
      ],
    );
  }
}