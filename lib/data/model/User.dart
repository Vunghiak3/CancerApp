class User{
  final String? userId;
  final String? name;
  final String? email;
  final String? role;
  final String? profilePicrutre;

  User({
    this.userId,
    this.name,
    this.email,
    this.role,
    this.profilePicrutre,
  });

  // Phương thức từ Object -> JSON (nếu cần)
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'name': name,
      'email': email,
      'profilePicrutre': profilePicrutre,
    };
  }

  // Factory method để tạo đối tượng từ JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'],
      name: json['name'],
      email: json['email'],
      role: json['role'],
      profilePicrutre: json['profilePicrutre'],
    );
  }
}
