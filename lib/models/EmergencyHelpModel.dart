 class EmergencyHelpModel {
  String police;
  List<Emergency> emergency;
  String ambulance;
  String message;
  String emerMsg;
  String status;

  EmergencyHelpModel(
      {this.police,
        this.emergency,
        this.ambulance,
        this.message,
        this.emerMsg,
        this.status});

  EmergencyHelpModel.fromJson(Map<String, dynamic> json) {
    police = json['police'];
    if (json['emergency'] != null) {
      emergency = new List<Emergency>();
      json['emergency'].forEach((v) {
        emergency.add(new Emergency.fromJson(v));
      });
    }
    ambulance = json['ambulance'];
    message = json['message'];
    emerMsg = json['emer_msg'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['police'] = this.police;
    if (this.emergency != null) {
      data['emergency'] = this.emergency.map((v) => v.toJson()).toList();
    }
    data['ambulance'] = this.ambulance;
    data['message'] = this.message;
    data['emer_msg'] = this.emerMsg;
    data['status'] = this.status;
    return data;
  }
}

class Emergency {
  String name;
  String mobile;
  String id;
  String relId;
  String relation;

  Emergency({this.name, this.mobile, this.id, this.relId, this.relation});

  Emergency.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    mobile = json['mobile'];
    id = json['id'];
    relId = json['rel_id'];
    relation = json['relation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['id'] = this.id;
    data['rel_id'] = this.relId;
    data['relation'] = this.relation;
    return data;
  }
}
