class MyCatalogModel {
  String? id;
  String? date;
  String? name;
  int? salarySAR;
  int? salaryPoint;

  MyCatalogModel({
    this.id,
    this.date,
    this.name,
    this.salaryPoint,
    this.salarySAR,
  });

  MyCatalogModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    // name = json['name'];
    // salarySAR = json['salarySAR'];
    // salaryPoint = json['salaryPoint'];
  }
  MyCatalogModel.MergeModel(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    name = json['name'];
    salarySAR = json['salarySAR'];
    salaryPoint = json['salaryPoint'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['name'] = this.name;
    data['salarySAR'] = this.salarySAR;
    data['salaryPoint'] = this.salaryPoint;
    return data;
  }
}
