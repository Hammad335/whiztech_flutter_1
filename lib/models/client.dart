class Client {
  String name;
  String phone;
  String email;
  String address;

  Client({
    required this.name,
    required this.phone,
    required this.email,
    required this.address,
  });

  Map<String, Object> toJson() {
    return {
      'name': name,
      'phone': phone,
      'email': email,
      'address': address,
    };
  }

  static Client fromJson(Map<String, dynamic> jsonClient) {
    return Client(
      name: jsonClient['name'] as String,
      phone: jsonClient['phone'] as String,
      email: jsonClient['email'] as String,
      address: jsonClient['address'] as String,
    );
  }
}
