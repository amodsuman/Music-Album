import 'package:flutter/material.dart';
import 'package:music_album/src/models/music_response_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:connectivity/connectivity.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MusicListWidget extends StatelessWidget {
  final List<MusicResponseModel> musicList;

  MusicListWidget(this.musicList);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return Container(
          margin: EdgeInsets.only(top: 10, bottom: 10),
          child: Card(
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  songHeaderContainer(index),
                  songImageContainer(index),
                  buyNowContainer(index),
                ],
              ),
            ),
          ),
        );
      },
      itemCount: musicList.length,
    );
  }

  Card songHeaderContainer(int index) {
    return Card(
      child: Row(
        children: [
          songThumbnailContainer(index),
          songTitleContainer(index),
        ],
      ),
    );
  }

  Container songThumbnailContainer(int index) {
    return Container(
      width: 50,
      height: 50,
      child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(5),
            bottomLeft: Radius.circular(5),
          ),
          child: Image.network(musicList[index].thumbnail!)),
    );
  }

  Padding songTitleContainer(int index) {
    return Padding(
      padding: EdgeInsets.only(left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          songNameContainer(index),
          songArtistContainer(index),
        ],
      ),
    );
  }

  Text songNameContainer(int index) {
    return Text(
      musicList[index].title!,
      style: TextStyle(
        fontSize: 20,
      ),
    );
  }

  Text songArtistContainer(int index) {
    return Text(
      musicList[index].artist!,
      style: TextStyle(
        fontSize: 14,
        color: Colors.grey,
      ),
    );
  }

  Container songImageContainer(int index) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Image.network(musicList[index].image!)),
    );
  }

  Container buyNowContainer(int index) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          checkInternet(musicList[index].url!);
        },
        child: Text(
          "Buy Now",
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(16),
          primary: Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
      ),
    );
  }

  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  checkInternet(String url) async {
    var result = await Connectivity().checkConnectivity();
    if ((result == ConnectivityResult.wifi) ||
        (result == ConnectivityResult.mobile)) {
      launchURL(url);
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
}
