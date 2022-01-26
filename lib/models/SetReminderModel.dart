class SetReminderModel {
  String userId;
  String medType;
  String medName;
  String medDosage;
  String dosagePerDay;
  String startTime;
  String endTime;
  String frequency;
  String startDate;
  String totalDays;
  String instructions;
  List<String> doseTime;
  SetReminderModel();



  SetReminderModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    medType = json['medType'];
    medName = json['medName'];
    medDosage = json['medDosage'];
    dosagePerDay = json['dosagePerDay'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    frequency = json['frequency'];
    startDate = json['startDate'];
    totalDays = json['email'];
    instructions = json['instructions'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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

    if (this.doseTime != null) {
      data['doseTime'] =
          this.doseTime.map((v) => v).toList();
    }
    return data;
  }


}
