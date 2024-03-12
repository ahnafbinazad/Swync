class UserModel {
  final String? id;
  final String? userName;
  final String? email;

  const UserModel ({
  this.id,
  required this.email,
  required this.userName
});

toJson() {
  return {
    "userName": userName,
    "email": email,
  };
}
}

