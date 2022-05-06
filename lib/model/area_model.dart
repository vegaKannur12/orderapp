class Area {
  String? aid;
  String? anme;

  Area({this.aid, this.anme});

  Area.fromJson(Map<String, dynamic> json) {
    aid = json['aid'];
    anme = json['anme'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['aid'] = this.aid;
    data['anme'] = this.anme;
    return data;
  }
}