class WritzoReceiveModel {
  String patientId;
  String filePath;
  dynamic screeningDate;
  List<ScreeningDetails> screeningDetails;

  WritzoReceiveModel(
      {this.patientId,
        this.filePath,
        this.screeningDate,
        this.screeningDetails});

  WritzoReceiveModel.fromJson(Map<String, dynamic> json) {
    patientId = json['patientId'];
    filePath = json['filePath'];
    screeningDate = json['screeningDate'].toString();
    if (json['screeningDetails'] != null) {
      screeningDetails = new List<ScreeningDetails>();
      json['screeningDetails'].forEach((v) {
        screeningDetails.add(new ScreeningDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['patientId'] = this.patientId;
    data['filePath'] = this.filePath;
    data['screeningDate'] = this.screeningDate;
    if (this.screeningDetails != null) {
      data['screeningDetails'] =
          this.screeningDetails.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ScreeningDetails {
  String vitalName;
  String result;
  String type;

  ScreeningDetails({this.vitalName, this.result, this.type});

  ScreeningDetails.fromJson(Map<String, dynamic> json) {
    vitalName = json['vitalName'];
    result = json['result'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vitalName'] = this.vitalName;
    data['result'] = this.result;
    data['type'] = this.type;
    return data;
  }
}
