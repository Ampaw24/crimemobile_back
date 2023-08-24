class UserModule {
  String profile_url;
  String userName;
  String department;
  String userId;
  String currentLevel;
  bool hostelStatus;

  UserModule(
      {required this.currentLevel,
      required this.department,
      required this.hostelStatus,
      required this.profile_url,
      required this.userId,
      required this.userName});
}
