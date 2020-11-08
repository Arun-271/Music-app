import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app/Screens/oth_Login.dart';
import 'package:http/http.dart'as http;
import 'package:music_app/const/constant.dart';
import 'dart:convert' as convert;

class ArtistScreen extends StatefulWidget {
  User _user;
  FirebaseAuth _auth;
  ArtistScreen(User userObject, FirebaseAuth _auth){
    this._user = userObject;
    this._auth = _auth;
  }
  
  @override
  _ArtistScreenState createState() => _ArtistScreenState();
}

class _ArtistScreenState extends State<ArtistScreen> {
  _getDrawerTextStyle(double size,Color colr){
    return GoogleFonts.sriracha(color: colr,fontSize: size);
  }

  _getListTile(String name,var  iconPress,Function fn){
    return ListTile(
      onTap: (){
        fn();
      },
      leading: Icon(
        iconPress,
        color: CupertinoColors.black,
        size: 30,
      ),
      title: Text(name,style: _getDrawerTextStyle(15,Colors.black),),
    );
  }

  _playlist(){

  }

  _signOut() async{
    if(widget._auth !=null){
      await widget._auth.signOut();
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>OthLogin()));
    }
  }

  _getDrawer(){
    return Drawer(
      elevation: 10,
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName:Text(widget._user.displayName, style: _getDrawerTextStyle(25,Colors.white),),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(widget._user.photoURL) ,
            ),
            decoration: BoxDecoration(
              color: Color(0xff3F51B5),
            ),
          ),
          _getListTile("My Playlist", Icons.playlist_play_outlined,_playlist),
          _getListTile("Logout", Icons.logout,_signOut),
        ],
      ),
    );
  }

  Future<List<dynamic>> _getArtist() async {
    http.Response response = await http.get(Constants.SINGERS_INFO_URL);
    String json = response.body;
    Map<String, dynamic> map = convert.jsonDecode(json);
    List<dynamic> list = map['singers'];
    return list;
  }

  _getEachSinger(var singer, int index) {
    return Column(
      children: <Widget>[
        InkWell(
          onTap: () {
            String singerName = singer[index]['name'];
            print("CURRENT SINGER NAME IS $singerName");
          },
          child: Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Color(0xff3F51B5), width: 4),),
            width: 150,
            height: 150,
            child: CircleAvatar(
              backgroundImage: NetworkImage(singer[index]['photo']),
            ),
          ),
        ),
        Container(
          child: Text(
            singer[index]['name'],
            style: GoogleFonts.sriracha(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
  _getGrid(AsyncSnapshot snapShot){
    return GridView.builder(
      itemCount: snapShot.data.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (BuildContext ctx, int index){
        return _getEachSinger(snapShot.data ,index);
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _getDrawer(),
      appBar: AppBar(
        title: Text('Pick your Artist',style: GoogleFonts.sriracha(),),
        backgroundColor: Color(0xff3F51B5),
        elevation: 15,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xffbdc3c7),
              Color(0xff2c3e50),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )
        ),
        child: FutureBuilder(
          future: _getArtist(),
          builder: (BuildContext ctx , AsyncSnapshot snapShot){
            if (snapShot.data == null){
              return Center(
                child: CircularProgressIndicator(),
              );
            }
              return _getGrid(snapShot);
          },
        ),
      ),
    );
  }
}
