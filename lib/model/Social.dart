class Social_model {
  late String Fname, Lname, email, Uid, Image,Bio,cover;
  late bool isemail_verified;
  Social_model(
      {required this.Fname,
      required this.Lname,
      required this.email,
      required this.Uid,
      required this.isemail_verified,
      required this.Bio,
      required this.Image,
      required this.cover});

  Social_model.fromJson(Map<String, dynamic> Json) {
    Fname = Json['fname'];
    Lname = Json['Lname'];
    email = Json['email'];
    Uid = Json['Uid'];
    Image=Json['Image'];
    cover=Json['Cover'];
    Bio=Json['Bio'];
    isemail_verified = Json['isemail_verified'];
  }

  Map<String, dynamic> tomap() {
    return {
      'fname': Fname,
      'Lname': Lname,
      'email': email,
      'Uid': Uid,
      'Image': Image,
      'Cover': cover,
      'Bio': Bio,
      'isemail_verified': isemail_verified,
    };
  }
}
