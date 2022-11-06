
import '../../../model/login_model.dart';

abstract class ShopRegisterStates{}

class ShopRegisterInitialState extends ShopRegisterStates {}

class ShopRegisterLoadingState extends ShopRegisterStates {}

class ShopRegisterSuccessState extends ShopRegisterStates {
  final ShopLoginModel model;

  ShopRegisterSuccessState(this.model);
}

class ShopRegisterErrorState extends ShopRegisterStates {
  //34an azhero 3ala el screen
  final String error;

  ShopRegisterErrorState(this.error);
}

class ShopChangePassVisibilityState extends ShopRegisterStates{}