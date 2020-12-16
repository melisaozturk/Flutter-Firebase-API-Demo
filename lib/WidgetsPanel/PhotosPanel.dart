import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_firebase_demo/WidgetsPanel/PhotosListItem.dart';
import '../Model/Photos.dart';
import '../ViewModel/ListViewModel.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_firebase_demo/NoInternetConnection.dart';

class PhotosPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ListViewModel>(
      builder: (context, child, model) {
        return FutureBuilder<List<Photos>>(
          future: model.photos,
          builder: (_, AsyncSnapshot<List<Photos>> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.active:
              case ConnectionState.waiting:
                return Center(child: const CircularProgressIndicator());
              case ConnectionState.done:
                if (snapshot.hasData) {
                  var photos = snapshot.data;
                  return Column(children: <Widget>[
                     RaisedButton(
                      onPressed: () async {
                        await FirebaseAuth.instance.signOut();
                        await FacebookAuth.instance.logOut();
                      },
                      child: Text("Logout"),
                    ),
                    ListView.builder(
                      itemCount: photos == null ? 0 : photos.length,
                      itemBuilder: (_, int index) {
                        var photo = photos[index];
                        return PhotosListItem(photo: photo);
                      },
                    )
                  ]);
                } else if (snapshot.hasError) {
                  return NoInternetConnection(
                    action: () async {
                      await model.setPhotos();
                    },
                  );
                }
            }
          },
        );
      },
    );
  }
}
