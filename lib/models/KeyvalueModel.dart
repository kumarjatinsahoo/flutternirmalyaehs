class KeyvalueModel {
  dynamic name;
  dynamic key;
  dynamic code;
  dynamic optional;
  dynamic genderOptional;
  dynamic itemid;
  dynamic desc;
  dynamic minqty;


  KeyvalueModel({this.name, this.key,this.code, this.optional, this.genderOptional,this.itemid,this.desc,this.minqty});

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
    key = json['key']??json['bookstatus'];
    name = json['name'].toString();
    code = json['code'].toString();;
    optional = json['gender_name'].toString();
    itemid = json['itemid'].toString();
    desc = json['desc'].toString();
    minqty = json['minqty'].toString();



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
    return data;
  }

  @override
  String toString() => name;
}
