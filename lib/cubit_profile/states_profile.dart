import '../model/login_model.dart';

abstract class ProfileStates {
}

class InitialStatePro extends ProfileStates {}


class SuccessLogoutData extends ProfileStates {}
class ErrorLogoutData extends ProfileStates {}


class SuccessProfileData extends ProfileStates {}
class ErrorProfileData extends ProfileStates {}
class LoadingProfileData extends ProfileStates {}

class SuccessUpdateData extends ProfileStates {
  final ShopLoginModel model;

  SuccessUpdateData(this.model);
}
class ErrorUpdateData extends ProfileStates {}
class LoadingUpdateData extends ProfileStates {}
