String directoryImages(String value) {
  List<List<String>> anyValues = [
    ["image", "pictures", "picture", "images"],
    ["document", "documents"],
    ["video", "videos", "movies", "movie"],
    ["contact", "contacts"],
    ["music", "musics"],
    ["download", "downloads"],
    ["messages", "message", "notifications", "notification"],
    ["android"]
  ];
  for (int i = 0; i < anyValues.length; i++) {
    if (anyValues[i].any((e) => e == value.toLowerCase())) {
      return "assets/images/file_${anyValues[i][0]}.png";
    }
  }
  return "assets/images/folder.png";
}
