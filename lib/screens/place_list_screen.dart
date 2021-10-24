import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './place_detail_screen.dart';
import './add_place_screen.dart';
import '../providers/great_places.dart';
import './all_map_screen.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import './place_edit_screen.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.map),
            onPressed: () {
              Navigator.of(context).pushNamed(AllMapScreen.routeName);
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () {
          Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
        },
        backgroundColor: Colors.orangeAccent,
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false)
            .fetchAndSetPlaces(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
            ConnectionState.waiting
            ?  Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<GreatPlaces>(
          builder: (ctx, greatPlaces, ch) => greatPlaces.items.isEmpty //変更
              ? Center(
              child: const Text('Got no places yet, start adding some!'),
                )
              : ListView.builder(
            itemCount: greatPlaces.items.length,
            itemBuilder: (ctx, i) => Slidable(
              actionPane: SlidableDrawerActionPane(),
              child: ListTile(
              leading: CircleAvatar(
                backgroundImage: FileImage(
                  greatPlaces.items[i].image!,
                ),
              ),
              title: Text(greatPlaces.items[i].title!),
              subtitle: Text(greatPlaces.items[i].id as String),
              onTap: () {
                Navigator.of(context).pushNamed(
                  PlaceDetailScreen.routeName,
                  arguments: greatPlaces.items[i].id,
                );
              },
            ),
              secondaryActions: <Widget>[
                IconSlideAction(
                  caption: 'Edit',
                  color: Colors.black45,
                  icon: Icons.edit,
                  onTap: () {
                    //編集画面に遷移
                    Navigator.of(context).pushNamed(EditPlaceScreen.routeName);
                  },
                ),
                IconSlideAction(
                  caption: 'Delete',
                  color: Colors.red,
                  icon: Icons.delete,
                  onTap: () {
                    //削除しますかと聞いて、はいだったら削除
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
