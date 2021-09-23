class TimeScheduleModel {
  dynamic time;
  dynamic opdid;
  dynamic bookstatus;


  @override
  String toString() {
    return 'KeyvalueModel{time: $time, key: $opdid, code: $bookstatus}';
  }

  TimeScheduleModel({this.time, this.opdid,this.bookstatus});

  static List<TimeScheduleModel> fromJsonList(List list) {
    if (list == null) return null;
    return list.map((item) => TimeScheduleModel.fromsJson(item)).toList();
  }

  static List<TimeScheduleModel> fromJsonListData(List list) {
    if (list == null) return null;
    List<TimeScheduleModel> myList = [];
    list.forEach((element) {
      myList.add(new TimeScheduleModel.fromsJson(element));
    });
    return myList;
  }

  TimeScheduleModel.fromsJson(Map<String, dynamic> json) {
    time = json['time'].toString();
    opdid = json['opdid'].toString();
    bookstatus = json['code'].toString();




  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time'] = this.time;
    data['opdid'] = this.opdid;
    data['code'] = this.bookstatus;

    return data;
  }


}
