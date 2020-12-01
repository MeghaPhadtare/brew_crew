import 'package:bre_crew/screens/brew_list.dart';
import 'package:bre_crew/services/auth_service.dart';
import 'package:bre_crew/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bre_crew/model/brew.dart';
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthService _auth=AuthService();
   // return StreamProvider<QuerySnapshot>.value(
    return StreamProvider<List<Brew>>.value(
     // value: DataBaseService().brews,
      value: DataBaseService().brews,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Brew Crew'),
          actions: [
            FlatButton.icon(
                icon: Icon(Icons.person),
                label: Text('Sign Out'),
              onPressed: ()async{
                  _auth.logOut();
              } )
          ],
        ),
        body: BrewList(),
      ),
    );
  }
}
