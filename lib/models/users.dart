class User {
  String firstname;
  String middlename;
  String lastname;
  String email;
  String dob;
  String status;
  List<String> states;
  List<String> jobfunctions;
  List<String> industries;
  String joined;

  User({
    this.firstname,
    this.middlename,
    this.lastname,
    this.email,
    this.dob,
    this.status,
    this.states,
    this.jobfunctions,
    this.industries,
    this.joined
  });

  factory User.fromJson(Map<String, dynamic> json){
    return User(
      firstname: json['firstname'] as String,
      middlename: json['middlename'] as String,
      lastname: json['lastname'] as String,
      email: json['email'] as String,
      dob: json['dob'] as String,
      status: json['status'] as String,
      states: json['states'] as List,
      jobfunctions: json['jobfunctions'] as List,
      industries: json['industries'] as List,
      joined: json['joined'] as String,
           
    );
  } 

  Map toMap(){
    var map = new Map<String, dynamic>();
    map["firstname"] = firstname;
    map["middlename"] = middlename;
    map["lastname"] = lastname;
    map["email"] = email;
    map["dob"] = dob;
    map["status"] = status;
    map["states"] = states;
    map["jobfunctions"] = jobfunctions;
    map["industries"] = industries;
    map["joined"] = joined;
       
    return map;
    
  }

  

  static List<User> getUsers() {
    return <User>[
      User(
        firstname: "Ebuka", 
        middlename: "Justice",
        lastname: "Ado",
        email: "nkennannadi@gmail.com", 
        dob: (DateTime.now().subtract(Duration(days: 7300))).toString(),
        status: "activated",
        states: ["Abia", "Enugu"],
        jobfunctions: ["marketing"],
        industries: ["FCMG"],
        joined: DateTime.now().toString(), 

      ),

      User(
        firstname: "Blessing", 
        middlename: "Onyinye",
        lastname: "Nwosu",
        email: "nkennannadi@gmail.com", 
        dob: (DateTime.now().subtract(Duration(days: 8000))).toString(),
        status: "activated",
        states: ["Abia", "Enugu"],
        jobfunctions: ["marketing"],
        industries: ["FCMG"],
        joined: DateTime.now().toString(), 

      ),
    ];
  }
  
}