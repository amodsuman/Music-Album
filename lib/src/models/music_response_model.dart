class MusicResponseModel {
  String? artist;
  int? id;
  String? image;
  String? thumbnail;
  String? title;
  String? url;

  MusicResponseModel(
      this.artist, this.id, this.image, this.thumbnail, this.title, this.url);

  MusicResponseModel.fromMap(Map<String, dynamic> parsedMap) {
    artist = parsedMap["artist"];
    id = parsedMap["id"];
    image = parsedMap["image"];
    thumbnail = parsedMap["thumbnail"];
    title = parsedMap["title"];
    url = parsedMap["url"];
  }
}
