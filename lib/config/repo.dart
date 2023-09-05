


import '../providers/userDetailsProvider.dart';

class Repository {
  final UserDetailsProvider _userDetailsProvider = UserDetailsProvider();
  Future<void> fetchUserDetails() => _userDetailsProvider.get();
}
