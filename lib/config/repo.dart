

import '../providers/adminDetailsprovider.dart';

class Repository {
  final AdminDetailsProvider _userDetailsProvider = AdminDetailsProvider();
  Future<void> fetchUserDetails() => _userDetailsProvider.get();
}
