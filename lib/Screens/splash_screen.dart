import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_app/Screens/oth_Login.dart';
import 'package:google_fonts/google_fonts.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  _moveToNextScreen(){
    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => OthLogin()),);
  }

  _loadAndMove(){
    Timer(Duration(seconds: 7), (){
      _moveToNextScreen();
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadAndMove();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: media.height,
              width: media.width,
              decoration: BoxDecoration(
               gradient: LinearGradient(
                 begin: Alignment.topLeft,
                 end: Alignment.bottomRight,
                 colors: [
                   Color(0xffbdc3c7),
                   Color(0xff2c3e50),
                 ],
               )
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image(image: AssetImage('Images/logo.png')),
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    '© All Rights Received to Arun Jeyamari',
                    style: GoogleFonts.sriracha(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
