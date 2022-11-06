import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/screens/shop/search.dart';

import '../cubit_profile/cubit_profile.dart';
import '../cubit_shop/cubit_shop.dart';
import '../cubit_shop/states_shop.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
          ShopCubit()
            ..getHomeData()
            ..getCategoriesData()
            ..getFavoriteData(),
        ),
        BlocProvider(
          create: (context) => ProfileCubit()..getProfileData(),
        ),
      ],
      child: BlocConsumer<ShopCubit, ShopState>(
        listener: (context, state) {
          if (state is SuccessLogoutData) {
            ShopCubit
                .get(context)
                .currentIndex = 0;
          }
        },
        builder: (context, state) {
          var cubit = ShopCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text('O-Bama',
                  style: TextStyle(fontWeight: FontWeight.w500)),
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SearchScreen(),
                          ));
                    },
                    icon: const Icon(Icons.search)),
              ],
            ),
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.apps),
                  label: 'Categories',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite),
                  label: 'Favorites',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: 'Settings',
                ),
              ],
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeScreen(index);
              },
            ),
          );
        },
      ),
    );
  }
}
