import 'package:horsehouse/features/authentication/domain/entities/authentication_entity.dart';

class AuthenticationModel extends AuthenticationEntity {
  const AuthenticationModel({
    required super.countryCode,
    required super.email,
    required super.firstName,
    required super.lastName,
  });

  factory AuthenticationModel.fromJson(Map<String, dynamic> json) {
    return AuthenticationModel(
      countryCode: json['countryCode'],
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
    );
  }

  bool isMatchUser({required String password,required String email,required Map<String, dynamic> json}){
    return super.email==email&& json['password']==password;
  }

}
