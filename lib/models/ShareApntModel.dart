class ShareApntModel {
  dynamic name;
  dynamic patname;
  dynamic appno;
  dynamic optional;
  dynamic genderOptional;
  dynamic itemid;
  dynamic desc;
  dynamic minqty;
  dynamic address;
  dynamic image;
  dynamic hospitalid;
  dynamic type;
  dynamic userid;


  //ShareApntModel({this.name, this.key,this.code, this.optional, this.genderOptional,this.itemid,this.desc,this.minqty,this.userid});

  static List<ShareApntModel> fromJsonList(List list) {
    if (list == null) return null;
    return list.map((item) => ShareApntModel.fromsJson(item)).toList();
  }

  static List<ShareApntModel> fromJsonListData(List list) {
    if (list == null) return null;
    List<ShareApntModel> myList = [];
    list.forEach((element) {
      myList.add(new ShareApntModel.fromsJson(element));
    });
    return myList;
  }

  ShareApntModel.fromsJson(Map<String, dynamic> json) {
    patname = json['patname'];
    name = json['userid'];
    appno = json['appno'];
    optional = json['gender_name']??['address'];
    itemid = json['itemid']??['pin'];
    desc = json['desc']??['image'];
    minqty = json['minqty']??['type'];
    address = json['address'];
    hospitalid = json['hospitalid'].toString();
    image = json['image'];
    type = json['type'];
    userid = json['userid'];

    if (json.containsKey("optional")) {
      optional = json['optional'].toString();
    }
    if (json.containsKey("genderOptional")) {
      genderOptional = json['genderOptional'].toString();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['gender_name'] = this.optional;
    data['genderOptional'] = this.genderOptional;
    data['itemid'] = this.itemid;
    data['desc'] = this.desc;
    data['minqty'] = this.minqty;
    data['userid'] = this.userid;
    return data;
  }

  @override
  String toString() => name;
}
