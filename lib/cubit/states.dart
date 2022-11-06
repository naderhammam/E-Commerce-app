import '../model/login_model.dart';

abstract class AppState {
}

class InitialState extends AppState {}
class LoginSuccessState extends AppState {
  final ShopLoginModel loginModel;
  LoginSuccessState(this.loginModel);
}
class LoginErrorState extends AppState {

}
class LoginLoadingState extends AppState {}
class ChangePassVisibilityState extends AppState {}

class SuccessProfileDatas extends AppState {}
class ErrorProfileDatas extends AppState {}
class LoadingProfileDatas extends AppState {}
