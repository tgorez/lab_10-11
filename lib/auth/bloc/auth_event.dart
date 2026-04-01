abstract class AuthEvent {}

class RegisterRequested extends AuthEvent {
  final String email;
  final String password;

  RegisterRequested({
    required this.email,
    required this.password,
  });
}