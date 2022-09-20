class CatalogModel {
  int? id;
  String? name;
  int? salarySAR;
  int? salaryPoint;

  CatalogModel({this.name, this.salarySAR, this.salaryPoint});
  
  CatalogModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    salarySAR = json['salarySAR'];
    salaryPoint = json['salaryPoint'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['salarySAR'] = this.salarySAR;
    data['salaryPoint'] = this.salaryPoint;
    return data;
  }
}
