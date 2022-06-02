class SideMenu {
  String? cid;
  String? fp;
  List<Menu>? menu;
  String? msg;
  String? sof;

  SideMenu({this.cid, this.fp, this.menu, this.msg, this.sof});

  SideMenu.fromJson(Map<String, dynamic> json) {
    cid = json['cid'];
    fp = json['fp'];
    if (json['menu'] != null) {
      menu = <Menu>[];
      json['menu'].forEach((v) {
        menu!.add(new Menu.fromJson(v));
      });
    }
    msg = json['msg'];
    sof = json['sof'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cid'] = this.cid;
    data['fp'] = this.fp;
    if (this.menu != null) {
      data['menu'] = this.menu!.map((v) => v.toJson()).toList();
    }
    data['msg'] = this.msg;
    data['sof'] = this.sof;
    return data;
  }
}

class Menu {
  String? menu_index;
  String? menu_name;
  Menu({
    this.menu_index,
    this.menu_name,
  });

  Menu.fromJson(Map<String, dynamic> json) {
    menu_index = json['menu_index'];
    menu_name = json['menu_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_index'] = this.menu_index;
    data['menu_name'] = this.menu_name;
    return data;
  }
}
