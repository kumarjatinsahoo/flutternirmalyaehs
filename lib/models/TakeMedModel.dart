class TakeMedModel {
  String id;
  String userId;
  String medType;
  String medName;
  String medDosage;
  Null dosagePerDay;
  Null startTime;
  Null endTime;
  Null frequency;
  Null startDate;
  Null totalDays;
  String instructions;
  Null isNotified;
  Null doseTime;
  String dosageDate;
  String dosageTime;
  String userName;
  String token;
  String meddtls;
  Null reminderType;
  Null endDate;
  Null dosageStartTime;
  Null dosageEndTime;

  TakeMedModel(
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

  TakeMedModel.fromJson(Map<String, dynamic> json) {
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
