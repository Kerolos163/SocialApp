class postmodel {
  late String Fname, Lname, Uid, Image, datetime, text, postimage;

  postmodel({
    required this.Fname,
    required this.Lname,
    required this.Uid,
    required this.Image,
    required this.datetime,
    required this.text,
    required this.postimage,
  });

  postmodel.fromJson(Map<String, dynamic> Json) {
    Fname = Json['fname'];
    Lname = Json['Lname'];
    Uid = Json['Uid'];
    Image = Json['Image'];
    datetime = Json['datetime'];
    text = Json['text'];
    postimage = Json['postimage'];
  }

  Map<String, dynamic> tomap() {
    return {
      'fname': Fname,
      'Lname': Lname,
      'Uid': Uid,
      'Image': Image,
      'datetime': datetime,
      'text': text,
      'postimage': postimage,
    };
  }
}
