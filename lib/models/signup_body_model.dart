class SignUpBody{
  final String email;
  final String password;
  final String name;
  final String phone;
  SignUpBody({
    required this.email,
    required this.password,
    required this.name,
    required this.phone,
  });
  Map<String, dynamic>toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['f_name'] = name;
    data['phone'] = phone;
    data['email'] = email;
    data['password'] = password;
    return data;
  }
}