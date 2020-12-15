import 'package:flutter/material.dart';
import 'package:flutter_firebase_demo/Widgets/HomeWidgetItem.dart';
import '../Model/Photos.dart';
import '../ViewModel/ListViewModel.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_firebase_demo/NoInternetConnection.dart';

class HomeWidget extends StatelessWidget {
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
                  return ListView.builder(
                    itemCount: photos == null ? 0 : photos.length,
                    itemBuilder: (_, int index) {
                      var photo = photos[index];
                      return PhotosListItem(Photos: photo);
                    },
                  );
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
