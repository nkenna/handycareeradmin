class Admin {
  String id;
  String firstname;
  String middlename;
  String lastname;
  String role;
  String email;
  String status;

  Admin({
    this.id,
    this.firstname,
    this.middlename,
    this.lastname,
    this.role,
    this.email,
    this.status
  });

  factory Admin.fromJson(Map<String, dynamic> json){
    return Admin(
      id: json['_id'] as String,
      firstname: json['firstname'] as String,
      middlename: json['middlename'] as String,
      lastname: json['lastname'] as String,
      role: json['role'] as String,
      email: json['email'] as String,
      status: json['status'] as String,
      
    );
  } 

  Map toMap(){
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["firstname"] = firstname;
    map["middlename"] = middlename;
    map["lastname"] = lastname;
    map["role"] = role;
    map["email"] = email;
    map["status"] = status;
    map["access"] = role;
    
    return map;
    
  }

}