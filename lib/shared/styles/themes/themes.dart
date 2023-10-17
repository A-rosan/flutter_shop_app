//dark
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

import '../colors.dart';

ThemeData darkTheme=ThemeData(
              scaffoldBackgroundColor: HexColor('333739'),
              primarySwatch: defualtColor1,
              //appBar
              appBarTheme: AppBarTheme(
                titleSpacing: 10,
                iconTheme: IconThemeData(color: Colors.white),
                titleTextStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 20.0,
                ),
                elevation: 0,
                backgroundColor: HexColor('333739'),
                //statusBar
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: HexColor('333739'),
                  statusBarIconBrightness: Brightness.light,
                ),
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                backgroundColor: HexColor('333739'),
                selectedItemColor: defualtColor1,
                unselectedItemColor: Colors.grey,
                elevation: 20.0,
              ),

              textTheme: const TextTheme(
                  bodyText1: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              )),
            );

ThemeData lightTheme=ThemeData(
              // useMaterial3: true,
              primarySwatch: defualtColor1,
              scaffoldBackgroundColor: Colors.white,
              //appBar
              appBarTheme: const AppBarTheme(
                titleSpacing: 10,
                titleTextStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 20.0,
                ),
                elevation: 0.0,
                backgroundColor: Colors.white,
                //statusBar
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark,
                ),
              ),
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: defualtColor2,
              ),
              floatingActionButtonTheme:  FloatingActionButtonThemeData(
                backgroundColor: defualtColor1,
              ),

              textTheme: const TextTheme(
                  bodyText1: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
              )),
            );