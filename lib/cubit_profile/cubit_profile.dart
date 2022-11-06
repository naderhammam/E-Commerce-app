
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/cubit_profile/states_profile.dart';

import '../model/login_model.dart';
import '../network/cache_helper.dart';
import '../network/dio_helper.dart';
import '../screens/login/login.dart';
import '../shared/component.dart';

class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit() : super(InitialStatePro());

  static ProfileCubit get(context) => BlocProvider.of(context);

  void signOut_(context) {
    CacheHelper.removeData(key: 'token').then((value) {
      if (value) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
              (route) => false,
        );
      }

      emit(SuccessLogoutData());
    }).onError((error, stackTrace) {
      print(error);
      emit(ErrorLogoutData());
    });
  }

   ShopLoginModel ?UserDatas;
  void getProfileData() {
    emit(LoadingProfileData());
    DioHelper.getData(
      url: 'profile',
      token: token,
    ).then((value) {
      UserDatas = ShopLoginModel.fromJson(value.data);
      print(UserDatas!.data!.name);
      emit(SuccessProfileData());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorProfileData());
    });
  }

  void getUpdateData({
    required String name,
    required String email,
    required String phone,
    String? password,
  }) {
    emit(LoadingUpdateData());
    DioHelper.putData(
      url: 'update-profile',
      token: token,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
        'password': password,
      },
    ).then((value) {
      UserDatas = ShopLoginModel.fromJson(value.data);
      print(UserDatas!.data!.name);
      Fluttertoast.showToast(
          msg: "Update Successfully ✔",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );

      emit(SuccessUpdateData(UserDatas!));
    }).catchError((error) {
      print(error.toString());
      emit(ErrorUpdateData());
    });
  }



}