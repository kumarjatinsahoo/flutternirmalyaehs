class OrganizatioRegistrationModel{
  String  orgid, orgname, licno, address, country, state, dist, city, pincode,
  gst, healthprovider, fileone, filetwo, filethree, filefour, extone, exttwo,
   extthree, extfour, docnameone, docnametwo, docnamethree, docnamefour;
  OrganizatioRegistrationModel();
  OrganizatioRegistrationModel.fromJson(Map<String, dynamic> json) {
    orgid = json['orgid'];//23
    orgname = json['orgname'];
    licno = json['licno'];
    address = json['address'];
    country = json['country'];
    state = json['state'];
    dist = json['dist'];
    city = json['city'];
    pincode = json['pincode'];
    gst = json['gst'];
    healthprovider = json['healthprovider'];
    fileone = json['fileone'];
    filetwo = json['filetwo'];
    filethree = json['filethree'];
    filefour = json['filefour'];
    extone = json['extone'];
    exttwo = json['exttwo'];
    extthree = json['extthree'];
    extfour = json['extfour'];
    docnameone = json['docnameone'];
    docnametwo = json['docnametwo'];
    docnamethree = json['docnamethree'];
    docnamefour = json['docnamefour'];


  }

  dynamic toJson() {
    var param={
      "orgid": this.orgid,
      "orgname": this.orgname,
      "licno": this.licno,
      "address": this.address,
      "country": this.country,
      "state": this.state,
      "dist": this.dist,
      "city": this.city,
      "pincode": this.pincode,
      "gst": this.gst,
      "healthprovider": this.healthprovider,
      "fileone": this.fileone,
      "filetwo": this.filetwo,
      "filethree": this.filethree,
      "filefour": this.filefour,
      "extone": this.extone,
      "exttwo": this.exttwo,
      "extthree": this.extthree,
      "extfour": this.extfour,
      "docnameone": this.docnameone,
      "docnametwo": this.docnametwo,
      "docnamethree": this.docnamethree,
      "docnamefour": this.docnamefour,


    };
    return param;
  }

}

