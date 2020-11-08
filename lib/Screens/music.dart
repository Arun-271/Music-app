// import 'package:flutter/material.dart';
// import 'package:music_app/const/constant.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert' as jsonParser; // convert the string to a map so that we can get the information.
//
// import 'package:music_app/models/songs.dart';
//
// class Music extends StatefulWidget {
//   @override
//   _MusicState createState() => _MusicState();
// }
//
// class _MusicState extends State<Music> {
//   List  songs =[];
//
//   _fillSongs(var mapResult){
//     mapResult.forEach((singleSong) =>print("Song ${singleSong['trackName']}"));
//     var tempsongs = mapResult.map((singleSong){
//       Song song = new Song();
//       song.artistName = singleSong['collectionName'];
//       song.name = singleSong['trackName'];
//       song.url = singleSong['previewUrl'];
//       return song;
//     }).toList();
//     // print("Songs Are :: $songs");
//     setState(() {
//       songs = tempsongs;
//     });
//
//   }
//   _loadSongs(){
//     String url = Constants.getUrl('Anirudh');
//     Future<http.Response> future = http.get(url);
//     future.then((response) {
//       /// print('Response is ${response.body.runtimeType}');
//       var map = jsonParser.jsonDecode(response.body);
//       /// print('Map is $map');
//       _fillSongs(map['results']);
//     } )
//         .catchError((err) => print("Error is $err"));
//   }
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _loadSongs();
//   }
//
//   List<Widget> printSongs(){
//     return songs.map((song){
//           return Card(
//             child: Row(
//               children: [
//                 Image.network(song.url),
//               ],
//             ),
//           );
//         }).toList();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             children: printSongs(),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'dart:convert' as jsonParser;
import 'package:audioplayer/audioplayer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:music_app/models/songs.dart';
import 'package:music_app/const/constant.dart';

class Music extends StatefulWidget {
  @override
  _MusicState createState() => _MusicState();
}

class _MusicState extends State<Music> {
  List<Song> songs = [];
  _fillSongs(List<dynamic> listOfSongs) {
    var tempSongs = listOfSongs.map((singleSong) {
      Song song = new Song();
      song.audioURL = singleSong['previewUrl'];
      song.name = singleSong['trackName'];
      song.artistName = singleSong['collectionName'];
      song.url = singleSong['artworkUrl60'];
      return song;
    }).toList();
    setState(() {
      songs = tempSongs;
    });
  }

// getting from the server
  AudioPlayer _audioPlayer = new AudioPlayer();
  void _playSongs(var url){
    _audioPlayer.stop();
    _audioPlayer.play(url);
  }
  _loadSongs() {
    String url = Constants.getUrl('Yuvan shankar raja');
    Future<http.Response> future = http.get(url); // we are getting from the server.
    future.then((response) {
      var map = jsonParser.jsonDecode(response.body);
      _fillSongs(map['results']);
    }).catchError((err) => print("Error is $err"));

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadSongs();
  }

  List<Widget> printSongs() {
    return songs.map((song) { // it say will convert the songs into a widget.
      return Container(
        margin: EdgeInsets.all(10),
        child: Card(
          shadowColor: Color(0xFFc31432),
          elevation: 10,
          color: Colors.white70,
          child: Padding(
            padding: EdgeInsets.all(15),
            child: ListTile(
              focusColor: Colors.white38,
                leading: Image.network(song.url),
                subtitle: Text(song.artistName),
                trailing: IconButton(
                    icon: Icon(
                      Icons.play_circle_filled,
                      size: 30,
                      color: Colors.deepOrangeAccent,
                    ),
                  onPressed: (){
                      _playSongs(song.audioURL);
                  },
                ),
                title: Text(song.name
                ),),
          ),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: printSongs(),
          ),
        ),
      ),
    );
  }
}