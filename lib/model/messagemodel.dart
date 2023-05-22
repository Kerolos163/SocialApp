class messagemodel {
  late String? senderid, receiverid, datetime, text;
  String? Image;
  messagemodel({
    this.senderid,
    this.receiverid,
    this.datetime,
    this.text,
    required this.Image
  });

  messagemodel.fromJson(Map<String, dynamic> Json) {
    senderid = Json['senderid'];
    receiverid = Json['receiverid'];
    datetime = Json['datetime'];
    text = Json['text'];
    Image = Json['Image'];
  }

  Map<String, dynamic> tomap() {
    return {
      'senderid': senderid,
      'receiverid': receiverid,
      'datetime': datetime,
      'text': text,
      'Image': Image,
    };
  }
}
