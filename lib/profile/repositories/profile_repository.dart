import '../models/profile.dart';
import '../services/api_service.dart';

class ProfileRepository {
  final ApiService apiService;

  ProfileRepository({required this.apiService});

  Future<Profile> getProfile() async {
    return await apiService.getProfile();
  }
}