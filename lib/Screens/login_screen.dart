import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  _getTextField(var type, var icon , var label,var passwordField){
    return Container(
      padding: EdgeInsets.all(15),
      child: TextField(
        obscureText: passwordField,
        keyboardType: type,
        style: TextStyle(fontSize: 25,color: Colors.white),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.redAccent)
          ),
          hintStyle: TextStyle(color: Colors.deepOrange),
          labelStyle: TextStyle(color: Colors.deepOrange),
          prefixIcon: Icon(icon),
          labelText: label,
        ),
      ),
    );
  }
  _doLogin(){}
  _createButton(var txt){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.indigoAccent,
      ),
      child: MaterialButton(
        onPressed: (){

        },
        focusColor: Colors.white38,
        elevation: 20,
        focusElevation: 40,
        animationDuration: Duration(seconds: 5),
        child: Text(txt,style: TextStyle(fontSize: 30,color: Colors.black),),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      appBar:AppBar(
        backgroundColor: Color(0xff2c3e50),
        title: Text('My Music App'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            height: media.height,
            width: media.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xffbdc3c7),
                  Color(0xff2c3e50),
                ],
                begin: Alignment.bottomLeft,end: Alignment.topRight,
              ),
            ),
            child: Column(
              children: [
                Container(
                  child: Text(
                    'Login',
                    style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white),
                  ),
                  margin: EdgeInsets.only(top: 20,bottom: 10),
                ),
                _getTextField(TextInputType.emailAddress, Icons.email, 'Email',false),
                _getTextField(TextInputType.visiblePassword, Icons.lock, 'Password',true),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _createButton('Login'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
