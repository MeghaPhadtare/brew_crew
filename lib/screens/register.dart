import 'package:bre_crew/services/auth_service.dart';
import 'package:bre_crew/shared/loading.dart';
import 'package:flutter/material.dart';
class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();
  bool loading=false;
  String error='';
  @override
  Widget build(BuildContext context) {
    AuthService _auth=AuthService();
    final _formKey=GlobalKey<FormState>();
    return loading?Loading():Scaffold(
      appBar: AppBar(
        title: Text('Register'),
        actions: [

          FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('Sign In'),
              onPressed: (){
                widget.toggleView();
              } )

        ],
      ),
      body: Form(
        key: _formKey,
        child: Container(child: Column(
          children: [
            TextFormField(
              controller: email,
              validator: (val)=>val.isEmpty?'Enter email':null,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            TextFormField(
              controller: password,
              validator: (val)=>val.length < 6?'Enter valid password':null,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
              ),),

            RaisedButton(
                child: Text('Register '),
                onPressed: ()async{
                  if(_formKey.currentState.validate()){
                    setState(() =>loading=true);
                      dynamic result = _auth.registerWithEmailAndPassword(email.text, password.text);
                   if(result == null){
                     setState(() =>loading=false);
                     setState(()=> error='error');
                   }
                  }
                }
            ),
            SizedBox(height: 10,),
            Text(error,style: TextStyle(fontSize: 30,color: Colors.red),),
          ],
        ),),
      ),
    );
  }
}
