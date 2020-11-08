import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:music_app/inside app screens/artist_screen.dart';


class OthLogin extends StatefulWidget {
  @override
  _OthLoginState createState() => _OthLoginState();
}

class _OthLoginState extends State<OthLogin> {

  FirebaseAuth _auth = FirebaseAuth.instance; // Create object of Firebase Authentication.
  GoogleSignIn _googleSignIn = new GoogleSignIn();

   _logInWithGoogle()async{
     //First line will open sign in screen
    GoogleSignInAccount _googleSignInAccount =await _googleSignIn.signIn(); // will return a future.
    // will auth
    GoogleSignInAuthentication _googleSignInAuth = await _googleSignInAccount.authentication;
    // verify the credentials
    OAuthCredential credential = GoogleAuthProvider.credential(
       accessToken: _googleSignInAuth.accessToken,
       idToken: _googleSignInAuth.idToken,
     );
    UserCredential userCredential = await _auth.signInWithCredential(credential);
     User userObject = userCredential.user;
     Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=> ArtistScreen(userObject,_auth)));
  }
  _logInWithFB(){

  }

  _createButton(String name,String imageN,Function onpres){
    return Container(
      width: deviceSize.width*0.80,
      height: deviceSize.height*0.08,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Colors.blueGrey,width: 2)
        ),
        elevation: 10,
        highlightColor: Colors.grey,
        color: Color(0xff004eb2),
          onPressed: (){
          onpres();
          },
          child: Row(
            children: [
              Image(image: AssetImage(imageN),),
              SizedBox(width: 25),
              Text(name,style: GoogleFonts.sriracha(fontSize: 20),),
            ],
          ),
      ),
    );
  }


  Size deviceSize;


  @override
  Widget build(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: deviceSize.height,
        width: deviceSize.width,
        decoration: BoxDecoration(
          gradient:  LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xffbdc3c7),
              Color(0xff2c3e50),
            ],
          ),
        ),
        child: Column(
          children: [
            Image.asset('Images/logo.png'),
            Text('Preview beats',
              style: GoogleFonts.sriracha(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  letterSpacing:3),
            ),
            Divider(
              height: deviceSize.height*0.07,
            ),
            _createButton('Login with Google','Images/google.png',_logInWithGoogle),
            Divider(
              height: deviceSize.height*0.07,
            ),
            _createButton('Login with FaceBook', 'Images/fb.png',_logInWithFB),
            Divider(
              height: deviceSize.height*0.09,
            ),
            Text("Created with ❤ By Arun Jeyamari",
              style: GoogleFonts.sriracha(
                  fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
