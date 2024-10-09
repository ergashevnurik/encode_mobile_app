class Subscriber {
  final String id;
  final String contact;
  final String firstName;
  final String last;
  final String birthday;
  final String gender;
  final String username;
  final String role;
  final String password;
  final int coins;

  Subscriber({required this.coins, required this.password, required this.firstName,required  this.last,required  this.birthday,required  this.gender, required  this.username, required this.contact, required this.id, required this.role});

  factory Subscriber.fromJson(Map<String, dynamic> json) {
    return Subscriber(
      id: json['id'],
      contact: json['contact'],
      firstName: json['firstName'],
      last: json['last'],
      birthday: json['birthday'],
      gender: json['gender'],
      username: json['username'],
      role: json['role'],
      password: json['password'],
      coins: json['coins']
    );
  }
}