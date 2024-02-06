class User {
  User({
    required this.profile,
  });
  late String profile;

  User.fromJson(Map<String, dynamic> json) {
    profile = json['image'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['profile'] = profile;

    return data;
  }
}
