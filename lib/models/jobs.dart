class Job {
  String id;
  String title;
  String location;
  List age;
  String companyprofile;
  String addeddate;
  String deadline;
  String descr;
  List edu_req;
  List exp_req;
  List general_req;
  String jobfunction;
  String industry;
  String creator;
  String howtoapply;
  String apply;

  Job({
    this.id,
    this.title,
    this.location,
    this.age,
    this.companyprofile,
    this.addeddate,
    this.deadline,
    this.descr,
    this.edu_req,
    this.exp_req,
    this.general_req,
    this.jobfunction,
    this.industry,
    this.creator,
    this.howtoapply,
    this.apply
  });

  factory Job.fromJson(Map<String, dynamic> json){
    return Job(
      id: json['_id'] as String,
      title: json['title'] as String,
      location: json['location'] as String,
      age: json['age'] as List,
      companyprofile: json['companyprofile'] as String,
      addeddate: json['addeddate'] as String,
      deadline: json['deadline'] as String,
      descr: json['descr'] as String,
      edu_req: json['edu_req'] as List,
      exp_req: json['exp_req'] as List,
      general_req: json['general_req'] as List,
      jobfunction: json['jobfunction'] as String,
      industry: json['industry'] as String,
      creator: json['creator'] as String,
      howtoapply: json['howtoapply'] as String,
      apply: json['apply'] as String,
      
    );
  } 

  Map toMap(){
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["title"] = title;
    map["location"] = location;
    map["age"] = age;
    map["companyprofile"] = companyprofile;
    map["addeddate"] = addeddate;
    map["deadline"] = deadline;
    map["descr"] = descr;
    map["edu_req"] = edu_req;
    map["exp_req"] = exp_req;
    map["general_req"] = general_req;
    map["jobfunction"] = jobfunction;
    map["industry"] = industry;
    map["creator"] = creator;
    map["howtoapply"] = howtoapply;
    map["apply"] = apply;
    
    return map;
    
  }

  

  static List<Job> getJobs() {
    return <Job>[
      Job(
        title: "Sales Person", 
        location: "Abuja",
        age: [20, 35], 
        addeddate: DateTime.now().toString(), 
        deadline: DateTime.now().toString(),
        descr: "marketing job",
        edu_req: ["must be a graduate", "BSC or HND holder"],
        exp_req: ["experience of 2years in marketing"],
        general_req: ["must be computer literate"],
        jobfunction: "marketing",
        industry: "FCMG",
        creator: "nkennannadi@gmail.com"
        ),

        Job(
        title: "Sales Manager", 
        location: "Enugu", 
        age: [20, 35],
        addeddate: DateTime.now().toString(), 
        deadline: DateTime(2020, 8).toString(),
        descr: "marketing job",
        edu_req: ["must be a graduate", "BSC or HND holder"],
        exp_req: ["experience of 2years in marketing"],
        general_req: ["must be computer literate"],
        jobfunction: "marketing",
        industry: "FCMG",
        creator: "nkennannadi@gmail.com"
        ),
    ];
  }
}