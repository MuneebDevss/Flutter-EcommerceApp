import 'package:ecommerce_app/Features/Auth/Domain/Repository/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Event class
abstract class AuthEvent {}

class CheckIfFirstTimeEvent extends AuthEvent {}
class EmailConfirmation extends AuthEvent{}
class RegisterUserEvent extends AuthEvent
{
  final String firstName;
  final String lastName;
  final String email;
  final String userName;
  final String phoneNumber;
  final String password;
  RegisterUserEvent({required this.firstName, required this.lastName, required this.email, required this.userName, required this.phoneNumber, required this.password});
}
class GoogleSignIn extends AuthEvent{

}
class SignInEvent extends AuthEvent
{
  final String email;
  final String password;

  SignInEvent({required this.email, required this.password});
}
// Initial state
class AuthState {}
class SignedIn extends AuthState{}
class AuthInitial extends AuthState {}

  class IsFirstTime extends AuthState {
  final String isFirstTime;

  IsFirstTime({required this.isFirstTime});
}
//Email Confirmation
class EmailSent extends AuthState
{

}
//Registration States
class UserRegistered extends AuthState{
  final String email;

  UserRegistered({required this.email});
}
class Failure extends AuthState {
  final String message;

  Failure({required this.message});
}

class BannerLoading extends AuthState {}

// Bloc class
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository rep;

  AuthBloc({required this.rep}) : super(AuthInitial()) {
    on<CheckIfFirstTimeEvent>(_onCheckIfFirstTime);
    on<RegisterUserEvent>(_registerUser);
    on<SignInEvent>(_signInUser);
    on<GoogleSignIn>(_googleSignIn);
    on<EmailConfirmation>(_sendVerificationEmail);
  }

  Future<void> _registerUser(RegisterUserEvent event, Emitter<AuthState> emit) async {
    emit(BannerLoading());
    final res=await rep.authenticateUser(event.email, event.password, event.firstName, event.phoneNumber, event.lastName, event.userName);
    res.fold(
          (l) => emit(Failure(message: l)),
          (r) => emit(UserRegistered(email: r.email)),
    );
  }Future<void> _sendVerificationEmail(EmailConfirmation event, Emitter<AuthState> emit) async {
    emit(BannerLoading());
    final res=await rep.emailVerification();
    res.fold(
          (l) => emit(Failure(message: l)),
          (r) => emit(EmailSent()),
    );
  }
  Future<void> _signInUser(SignInEvent event, Emitter<AuthState> emit) async {
    emit(BannerLoading());
    final res=await rep.signIn(event.email, event.password);
    res.fold(
          (l) => emit(Failure(message: l)),
          (r) => emit(SignedIn()),
    );
  }
  Future<void> _googleSignIn(GoogleSignIn event, Emitter<AuthState> emit) async {
    emit(BannerLoading());

    final res=await rep.googleSignIn();
    res.fold(
          (l) => emit(Failure(message: l)),
          (r) => emit(SignedIn()),
    );
  }
  Future<void> _onCheckIfFirstTime(CheckIfFirstTimeEvent event, Emitter<AuthState> emit) async {
    emit(BannerLoading());
    final res = await rep.checkIfFirstTime();
    res.fold(
          (l) => emit(Failure(message: l)),
          (r) => emit(IsFirstTime(isFirstTime: r)),
    );
  }
}
