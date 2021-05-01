import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:music_album/src/models/music_response_model.dart';
import 'package:music_album/src/widgets/music_list_widget.dart';
import 'package:connectivity/connectivity.dart';
import 'package:fluttertoast/fluttertoast.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  int counter = 0;
  List<MusicResponseModel> musicList = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          centerTitle: true,
          title: Text(
            "Buy Songs Here",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.green,
          onPressed: () {
            checkInternet();
          },
          icon: Icon(Icons.music_note),
          label: Text(
            "Add Songs",
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        body: Container(
            color: Color(0xFFEFEFEF),
            padding: EdgeInsets.only(left: 20, right: 20),
            child: MusicListWidget(musicList)),
      ),
    );
  }

  checkInternet() async {
    var result = await Connectivity().checkConnectivity();
    if ((result == ConnectivityResult.wifi) ||
        (result == ConnectivityResult.mobile)) {
      fetchMusic();
    } else {
      Fluttertoast.showToast(
        msg: "No internet connection!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey.shade700,
        textColor: Colors.white,
        fontSize: 16,
      );
    }
  }

  void fetchMusic() async {
    counter++;
    var uri = Uri.parse("https://api.fresco-meat.com/api/albums/$counter");
    var response = await get(uri);
    if (response.statusCode != 200) {
      Fluttertoast.showToast(
        msg: "No more songs available!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey.shade700,
        textColor: Colors.white,
        fontSize: 16,
      );
      return;
    }
    var body = response.body;
    var parsedMap = jsonDecode(body);

    var musicModel = MusicResponseModel.fromMap(parsedMap);

    // force ui rebuild
    setState(() {
      musicList.add(musicModel);
    });
  }
}
