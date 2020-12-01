import 'package:bre_crew/screens/brew_tile.dart';
import 'package:flutter/material.dart';
import 'package:bre_crew/model/brew.dart';
import 'package:provider/provider.dart';

class BrewList extends StatefulWidget {
  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    final brews = Provider.of<List<Brew>>(context);
    //final brews = Provider.of<QuerySnapshot>(context);
    // //print(brews.docs);
    // for(var brew in brews.docs){
    //   print(brew.data());
    // }
    //-----------
    // brews.forEach((brew) {
    //   print(brew.name);
    //   print(brew.sugar);
    //   print(brew.strength);
    // });
    return ListView.builder(
      itemCount: brews.length,
        itemBuilder:(context,index){
        return BrewTile(brew: brews[index]);
        }
    );
  }
}
