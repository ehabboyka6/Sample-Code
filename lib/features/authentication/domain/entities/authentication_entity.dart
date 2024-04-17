import 'package:equatable/equatable.dart';

class AuthenticationEntity extends Equatable {
  final String countryCode;
  final String email;
  final String firstName;
  final String lastName;

  const AuthenticationEntity({
    required this.countryCode,
    required this.email,
    required this.firstName,
    required this.lastName,
  });

  @override
  List<Object?> get props => [
        countryCode,
        email,
        firstName,
        lastName,
      ];
}
