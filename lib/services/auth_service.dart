
import 'package:bre_crew/model/user_model.dart';
import 'package:bre_crew/services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';


class AuthService{

  final FirebaseAuth _auth=FirebaseAuth.instance;
  // 1) sign in annonymously
Future signInAnon()async{
  try{
       UserCredential userCredential= await _auth.signInAnonymously();
       User user= userCredential.user;
       return _userModelFromFirebaseUser(user);
      } catch(e){
               print(e.toString());
               return null;
        }

     }
 // 2) create user object based on firebase user
     UserModel _userModelFromFirebaseUser(User user){
        return user!=null?UserModel(uid: user.uid):null;
     }
//3) auth change user stream
Stream<UserModel> get user{
  return _auth.authStateChanges()
      //.map((User user) => _userModelFromFirebaseUser(user));
  .map(_userModelFromFirebaseUser);
}

  // sign in with email & password
  Future signInWithEmailAndPassword(String email,String password)async{
    try{
      UserCredential userCredential=await _auth.signInWithEmailAndPassword(email: email, password: password) ;
      User user=userCredential.user;
      return _userModelFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

// register
  Future registerWithEmailAndPassword(String email,String password)async{
  try{
     UserCredential userCredential=await _auth.createUserWithEmailAndPassword(email: email, password: password) ;
     User user=userCredential.user;

     // create  new document for user with id as uid
     await DataBaseService(uid: user.uid).updateUserData('0', 'new member', 100);
     return _userModelFromFirebaseUser(user);
  }catch(e){
      print(e.toString());
      return null;
  }
  }

  //5)sign out
Future logOut() async{
  try {
    return _auth.signOut();
  }catch(e){
    print(e.toString());
    return null;
  }
}

}