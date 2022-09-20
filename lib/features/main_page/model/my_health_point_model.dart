class MyHealthPointModel {
  int? countHealthPoint;
  String? date;

  MyHealthPointModel({this.countHealthPoint, this.date});

  MyHealthPointModel.fromJson(Map<String, dynamic> json) {
    countHealthPoint = json['countHealthPoint'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['countHealthPoint'] = this.countHealthPoint;
    data['date'] = this.date;
    return data;
  }
}
