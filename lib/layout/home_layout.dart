import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app_copy/layout/cubit/cubit.dart';
import 'package:shop_app_copy/layout/cubit/states.dart';

import '../modules/search_screen/search_screen.dart';
import '../shared/components/components.dart';
import '../shared/styles/colors.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    ShopCubit cubit=ShopCubit.get(context);
    return BlocConsumer<ShopCubit,ShopStates>(
      builder: (context,state)=>Scaffold(
        appBar: AppBar(
          title: Text(cubit.titles[cubit.currentIndex],
          style: GoogleFonts.abel(
            color: defualtColor2,
            fontSize: 25,
          ),
          ),
          actions: [
            IconButton(onPressed: (){
              moveTo(context, SearchScreen());
            }, 
            icon:const Icon(Icons.search_rounded,color: defualtColor2,),
            ),
          ],
        ),
        body: cubit.screens[cubit.currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex:cubit.currentIndex,
          onTap: (index){
            cubit.changeBottomNave(index);
          },
          items:const[
            //home
            BottomNavigationBarItem(
            icon:Icon(Icons.home_rounded),
            label: "Home",
            ),
            //categores
            BottomNavigationBarItem(
            icon:Icon(Icons.category_rounded),
            label: "Category",
            ),
            //products
            BottomNavigationBarItem(
            icon:Icon(Icons.favorite_rounded),
            label: "Favorit",
            ),
            //settings
            BottomNavigationBarItem(
            icon:Icon(Icons.settings_rounded),
            label: "Settings",
            ),
          ],
          ),
      ),
      listener: (context,state){}
      );
  }
}