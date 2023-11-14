
import '../models/user.dart';
import '../services/api_service.dart';

class UserRepository {
  final ApiService apiService; // Instance of the ApiService class to perform API requests.

  UserRepository({required this.apiService});

  Future<List<User>> getUsers() async {
    try {
      // Call the getUsers() method from the ApiService to fetch user data from the API.
      final data = await apiService.getUsers();

      // Map the API response data to a List of User objects using the User.fromJson() constructor.
      return data.map((json) => User.fromJson(json)).toList();

    } catch (e) {
      // If an exception occurs during the API call, throw an exception with an error message.
      throw Exception('Failed to fetch users');
    }
  }
}