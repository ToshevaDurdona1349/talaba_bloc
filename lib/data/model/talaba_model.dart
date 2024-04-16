class TalabaModel {
  String? sId;
  String? name;
  String? email;
  String? course;
  double? gpa;

  TalabaModel({ this.name, this.email, this.course, this.gpa});

  TalabaModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    course = json['course'];
    gpa = json['gpa'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['_id'] = this.sId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['course'] = this.course;
    data['gpa'] = this.gpa;
    return data;
  }
}