class MedicineReminderDTO1 {
  List<Body> body;
  String message;
  String code;
  Null total;

  MedicineReminderDTO1({this.body, this.message, this.code, this.total});

  MedicineReminderDTO1.fromJson(Map<String, dynamic> json) {
    if (json['body'] != null) {
      body = new List<Body>();
      json['body'].forEach((v) {
        body.add(new Body.fromJson(v));
      });
    }
    message = json['message'];
    code = json['code'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.body != null) {
      data['body'] = this.body.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['code'] = this.code;
    data['total'] = this.total;
    return data;
  }
}

class Body {
  String id;
  String userId;
  Null medType;
  String medName;
  String medDosage;
  Null dosagePerDay;
  Null startTime;
  Null endTime;
  String frequency;
  String startDate;
  Null totalDays;
  String instructions;
  Null isNotified;
  Null doseTime;
  Null dosageDate;
  Null dosageTime;
  Null userName;
  Null token;
  Null meddtls;
  String reminderType;
  Null endDate;
  String dosageStartTime;
  String dosageEndTime;

  Body(
      {this.id,
        this.userId,
        this.medType,
        this.medName,
        this.medDosage,
        this.dosagePerDay,
        this.startTime,
        this.endTime,
        this.frequency,
        this.startDate,
        this.totalDays,
        this.instructions,
        this.isNotified,
        this.doseTime,
        this.dosageDate,
        this.dosageTime,
        this.userName,
        this.token,
        this.meddtls,
        this.reminderType,
        this.endDate,
        this.dosageStartTime,
        this.dosageEndTime});

  Body.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    medType = json['medType'];
    medName = json['medName'];
    medDosage = json['medDosage'];
    dosagePerDay = json['dosagePerDay'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    frequency = json['frequency'];
    startDate = json['startDate'];
    totalDays = json['totalDays'];
    instructions = json['instructions'];
    isNotified = json['isNotified'];
    doseTime = json['doseTime'];
    dosageDate = json['dosageDate'];
    dosageTime = json['dosageTime'];
    userName = json['userName'];
    token = json['token'];
    meddtls = json['meddtls'];
    reminderType = json['reminderType'];
    endDate = json['endDate'];
    dosageStartTime = json['dosageStartTime'];
    dosageEndTime = json['dosageEndTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['medType'] = this.medType;
    data['medName'] = this.medName;
    data['medDosage'] = this.medDosage;
    data['dosagePerDay'] = this.dosagePerDay;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['frequency'] = this.frequency;
    data['startDate'] = this.startDate;
    data['totalDays'] = this.totalDays;
    data['instructions'] = this.instructions;
    data['isNotified'] = this.isNotified;
    data['doseTime'] = this.doseTime;
    data['dosageDate'] = this.dosageDate;
    data['dosageTime'] = this.dosageTime;
    data['userName'] = this.userName;
    data['token'] = this.token;
    data['meddtls'] = this.meddtls;
    data['reminderType'] = this.reminderType;
    data['endDate'] = this.endDate;
    data['dosageStartTime'] = this.dosageStartTime;
    data['dosageEndTime'] = this.dosageEndTime;
    return data;
  }
}
