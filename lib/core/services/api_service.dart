import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://devapiv4.dealsdray.com/api/v2';

  static Future<Map<String, dynamic>> addDeviceInfo(Map<String, dynamic> deviceInfo) async {
    final response = await http.post(
      Uri.parse('$baseUrl/user/device/add'),
      body: json.encode(deviceInfo),
      headers: {'Content-Type': 'application/json'},
    );
    return _handleResponse(response);
  }

  static Future<Map<String, dynamic>> sendOtp(String mobileNumber, String deviceId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/user/otp'),
      body: json.encode({
        'mobileNumber': mobileNumber,
        'deviceId': deviceId,
      }),
      headers: {'Content-Type': 'application/json'},
    );
    return _handleResponse(response);
  }

  static Future<Map<String, dynamic>> verifyOtp(String otp, String deviceId, String userId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/user/otp/verification'),
      body: json.encode({
        'otp': otp,
        'deviceId': deviceId,
        'userId': userId,
      }),
      headers: {'Content-Type': 'application/json'},
    );
    return _handleResponse(response);
  }

  static Future<Map<String, dynamic>> registerUser(String email, String password, String referralCode, String userId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/user/email/referral'),
      body: json.encode({
        'email': email,
        'password': password,
        'referralCode': referralCode,
        'userId': userId,
      }),
      headers: {'Content-Type': 'application/json'},
    );
    return _handleResponse(response);
  }

  static Future<Map<String, dynamic>> _handleResponse(http.Response response) async {
    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        return json.decode(response.body);
      } else {
        return {'status': 'error', 'message': 'Unexpected response from server', 'response': response.body};
      }
    } catch (e) {
      return {'status': 'error', 'message': 'Error parsing response', 'response': response.body};
    }
  }
}
