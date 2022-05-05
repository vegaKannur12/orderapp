class RegistrationData {
  String? cid;
  String? fp;
  String? os;
  String? cD;
  String? msg;

  RegistrationData({this.cid, this.fp, this.os, this.cD, this.msg});

  RegistrationData.fromJson(Map<String, dynamic> json) {
    cid = json['cid'];
    fp = json['fp'];
    os = json['os'];
    cD = json['c_d'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cid'] = this.cid;
    data['fp'] = this.fp;
    data['os'] = this.os;
    data['c_d'] = this.cD;
    data['msg'] = this.msg;
    return data;
  }
}