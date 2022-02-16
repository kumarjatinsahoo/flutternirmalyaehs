class KeyvalueModel {
  dynamic name;
  dynamic key;
  dynamic code;
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
  dynamic groupId;
  dynamic testNameId;


  KeyvalueModel({this.name, this.key,this.code, this.optional, this.genderOptional,this.itemid,this.desc,this.minqty,this.userid, this.testNameId, this.groupId });

  static List<KeyvalueModel> fromJsonList(List list) {
    if (list == null) return null;
    return list.map((item) => KeyvalueModel.fromsJson(item)).toList();
  }

  static List<KeyvalueModel> fromJsonListData(List list) {
    if (list == null) return null;
    List<KeyvalueModel> myList = [];
    list.forEach((element) {
      myList.add(new KeyvalueModel.fromsJson(element));
    });
    return myList;
  }

  KeyvalueModel.fromsJson(Map<String, dynamic> json) {
    key = json['key']??json['bookstatus']??json['id'];
    name = json['name']??json['userid'];
    code = json['code']??json['hospitalid']??json['isbooked'];
    optional = json['gender_name']??['address'];
    itemid = json['itemid']??['pin'];
    desc = json['desc']??['image'];
    minqty = json['minqty']??['type'];
    address = json['address'];
    hospitalid = json['hospitalid'].toString();
    image = json['image'];
    type = json['type'];
    userid = json['userid'];
    groupId = json['groupId'];
    testNameId = json['testNameId'];

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
    data['key'] = this.key;
    data['code'] = this.code;
    data['gender_name'] = this.optional;
    data['genderOptional'] = this.genderOptional;
    data['itemid'] = this.itemid;
    data['desc'] = this.desc;
    data['minqty'] = this.minqty;
    data['userid'] = this.userid;
    data['groupId'] = this.groupId;
    data['testNameId'] = this.testNameId;
    return data;
  }

  @override
  String toString() => name;
}
