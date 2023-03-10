class  PatientsDetailsModel {
  List<Body> body;
  String message;
  String code;
  String total;

  PatientsDetailsModel({this.body, this.message, this.code, this.total});

  PatientsDetailsModel.fromJson(Map<String, dynamic> json) {
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
  String firstname;
  String lastname;
  String uhidcardno;
  String bloodgroup;
  String dob;
  String age;
  String gender;
  String maritalstatus;
  String occupation;
  String address1;
  String address2;
  String country;
  String state;
  String disctrict;
  String city;
  String emrgncyname;
  String emrgncyrelation;
  String emrgncymob;
  String famdctrname;
  String famdctrsepeciality;
  String famdctrmob;
  String height;
  String weight;
  String bmi;
  String celcius;
  String farenheit;
  String bldpressure;
  String systolic;
  String pulse;
  String respiration;
  String oxygen;
  String pin;
  List<Allergies> allergies;
  List<BioMedical> bioMedical;

  Body(
      {this.firstname,
        this.lastname,
        this.uhidcardno,
        this.bloodgroup,
        this.dob,
        this.age,
        this.gender,
        this.maritalstatus,
        this.occupation,
        this.address1,
        this.address2,
        this.country,
        this.state,
        this.disctrict,
        this.city,
        this.emrgncyname,
        this.emrgncyrelation,
        this.emrgncymob,
        this.famdctrname,
        this.famdctrsepeciality,
        this.famdctrmob,
        this.height,
        this.weight,
        this.bmi,
        this.celcius,
        this.farenheit,
        this.bldpressure,
        this.systolic,
        this.pulse,
        this.respiration,
        this.oxygen,
        this.pin,
        this.allergies,
        this.bioMedical});

  Body.fromJson(Map<String, dynamic> json) {
    firstname = json['firstname'].toString();
    lastname = json['lastname'].toString();
    uhidcardno = json['uhidcardno'].toString();
    bloodgroup = json['bloodgroup'].toString();
    dob = json['dob'].toString();
    age = json['age'].toString();
    gender = json['gender'];
    maritalstatus = json['maritalstatus'];
    occupation = json['occupation'];
    address1 = json['address1'];
    address2 = json['address2'];
    country = json['country'];
    state = json['state'];
    disctrict = json['disctrict'];
    city = json['city'];
    emrgncyname = json['emrgncyname'];
    emrgncyrelation = json['emrgncyrelation'];
    emrgncymob = json['emrgncymob'];
    famdctrname = json['famdctrname'];
    famdctrsepeciality = json['famdctrsepeciality'];
    famdctrmob = json['famdctrmob'];
    height = json['height'];
    weight = json['weight'];
    bmi = json['bmi'];
    celcius = json['celcius'];
    farenheit = json['farenheit'];
    bldpressure = json['bldpressure'];
    systolic = json['systolic'];
    pulse = json['pulse'];
    respiration = json['respiration'];
    oxygen = json['oxygen'];
    pin = json['pin'];
    if (json['allergies'] != null) {
      allergies = new List<Allergies>();
      json['allergies'].forEach((v) {
        allergies.add(new Allergies.fromJson(v));
      });
    }
    if (json['bioMedical'] != null) {
      bioMedical = new List<BioMedical>();
      json['bioMedical'].forEach((v) {
        bioMedical.add(new BioMedical.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['uhidcardno'] = this.uhidcardno;
    data['bloodgroup'] = this.bloodgroup;
    data['dob'] = this.dob;
    data['age'] = this.age;
    data['gender'] = this.gender;
    data['maritalstatus'] = this.maritalstatus;
    data['occupation'] = this.occupation;
    data['address1'] = this.address1;
    data['address2'] = this.address2;
    data['country'] = this.country;
    data['state'] = this.state;
    data['disctrict'] = this.disctrict;
    data['city'] = this.city;
    data['emrgncyname'] = this.emrgncyname;
    data['emrgncyrelation'] = this.emrgncyrelation;
    data['emrgncymob'] = this.emrgncymob;
    data['famdctrname'] = this.famdctrname;
    data['famdctrsepeciality'] = this.famdctrsepeciality;
    data['famdctrmob'] = this.famdctrmob;
    data['height'] = this.height;
    data['weight'] = this.weight;
    data['bmi'] = this.bmi;
    data['celcius'] = this.celcius;
    data['farenheit'] = this.farenheit;
    data['bldpressure'] = this.bldpressure;
    data['systolic'] = this.systolic;
    data['pulse'] = this.pulse;
    data['respiration'] = this.respiration;
    data['oxygen'] = this.oxygen;
    data['pin'] = this.pin;
    if (this.allergies != null) {
      data['allergies'] = this.allergies.map((v) => v.toJson()).toList();
    }
    if (this.bioMedical != null) {
      data['bioMedical'] = this.bioMedical.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Allergies {
  String allName;
  String allFood;
  String severity;
  String reaction;
  String allnameid;
  String alltypeid;

  Allergies({this.allName, this.allFood, this.severity, this.reaction,this.allnameid,this.alltypeid});

  Allergies.fromJson(Map<String, dynamic> json) {
    allName = json['allName'];
    allFood = json['allFood'];
    severity = json['severity'];
    reaction = json['reaction'];
    allnameid = json['allnameid'];
    alltypeid = json['alltypeid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['allName'] = this.allName;
    data['allFood'] = this.allFood;
    data['severity'] = this.severity;
    data['reaction'] = this.reaction;
    data['allnameid'] = this.allnameid;
    data['alltypeid'] = this.alltypeid;
    return data;
  }
}

class BioMedical {
  String bioMName;
  String bioMReason;
  String bioMDate;

  BioMedical({this.bioMName, this.bioMReason, this.bioMDate});

  BioMedical.fromJson(Map<String, dynamic> json) {
    bioMName = json['bioMName'];
    bioMReason = json['bioMReason'];
    bioMDate = json['bioMDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bioMName'] = this.bioMName;
    data['bioMReason'] = this.bioMReason;
    data['bioMDate'] = this.bioMDate;
    return data;
  }
}

