class CompanyModel {
  String? comid;
  String? comanme;

  CompanyModel({this.comid, this.comanme});

  CompanyModel.fromJson(Map<String, dynamic> json) {
    comid = json['comid'];
    comanme = json['comanme'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['comid'] = this.comid;
    data['comanme'] = this.comanme;
    return data;
  }
}