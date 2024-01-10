import 'dart:typed_data';

class Detail {
  int? id;
  String? name;
  int? age;
  int? salary;
  String? role;
  String? cmpName;
  String? city;
  Uint8List? image;

  Detail({
    this.id,
    required this.name,
    required this.age,
    required this.salary,
    required this.role,
    required this.cmpName,
    required this.city,
    this.image
  });

  factory Detail.fromMap(Map<String,dynamic> data){
    return Detail(
        id: data['id'],
        name: data['name'],
        age: data['age'],
        salary: data['salary'],
        role: data['role'],
        cmpName: data['cmp_name'],
        city: data['city'],
        image: data['image'],
    );
  }
}
