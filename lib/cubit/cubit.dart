import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/states.dart';
import '../model/login_model.dart';
import '../network/cache_helper.dart';
import '../network/dio_helper.dart';
import '../shared/component.dart';

class ShopLoginCubit extends Cubit<AppState> {
  ShopLoginCubit() : super(InitialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(LoginLoadingState());
    DioHelper.postData(url: 'login', data: {
      'email': email,
      'password': password,
    }).then((value) {
      ShopLoginModel loginModel = ShopLoginModel.fromJson(value.data);
      CacheHelper.saveData(key: 'token', value: loginModel.data!.token)
          .then((value) {
        token = loginModel.data!.token;
      });

      emit(LoginSuccessState(loginModel));
    }).onError((error, stackTrace) {

      print(error);
      emit(LoginErrorState());
    });
  }

  bool isPass = true;
  IconData icon = Icons.visibility_outlined;

  void changeVisibilityPass() {
    isPass = !isPass;
    icon = isPass ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangePassVisibilityState());
  }
}
