import 'package:bre_crew/model/user_model.dart';
import 'package:bre_crew/screens/authenticate.dart';
import 'package:bre_crew/screens/home.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
class WrapperPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //3 either return authenticate or home
    final user=Provider.of<UserModel>(context);
    //print(user);
    if(user==null){
      return Authenticate();
    }else{
      return HomePage();
    }
  }
}
