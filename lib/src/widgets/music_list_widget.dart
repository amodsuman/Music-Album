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
        launchURL() async {
          if (await canLaunch(musicList[index].url!)) {
            await launch(musicList[index].url!);
          }
        }

        checkInternet() async {
          var result = await Connectivity().checkConnectivity();
          if (result == ConnectivityResult.wifi) {
            launchURL();
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

        return Container(
          margin: EdgeInsets.only(top: 10, bottom: 10),
          child: Card(
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Card(
                    child: Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5),
                                bottomLeft: Radius.circular(5),
                              ),
                              child:
                                  Image.network(musicList[index].thumbnail!)),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                musicList[index].title!,
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                musicList[index].artist!,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.network(musicList[index].image!)),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        checkInternet();
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
                  ),
                ],
              ),
            ),
          ),
        );
      },
      itemCount: musicList.length,
    );
  }
}
