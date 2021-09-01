class VitalModel {
  String medteluniqueid;
  String thpId;
  String thpName;
  String name;
  String mobile;
  String gender;
  String age;
  String screeningDate;
  List<ScreeningDetails> screeningDetails;
  Null patientUniqueid;
  String reportUrl;

  VitalModel(
      {this.medteluniqueid,
        this.thpId,
        this.thpName,
        this.name,
        this.mobile,
        this.gender,
        this.age,
        this.screeningDate,
        this.screeningDetails,
        this.patientUniqueid,
        this.reportUrl});

  VitalModel.fromJson(Map<String, dynamic> json) {
    medteluniqueid = json['medteluniqueid'];
    thpId = json['thp_id'];
    thpName = json['thp_name'];
    name = json['name'];
    mobile = json['mobile'];
    gender = json['gender'];
    age = json['age'];
    screeningDate = json['screening_date'];
    if (json['screening_details'] != null) {
      screeningDetails = new List<ScreeningDetails>();
      json['screening_details'].forEach((v) {
        screeningDetails.add(new ScreeningDetails.fromJson(v));
      });
    }
    patientUniqueid = json['patient_uniqueid'];
    reportUrl = json['report_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['medteluniqueid'] = this.medteluniqueid;
    data['thp_id'] = this.thpId;
    data['thp_name'] = this.thpName;
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['gender'] = this.gender;
    data['age'] = this.age;
    data['screening_date'] = this.screeningDate;
    if (this.screeningDetails != null) {
      data['screening_details'] =
          this.screeningDetails.map((v) => v.toJson()).toList();
    }
    data['patient_uniqueid'] = this.patientUniqueid;
    data['report_url'] = this.reportUrl;
    return data;
  }
}

class ScreeningDetails {
  String pocType;
  PocResult pocResult;

  ScreeningDetails({this.pocType, this.pocResult});

  ScreeningDetails.fromJson(Map<String, dynamic> json) {
    pocType = json['pocType'];
    pocResult = json['pocResult'] != null
        ? new PocResult.fromJson(json['pocResult'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pocType'] = this.pocType;
    if (this.pocResult != null) {
      data['pocResult'] = this.pocResult.toJson();
    }
    return data;
  }
}

class PocResult {
  String spo2;
  String spo2Pulse;
  String spo2Pi;
  String bp;
  String pulse;
  String baWeight;
  String baBmi;
  String baBodyFat;
  String baFatFreeBodyWeight;
  String baSubcutaneousFat;
  String baVisceralFat;
  String baBodyWater;
  String baSkeletalMuscle;
  String baMuscleMass;
  String baBoneMass;
  String baProtein;
  String baBmr;

  PocResult(
      {this.spo2,
        this.spo2Pulse,
        this.spo2Pi,
        this.bp,
        this.pulse,
        this.baWeight,
        this.baBmi,
        this.baBodyFat,
        this.baFatFreeBodyWeight,
        this.baSubcutaneousFat,
        this.baVisceralFat,
        this.baBodyWater,
        this.baSkeletalMuscle,
        this.baMuscleMass,
        this.baBoneMass,
        this.baProtein,
        this.baBmr});

  PocResult.fromJson(Map<String, dynamic> json) {
    spo2 = json['spo2'];
    spo2Pulse = json['spo2_pulse'];
    spo2Pi = json['spo2_pi'];
    bp = json['bp'];
    pulse = json['pulse'];
    baWeight = json['ba_weight'];
    baBmi = json['ba_bmi'];
    baBodyFat = json['ba_body_fat'];
    baFatFreeBodyWeight = json['ba_fat_free_body_weight'];
    baSubcutaneousFat = json['ba_subcutaneous_fat'];
    baVisceralFat = json['ba_visceral_fat'];
    baBodyWater = json['ba_body_water'];
    baSkeletalMuscle = json['ba_skeletal_muscle'];
    baMuscleMass = json['ba_muscle_mass'];
    baBoneMass = json['ba_bone_mass'];
    baProtein = json['ba_protein'];
    baBmr = json['ba_bmr'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['spo2'] = this.spo2;
    data['spo2_pulse'] = this.spo2Pulse;
    data['spo2_pi'] = this.spo2Pi;
    data['bp'] = this.bp;
    data['pulse'] = this.pulse;
    data['ba_weight'] = this.baWeight;
    data['ba_bmi'] = this.baBmi;
    data['ba_body_fat'] = this.baBodyFat;
    data['ba_fat_free_body_weight'] = this.baFatFreeBodyWeight;
    data['ba_subcutaneous_fat'] = this.baSubcutaneousFat;
    data['ba_visceral_fat'] = this.baVisceralFat;
    data['ba_body_water'] = this.baBodyWater;
    data['ba_skeletal_muscle'] = this.baSkeletalMuscle;
    data['ba_muscle_mass'] = this.baMuscleMass;
    data['ba_bone_mass'] = this.baBoneMass;
    data['ba_protein'] = this.baProtein;
    data['ba_bmr'] = this.baBmr;
    return data;
  }
}
