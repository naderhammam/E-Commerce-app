import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit_profile/cubit_profile.dart';
import 'package:shop_app/layout/shopLayout.dart';
import 'package:shop_app/network/cache_helper.dart';
import 'package:shop_app/network/dio_helper.dart';
import 'package:shop_app/screens/login/login.dart';
import 'package:shop_app/screens/login/onboarding.dart';
import 'package:shop_app/shared/blocObser.dart';
import 'package:shop_app/shared/component.dart';

import 'cubit/cubit.dart';
import 'cubit_shop/cubit_shop.dart';
import 'cubit_shop/states_shop.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  DioHelper.init();
 token = CacheHelper.getData(key: 'token');
 print(token);
  bool? ifOnBoarding = CacheHelper.getData(key: 'onBoarding');
  Widget widget;
  if (ifOnBoarding != null) {
    if (token != null) {
      widget = const ShopLayout();
    } else {
      widget = const LoginScreen();
    }
  } else {
    widget = const OnBoarding();
  }
  BlocOverrides.runZoned(
        () {
          runApp(MyApp(
            // ifOnBoarding: ifOnBoarding,
            // ifLogin: ifLogin,
            child: widget,
          ));
    },
    blocObserver: MyBlocObserver(),
  );

}

class MyApp extends StatelessWidget {
  // final bool ifOnBoarding;
  // final bool ifLogin;
  final Widget child;

  const MyApp({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ShopCubit(),
        ),
        BlocProvider(
          create: (context) => ShopLoginCubit(),
        ),
        BlocProvider(
          create: (context) => ProfileCubit()..getProfileData(),
        ),
      ],
      child: BlocConsumer<ShopCubit, ShopState>(
        listener: (context, state) {
        },
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.teal,

              appBarTheme: const AppBarTheme(
                iconTheme: IconThemeData(
                  color: Colors.black,
                ),
                systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarIconBrightness: Brightness.dark,
                    statusBarColor: Colors.white),
                actionsIconTheme: IconThemeData(color: Colors.black,
                ),
                color: Colors.white,
                elevation: 0,
                titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              scaffoldBackgroundColor: Colors.white,
              textTheme: const TextTheme(
                bodyText1: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              fontFamily: 'Jannah',
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                backgroundColor: Colors.white,
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.teal,
              ),
            ),
            darkTheme: ThemeData(
              primarySwatch: Colors.teal,
              appBarTheme: const AppBarTheme(
                systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarIconBrightness: Brightness.light,
                    statusBarColor: Colors.black12),
                color: Colors.black,
                elevation: 0,
                titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              scaffoldBackgroundColor: Colors.black12,
              textTheme: const TextTheme(
                bodyText1: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              fontFamily: 'Jannah',
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                backgroundColor: Colors.black12,
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.teal,
                unselectedItemColor: Colors.grey,
              ),
            ),
            //themeMode:ThemeMode.light,
            home:child,
          );
        },
      ),
    );
  }
}
