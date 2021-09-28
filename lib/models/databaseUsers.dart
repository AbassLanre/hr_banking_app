

class Users {
  String displayName;
  String email;
  String password;
  String phone;
  String uuid;


  Users();

  Users.fromMap(Map<String, dynamic> data){
    displayName = data['displayName'];
    email = data['email'];
    password =data['password'];
    phone = data['phone'];
    uuid = data['uuid'];
  }

  Map<String, dynamic> toMap(){
    return{
      'displayName': displayName,
      'email': email,
      'password': password,
      'phone': phone,
      'uuid': uuid,
    };
  }
}