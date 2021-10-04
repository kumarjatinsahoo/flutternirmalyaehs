class DoctorModel {
  int id;
  dynamic name;
  dynamic address;
  dynamic pin;
  dynamic image;
  dynamic type;
  int hospitalid;

  DoctorModel(
      {this.id,
        this.name,
        this.address,
        this.pin,
        this.image,
        this.type,
        this.hospitalid});
  static List<DoctorModel> fromJsonList(List list) {
    if (list == null) return null;
    return list.map((item) => DoctorModel.fromJson(item)).toList();
  }

  static List<DoctorModel> fromJsonListData(List list) {
    if (list == null) return null;
    List<DoctorModel> myList = [];
    list.forEach((element) {
      myList.add(new DoctorModel.fromJson(element));
    });
    return myList;
  }

  DoctorModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    pin = json['pin'];
    image = json['image'];
    type = json['type'];
    hospitalid = json['hospitalid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['address'] = this.address;
    data['pin'] = this.pin;
    data['image'] = this.image;
    data['type'] = this.type;
    data['hospitalid'] = this.hospitalid;
    return data;
  }
}