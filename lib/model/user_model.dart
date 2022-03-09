class UserModel {
  String? uid;
  String? email;
  String? firstName;
  String? secondName;
  String? vacStatus;
  bool? admin;

  UserModel({this.uid,this.email, this.firstName, this.secondName, this.vacStatus, this.admin});

  // data from server
  factory UserModel.fromMap(map){
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      firstName: map['firstName'],
      secondName: map['secondName'],
      vacStatus: map['vacStatus'],
      admin: map['admin']
    );
}
//sending to server
Map<String, dynamic> toMap(){
    return{
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'secondName': secondName,
      'vacStatus': vacStatus,
      'admin' : admin,
    };
}
}