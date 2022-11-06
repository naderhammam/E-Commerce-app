
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/screens/register/cubit/states.dart';

import '../../../model/login_model.dart';
import '../../../network/dio_helper.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopRegisterInitialState());

  late ShopLoginModel loginModel;

  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(ShopRegisterLoadingState());
    DioHelper.postData(
      url: 'register',
      data: {
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
      },
    ).then((value) {
      loginModel = ShopLoginModel.fromJson(value.data);
      emit(ShopRegisterSuccessState(loginModel));
    }).catchError((onError) {
      emit(ShopRegisterErrorState(onError.toString()));
      print(onError.toString());
    });
  }

  IconData suffixIcon = Icons.visibility_outlined;
  bool hidden = true;
  void changePassVissibitlty() {
    hidden = !hidden;
    suffixIcon =
        hidden ? Icons.visibility_outlined :Icons.visibility_off_outlined ;
    emit(ShopChangePassVisibilityState());
  }
}
