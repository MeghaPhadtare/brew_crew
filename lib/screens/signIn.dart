import 'package:bre_crew/services/auth_service.dart';
import 'package:bre_crew/shared/loading.dart';
import 'package:flutter/material.dart';
class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();
  String error='';
  bool loading=false;
  @override
  Widget build(BuildContext context) {
    AuthService _auth=AuthService();
    final _formKey=GlobalKey<FormState>();
    return loading?Loading():Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
        actions: [

            FlatButton.icon(
                icon: Icon(Icons.person),
                label: Text('Register'),
                onPressed: (){
                    widget.toggleView();
                } )

        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: Container(child: Column(
            children: [
              TextFormField(
                validator: (val)=>val.isEmpty?'Enter email':null,
                controller:email ,
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
              ),
              TextFormField(
                validator: (val)=>val.length < 6?'Enter valid password':null,
                controller: password,
                obscureText: true,
                decoration: InputDecoration(
                labelText: 'Password',
              ),),
              RaisedButton(
                child: Text('Sign In '),
                  onPressed: ()async{
                    if(_formKey.currentState.validate()){
                      setState(() => loading=true);
                      dynamic result = _auth.signInWithEmailAndPassword(email.text, password.text);
                      if(result == null){
                        setState(()=>loading=false);
                        setState(()=> error='Error');
                      }
                    }

                  }
                  ),
              Text(error,style: TextStyle(fontSize: 30,color: Colors.red),)
            ],
          ),),
        ),
      ),
    );
  }
}
