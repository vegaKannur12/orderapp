class Balance {
  String? code;
  String? ba;

  Balance({this.code, this.ba});

  Balance.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    ba = json['ba'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['ba'] = this.ba;
    return data;
  }
}
