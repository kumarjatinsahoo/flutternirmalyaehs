class HealthChartResponse {
  String regNo;
  String status;
  String message;
  List<ScreeningReport> screeningReport;
  List<Bloodlevel> bloodlevel;
  List<Cholestrol> cholestrol;
  List<Oximeter> oximeter;
  List<Bloodpressure> bloodpressure;
  List<Kidney> kidney;

  HealthChartResponse(
      {this.regNo,
        this.status,
        this.message,
        this.screeningReport,
        this.bloodlevel,
        this.cholestrol,
        this.oximeter,
        this.bloodpressure});

  HealthChartResponse.fromJson(Map<String, dynamic> json) {
    regNo = json['reg_no'];
    status = json['status'];
    message = json['message'];
    if (json['screeningReport'] != null) {
      screeningReport = new List<ScreeningReport>();
      json['screeningReport'].forEach((v) {
        screeningReport.add(new ScreeningReport.fromJson(v));
      });
    }
    if (json['bloodlevel'] != null) {
      bloodlevel = new List<Bloodlevel>();
      json['bloodlevel'].forEach((v) {
        bloodlevel.add(new Bloodlevel.fromJson(v));
      });
    }
    if (json['cholestrol'] != null) {
      cholestrol = new List<Cholestrol>();
      json['cholestrol'].forEach((v) {
        cholestrol.add(new Cholestrol.fromJson(v));
      });
    }
    if (json['oximeter'] != null) {
      oximeter = new List<Oximeter>();
      json['oximeter'].forEach((v) {
        oximeter.add(new Oximeter.fromJson(v));
      });
    }
    if (json['bloodpressure'] != null) {
      bloodpressure = new List<Bloodpressure>();
      json['bloodpressure'].forEach((v) {
        bloodpressure.add(new Bloodpressure.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reg_no'] = this.regNo;
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.screeningReport != null) {
      data['screeningReport'] =
          this.screeningReport.map((v) => v.toJson()).toList();
    }
    if (this.bloodlevel != null) {
      data['bloodlevel'] = this.bloodlevel.map((v) => v.toJson()).toList();
    }
    if (this.cholestrol != null) {
      data['cholestrol'] = this.cholestrol.map((v) => v.toJson()).toList();
    }
    if (this.oximeter != null) {
      data['oximeter'] = this.oximeter.map((v) => v.toJson()).toList();
    }
    if (this.bloodpressure != null) {
      data['bloodpressure'] =
          this.bloodpressure.map((v) => v.toJson()).toList();
    }
    return data;
  }
  @override
  String toString() {
    return 'HealthChartResponse{status: $status, message: $message, screeningReport: $screeningReport,bloodlevel:$bloodlevel, cholestrol:$cholestrol,oximeter:$oximeter,bloodpressure:$bloodpressure}';
  }
}

class ScreeningReport {
  String glucose;
  String glucoseFrmRange;
  String glucoseToRange;
  String heartRate;
  String heartRateFrmRange;
  String heartRateToRange;
  String temp;
  String tempFrmRange;
  String tempToRange;

  ScreeningReport(
      {this.glucose,
        this.glucoseFrmRange,
        this.glucoseToRange,
        this.heartRate,
        this.heartRateFrmRange,
        this.heartRateToRange,
        this.temp,
        this.tempFrmRange,
        this.tempToRange});

  ScreeningReport.fromJson(Map<String, dynamic> json) {
    glucose = json['glucose'];
    glucoseFrmRange = json['glucose_frm_range'];
    glucoseToRange = json['glucose_to_range'];
    heartRate = json['heartRate'];
    heartRateFrmRange = json['heartRate_frm_range'];
    heartRateToRange = json['heartRate_to_range'];
    temp = json['temp'];
    tempFrmRange = json['temp_frm_range'];
    tempToRange = json['temp_to_range'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['glucose'] = this.glucose;
    data['glucose_frm_range'] = this.glucoseFrmRange;
    data['glucose_to_range'] = this.glucoseToRange;
    data['heartRate'] = this.heartRate;
    data['heartRate_frm_range'] = this.heartRateFrmRange;
    data['heartRate_to_range'] = this.heartRateToRange;
    data['temp'] = this.temp;
    data['temp_frm_range'] = this.tempFrmRange;
    data['temp_to_range'] = this.tempToRange;
    return data;
  }
  @override
  String toString() {
    return '{glucose:$glucose, glucose_frm_range:$glucoseFrmRange, glucose_to_range: $glucoseToRange, heartRate: $heartRate, heartRate_frm_range:$heartRateFrmRange,heartRate_to_range:$heartRateToRange,temp:$temp,temp_frm_range:$tempFrmRange,temp_to_range:$tempToRange}';
  }
}

class Bloodlevel {
  String hemo;
  String hemoFrmRange;
  String hemoToRange;
  String mch;
  String mchFrmRange;
  String mchToRange;
  String mchc;
  String mchcFrmRange;
  String mchcToRange;
  String mcv;
  String mcvFrmRange;
  String mcvToRange;
  String pcv;
  String pcvFrmRange;
  String pcvToRange;
  String rbc;
  String rbcFrmRange;
  String rbcToRange;

  Bloodlevel(
      {this.hemo,
        this.hemoFrmRange,
        this.hemoToRange,
        this.mch,
        this.mchFrmRange,
        this.mchToRange,
        this.mchc,
        this.mchcFrmRange,
        this.mchcToRange,
        this.mcv,
        this.mcvFrmRange,
        this.mcvToRange,
        this.pcv,
        this.pcvFrmRange,
        this.pcvToRange,
        this.rbc,
        this.rbcFrmRange,
        this.rbcToRange});

  Bloodlevel.fromJson(Map<String, dynamic> json) {
    hemo = json['hemo'];
    hemoFrmRange = json['hemo_frm_range'];
    hemoToRange = json['hemo_to_range'];
    mch = json['mch'];
    mchFrmRange = json['mch_frm_range'];
    mchToRange = json['mch_to_range'];
    mchc = json['mchc'];
    mchcFrmRange = json['mchc_frm_range'];
    mchcToRange = json['mchc_to_range'];
    mcv = json['mcv'];
    mcvFrmRange = json['mcv_frm_range'];
    mcvToRange = json['mcv_to_range'];
    pcv = json['pcv'];
    pcvFrmRange = json['pcv_frm_range'];
    pcvToRange = json['pcv_to_range'];
    rbc = json['rbc'];
    rbcFrmRange = json['rbc_frm_range'];
    rbcToRange = json['rbc_to_range'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hemo'] = this.hemo;
    data['hemo_frm_range'] = this.hemoFrmRange;
    data['hemo_to_range'] = this.hemoToRange;
    data['mch'] = this.mch;
    data['mch_frm_range'] = this.mchFrmRange;
    data['mch_to_range'] = this.mchToRange;
    data['mchc'] = this.mchc;
    data['mchc_frm_range'] = this.mchcFrmRange;
    data['mchc_to_range'] = this.mchcToRange;
    data['mcv'] = this.mcv;
    data['mcv_frm_range'] = this.mcvFrmRange;
    data['mcv_to_range'] = this.mcvToRange;
    data['pcv'] = this.pcv;
    data['pcv_frm_range'] = this.pcvFrmRange;
    data['pcv_to_range'] = this.pcvToRange;
    data['rbc'] = this.rbc;
    data['rbc_frm_range'] = this.rbcFrmRange;
    data['rbc_to_range'] = this.rbcToRange;
    return data;
  }
  @override
  String toString() {
    return '{hemo:$hemo,mch:$mch,mchc: $mchc, mcv: $mcv,pcv:$pcv, rbc:$rbc}';
  }

}

class Cholestrol {
  String cholestrolTotal;
  String cholestrolTotalFrmRange;
  String cholestrolTotalToRange;
  String hdlRatio;
  String hdlRatioFrmRange;
  String hdlRatioToRange;
  String hdl;
  String hdlFrmRange;
  String hdlToRange;
  String ldl;
  String ldlFrmRange;
  String ldlToRange;
  String triglyceride;
  String triglycerideFrmRange;
  String triglycerideToRange;

  Cholestrol(
      {this.cholestrolTotal,
        this.cholestrolTotalFrmRange,
        this.cholestrolTotalToRange,
        this.hdlRatio,
        this.hdlRatioFrmRange,
        this.hdlRatioToRange,
        this.hdl,
        this.hdlFrmRange,
        this.hdlToRange,
        this.ldl,
        this.ldlFrmRange,
        this.ldlToRange,
        this.triglyceride,
        this.triglycerideFrmRange,
        this.triglycerideToRange});

  Cholestrol.fromJson(Map<String, dynamic> json) {
    cholestrolTotal = json['cholestrol_total'];
    cholestrolTotalFrmRange = json['cholestrol_total_frm_range'];
    cholestrolTotalToRange = json['cholestrol_total_to_range'];
    hdlRatio = json['hdl_ratio'];
    hdlRatioFrmRange = json['hdl_ratio_frm_range'];
    hdlRatioToRange = json['hdl_ratio_to_range'];
    hdl = json['hdl'];
    hdlFrmRange = json['hdl_frm_range'];
    hdlToRange = json['hdl_to_range'];
    ldl = json['ldl'];
    ldlFrmRange = json['ldl_frm_range'];
    ldlToRange = json['ldl_to_range'];
    triglyceride = json['triglyceride'];
    triglycerideFrmRange = json['triglyceride_frm_range'];
    triglycerideToRange = json['triglyceride_to_range'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cholestrol_total'] = this.cholestrolTotal;
    data['cholestrol_total_frm_range'] = this.cholestrolTotalFrmRange;
    data['cholestrol_total_to_range'] = this.cholestrolTotalToRange;
    data['hdl_ratio'] = this.hdlRatio;
    data['hdl_ratio_frm_range'] = this.hdlRatioFrmRange;
    data['hdl_ratio_to_range'] = this.hdlRatioToRange;
    data['hdl'] = this.hdl;
    data['hdl_frm_range'] = this.hdlFrmRange;
    data['hdl_to_range'] = this.hdlToRange;
    data['ldl'] = this.ldl;
    data['ldl_frm_range'] = this.ldlFrmRange;
    data['ldl_to_range'] = this.ldlToRange;
    data['triglyceride'] = this.triglyceride;
    data['triglyceride_frm_range'] = this.triglycerideFrmRange;
    data['triglyceride_to_range'] = this.triglycerideToRange;
    return data;
  }

  @override
  String toString() {
    return '{cholestrol_total_frm_range:$cholestrolTotalFrmRange,cholestrol_total_to_range:$cholestrolTotalToRange,hdl_ratio_frm_range: $hdlRatioFrmRange, hdl_ratio_to_range: $hdlRatioToRange,hdl_frm_range:$hdlFrmRange, hdl_to_range:$hdlToRange, ldl_frm_range:$ldlFrmRange, ldl_to_range:$hdlToRange,triglyceride_frm_range:$triglycerideFrmRange,triglyceride_to_range:$triglycerideToRange}';
  }
}

class Oximeter {
  String spo2;
  String spo2FrmRange;
  String spo2ToRange;
  String spo2Pulse;
  String spo2PulseFrmRange;
  String spo2PulseToRange;

  Oximeter(
      {this.spo2,
        this.spo2FrmRange,
        this.spo2ToRange,
        this.spo2Pulse,
        this.spo2PulseFrmRange,
        this.spo2PulseToRange});

  Oximeter.fromJson(Map<String, dynamic> json) {
    spo2 = json['spo2'];
    spo2FrmRange = json['spo2_frm_range'];
    spo2ToRange = json['spo2_to_range'];
    spo2Pulse = json['spo2_pulse'];
    spo2PulseFrmRange = json['spo2_pulse_frm_range'];
    spo2PulseToRange = json['spo2_pulse_to_range'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['spo2'] = this.spo2;
    data['spo2_frm_range'] = this.spo2FrmRange;
    data['spo2_to_range'] = this.spo2ToRange;
    data['spo2_pulse'] = this.spo2Pulse;
    data['spo2_pulse_frm_range'] = this.spo2PulseFrmRange;
    data['spo2_pulse_to_range'] = this.spo2PulseToRange;
    return data;
  }

  @override
  String toString() {
    return '{spo2:$spo2, spo2_frm_range:$spo2FrmRange, spo2_to_range:$spo2ToRange, spo2_pulse_frm_range: $spo2PulseFrmRange, spo2_pulse_to_range: $spo2PulseToRange}';
  }
}

class Bloodpressure {
  String bloodPssr;
  String bloodPssrFrmRange;
  String bloodPssrToRange;
  String pulse;
  String pulseFrmRange;
  String pulseToRange;

  Bloodpressure(
      {this.bloodPssr,
        this.bloodPssrFrmRange,
        this.bloodPssrToRange,
        this.pulse,
        this.pulseFrmRange,
        this.pulseToRange});

  Bloodpressure.fromJson(Map<String, dynamic> json) {
    bloodPssr = json['bloodPssr'];
    bloodPssrFrmRange = json['bloodPssr_frm_range'];
    bloodPssrToRange = json['bloodPssr_to_range'];
    pulse = json['pulse'];
    pulseFrmRange = json['pulse_frm_range'];
    pulseToRange = json['pulse_to_range'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bloodPssr'] = this.bloodPssr;
    data['bloodPssr_frm_range'] = this.bloodPssrFrmRange;
    data['bloodPssr_to_range'] = this.bloodPssrToRange;
    data['pulse'] = this.pulse;
    data['pulse_frm_range'] = this.pulseFrmRange;
    data['pulse_to_range'] = this.pulseToRange;
    return data;
  }

  @override
  String toString() {
    return '{bloodPssr_frm_range:$bloodPssrFrmRange, bloodPssr_to_range:$bloodPssrToRange, pulse_frm_range: $pulseFrmRange, pulse_to_range: $pulseToRange}';
  }
}

class Kidney {
  String creatinine;
  String creatinineFrmRange;
  String creatinineToRange;
  String estdGlomular;
  String estdGlomularFrmRange;
  String estdGlomularToRange;
  String ureakin;
  String ureakinFrmRange;
  String ureakinToRange;
  String ureabun;
  String ureabunFrmRange;
  String ureabunToRange;
  String uricacid;
  String uricacidFrmRange;
  String uricacidToRange;

  Kidney(
      {this.creatinine,
        this.creatinineFrmRange,
        this.creatinineToRange,
        this.estdGlomular,
        this.estdGlomularFrmRange,
        this.estdGlomularToRange,
        this.ureakin,
        this.ureakinFrmRange,
        this.ureakinToRange,
        this.ureabun,
        this.ureabunFrmRange,
        this.ureabunToRange,
        this.uricacid,
        this.uricacidFrmRange,
        this.uricacidToRange});

  Kidney.fromJson(Map<String, dynamic> json) {
    creatinine = json['creatinine'];
    creatinineFrmRange = json['creatinine_frm_range'];
    creatinineToRange = json['creatinine_to_range'];
    estdGlomular = json['estdGlomular'];
    estdGlomularFrmRange = json['estdGlomular_frm_range'];
    estdGlomularToRange = json['estdGlomular_to_range'];
    ureakin = json['ureakin'];
    ureakinFrmRange = json['ureakin_frm_range'];
    ureakinToRange = json['ureakin_to_range'];
    ureabun = json['ureabun'];
    ureabunFrmRange = json['ureabun_frm_range'];
    ureabunToRange = json['ureabun_to_range'];
    uricacid = json['uricacid'];
    uricacidFrmRange = json['uricacid_frm_range'];
    uricacidToRange = json['uricacid_to_range'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['creatinine'] = this.creatinine;
    data['creatinine_frm_range'] = this.creatinineFrmRange;
    data['creatinine_to_range'] = this.creatinineToRange;
    data['estdGlomular'] = this.estdGlomular;
    data['estdGlomular_frm_range'] = this.estdGlomularFrmRange;
    data['estdGlomular_to_range'] = this.estdGlomularToRange;
    data['ureakin'] = this.ureakin;
    data['ureakin_frm_range'] = this.ureakinFrmRange;
    data['ureakin_to_range'] = this.ureakinToRange;
    data['ureabun'] = this.ureabun;
    data['ureabun_frm_range'] = this.ureabunFrmRange;
    data['ureabun_to_range'] = this.ureabunToRange;
    data['uricacid'] = this.uricacid;
    data['uricacid_frm_range'] = this.uricacidFrmRange;
    data['uricacid_to_range'] = this.uricacidToRange;
    return data;
  }
}