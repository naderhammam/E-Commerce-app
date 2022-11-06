import 'package:shop_app/model/search_model.dart';

import '../model/Change_Fav_model.dart';
import '../model/login_model.dart';

abstract class ShopState {
}

class InitialState_ extends ShopState {}
class changeIndexButton extends ShopState {}
class LoadingHomeData extends ShopState {}
class SuccessHomeData extends ShopState {}
class ErrorHomeData extends ShopState {}

class SuccessCategoriesData extends ShopState {}
class ErrorCategoriesData extends ShopState {}
class SuccessChangeFirstFavData extends ShopState {}
class SuccessChangeFavData extends ShopState {
  final ChangeFavoriteModel changeFavoriteModel;

  SuccessChangeFavData(this.changeFavoriteModel);
}
class ErrorChangeFavData extends ShopState {}


class SuccessFavoritesData extends ShopState {}
class ErrorFavoritesData extends ShopState {}
class LoadingFavoriteData extends ShopState {}

class SuccessProfileData extends ShopState {}
class ErrorProfileData extends ShopState {}
class LoadingProfileData extends ShopState {}

class SuccessUpdateData extends ShopState {
  final ShopLoginModel model;

  SuccessUpdateData(this.model);
}
class ErrorUpdateData extends ShopState {}
class LoadingUpdateData extends ShopState {}


class SuccessSearchData extends ShopState {
  final SearchModel searchModel;

  SuccessSearchData(this.searchModel);
}
class ErrorSearchData extends ShopState {}
class LoadingSearchData extends ShopState {}


class SuccessLogoutData extends ShopState {}
class ErrorLogoutData extends ShopState {}

class SuccessRegisterData extends ShopState {
  final ShopLoginModel registerModel;

  SuccessRegisterData(this.registerModel);
}
class ErrorRegisterData extends ShopState {}
class LoadingRegisterData extends ShopState {}

class ChangeRegisterPassVisibilityState extends ShopState {}