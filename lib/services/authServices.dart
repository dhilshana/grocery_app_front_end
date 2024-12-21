import 'dart:convert';

import 'package:grocery_app/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthServices {
  

Future<void> saveToken(int token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('token', token);
  }

  Future<int?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('token');
  }

  Future<Map<String, dynamic>> register(
      {required String name,
      required String email,
      required String password,
      required String number}) async {
    String signupUrl = '$baseUrl/register/';

    try {
      final response = await http.post(Uri.parse(signupUrl), body: {
        'name': name,
        'email': email,
        'password': password,
        'number': number
      });
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        final token = data['data']['login_id'];
        saveToken(token);
        return jsonDecode(response.body);
      } else {
        final result = jsonDecode(response.body);
        throw result['errors'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String,dynamic>> login({required String email,required String password}) async{
  String loginUrl = '$baseUrl/login/';
  try{
    final response = await http.post(Uri.parse(loginUrl),body: {
      'email':email,
      'password':password,
    });
    if(response.statusCode == 200){
      Map<String, dynamic> data = jsonDecode(response.body);
        final token = data['data']['login_id'];
        saveToken(token);
        return data;
    }
    else{
      throw jsonDecode(response.body)['message'];
    }
  }
  catch(e){
    rethrow;
  }
  }

  Future<Map<String,dynamic>> verifyEmailandPassword({required String email,required String number})async{
    String forgotPasswordUrl = '$baseUrl/forgotpassword/';
    try{
      final response = await http.post(Uri.parse(forgotPasswordUrl),body: {
        'email':email,
        'number':number
      });
      if(response.statusCode == 200){
        Map<String,dynamic> data =jsonDecode(response.body);
        return data;
        
      }
      else{
        throw jsonDecode(response.body)['message'];
      }

    }
    catch(e){
      rethrow;
    }
  }

  Future<Map<String,dynamic>> changePassword({required int id,required String newPassword})async{
    String changePasswordUrl = '$baseUrl/changepassword/$id';
    try{
      final response = await http.put(Uri.parse(changePasswordUrl),body: {
        'newpassword':newPassword
      });
      if(response.statusCode == 200){
        return jsonDecode(response.body);
      }
      else{
        print('else  ${response.statusCode}');
        throw Exception(jsonDecode(response.body));
      }

    }catch(e){
      print('catch $e');
      rethrow;
    }
  }
}
