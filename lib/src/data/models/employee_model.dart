class Employee {
  int? id;
  String? name;
  String? position;
  double? salary;
  String? email;
  String? phoneNumber;
  String? address;
  String? department;
  String? photo; // Store photo path or image data

  Employee({
    this.id,
    this.name,
    this.position,
    this.salary,
    this.email,
    this.phoneNumber,
    this.address,
    this.department,
    this.photo,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'position': position,
      'salary': salary,
      'email': email,
      'phoneNumber': phoneNumber,
      'address': address,
      'department': department,
      'photo': photo,
    };
  }

  factory Employee.fromMap(Map<String, dynamic> map) {
    return Employee(
      id: map['id'],
      name: map['name'],
      position: map['position'],
      salary: map['salary'],
      email: map['email'],
      phoneNumber: map['phoneNumber'],
      address: map['address'],
      department: map['department'],
      photo: map['photo'],
    );
  }
}
