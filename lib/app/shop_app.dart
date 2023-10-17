import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../layout/cubit/cubit.dart';
import '../layout/home_layout.dart';
import '../modules/login_screen/login_screen.dart';
import '../modules/onBoarding_Screen/onBoarding_screen.dart';
import '../shared/network/local/cash_helper.dart';
import '../shared/styles/themes/themes.dart';

class ShopApp extends StatefulWidget {
  const ShopApp({super.key});

  @override
  State<ShopApp> createState() => _ShopAppState();
}

class _ShopAppState extends State<ShopApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ShopCubit()..getHomeData()..getCategory()..getFavorit()..getUserData()),
      ],
      child: MaterialApp(
        home: home(),
        darkTheme: darkTheme,
        theme: lightTheme,
        debugShowCheckedModeBanner: false,
      ),
    );
  }

  Widget home() {
    bool? onBoarding = CashHelper.getData(key: 'onBoarding');
    String? token = CashHelper.getData(key: 'token');
    print("token: $token");
    if (onBoarding != null) {
      if (token != null) {
        return HomeLayout();
      } else {
        return LoginScreen();
      }
    } else {
      return const OnBoardingScreen();
    }
  }
}