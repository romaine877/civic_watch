class UserModel {
  String? id;
  String? name;
  String? email;
  String? role;
  double? points;
  String? photoUrl;
  double? latitude;
  double? longitude;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.role,
    this.points,
    this.photoUrl,
    this.latitude,
    this.longitude,
  });

  factory UserModel.fromSupabase(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      role: json['role'],
      points: json['points'],
      photoUrl: json['photoUrl'],
    );
  }

  factory UserModel.testUser() {
    return UserModel(
      id: 'test',
      name: 'Test User',
      email: 'test@test.com',
      role: 'user',
      points: 0,
      photoUrl: 'https://i.pravatar.cc/150?img=1',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role,
      'points': points,
      'photoUrl': photoUrl,
    };
  }

  String get firstName => name?.split(' ')[0] ?? name ?? 'Guest';
}
