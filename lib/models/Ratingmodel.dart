class Ratingmodel {
  String userid;
  String drid;
  String rating;
  String appno;
  String reviews;

  Ratingmodel({this.userid, this.drid, this.rating, this.appno, this.reviews});

  Ratingmodel.fromJson(Map<String, dynamic> json) {
    userid = json['userid'];
    drid = json['drid'];
    rating = json['rating'];
    appno = json['appno'];
    reviews = json['reviews'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userid'] = this.userid;
    data['drid'] = this.drid;
    data['rating'] = this.rating;
    data['appno'] = this.appno;
    data['reviews'] = this.reviews;
    return data;
  }
}
