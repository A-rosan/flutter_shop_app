import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_copy/layout/cubit/states.dart';

import '../../model/category_model.dart';
import '../../model/favorit_model.dart';
import '../../model/get_favorit_model.dart';
import '../../model/home_model.dart';
import '../../model/login_modelQ.dart';
import '../../modules/categores_screen/categores_screen.dart';
import '../../modules/favorit_screen/favorit_screen.dart';
import '../../modules/products_screen/products_screen.dart';
import '../../modules/settings_screen/settings_screen.dart';
import '../../shared/network/end_points.dart';
import '../../shared/network/local/cash_helper.dart';
import '../../shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInisialState());
  static ShopCubit get(context) => BlocProvider.of(context);
  String? token = CashHelper.getData(key: 'token');
  int currentIndex = 0;
  List<String> titles = [
    "Products",
    "Category",
    "Favorits",
    "Settings",
  ];
  List<Widget> screens = [
    const ProductsScreen(),
    const CategoresScreen(),
    const FavoritScreen(),
    SettingsScreen(),
  ];
  HomeModel? homeModel;
  CategoryModel ?categoryModel;
  FavoritModel ?favoritModel;
  GetFavModel ?getFavModel;
  LoginModel ?userData; 
  Map<int?,bool?>favorits={};

  //ChangeBottomNaveBar
  void changeBottomNave(int index) {
    currentIndex = index;
    emit(ChangeBottomNav());
  }
  //Home "Products"
  void getHomeData() {
    emit(HomeLoadingDataState());
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromMap(value.data);
      print(homeModel?.status.toString());
      //print(homeModel?.message.toString());
      //print(homeModel?.data?.banners?[0].id);
      homeModel?.data?.products?.forEach((element){
        favorits.addAll({
            element.id:element.inFavorites,
        });
      });
      print(favorits);
      emit(HomeLoadingDataState());
    }).catchError((error) {
      print(error.toString());
      emit(HomeErrrorDataState());
    });
  }
  //Get Category 
  void getCategory() {
    emit(CategoryLoadingDataState());
    DioHelper.getData(
      url: CATEGORY,
    ).then((value) {
      categoryModel = CategoryModel.fromMap(value.data);
    }).catchError((error) {
      print(error.toString());
      emit(CategoryErrrorDataState());
    });
  }
  //Change favorit
  void changeFavorit(int ?productId){
    favorits[productId]= !favorits[productId]!;
    emit(ChangeFvoritState());
    DioHelper.postData(
      url: FAVORIT,
      data: {
        'product_id': productId
      },
      token: token,
      )
    .then(
      (value){
        favoritModel=FavoritModel.fromMap(value.data);
        //print(value.data);
        if (favoritModel?.status==false) {
          favorits[productId]= !favorits[productId]!;
        }else{
          getFavorit();
        }
        emit(ChangeFvoritSuccessState(favoritModel: favoritModel));
      }
      ).catchError(
        (errror){
          favorits[productId]= !favorits[productId]!;
          print(errror.toString());
          emit(ChangeFvoritErrorState());
        }
        );
  }
  void getFavorit(){
    emit(GetFvoritLoadingState());
    DioHelper.getData(
      url: FAVORIT,
      token: token
      )
      .then(
        (value){
          getFavModel=GetFavModel.fromMap(value.data);
          //print(value.data);
          emit(GetFvoritSuccessState());
        }
      ).catchError(
        (error){
          print("get favorit error: ${error.toString()}");
          emit(GetFvoritErrorState());
        }
        );
  }
  //Get UserData
  void getUserData(){
    emit(GetUserLoadingDataState());
    DioHelper.getData(
      url: PROFILE,
      token: token
      )
      .then(
        (value){
          userData=LoginModel.fromMap(value.data);
          print(value.data);
          emit(GetUserSuccessDataState(getUser: userData));
        }
      ).catchError(
        (error){
          print("get User error: ${error.toString()}");
          emit(GetUserErrrorDataState());
        }
        );
  }
  void updateUserData(
    {
      required String name,
      required String phone,
      required String email,
    }){
    emit(UpdateUserLoadingDataState());
    DioHelper.putData(
      url: UPDATE,
      token: token,
      data: {
        'name':name,
        'email':email,
        'phone':phone,
      }
      )
      .then(
        (value){
          userData=LoginModel.fromMap(value.data);
          print(value.data);
          emit(UpdateUserSuccessDataState(updateUser: userData));
        }
      ).catchError(
        (error){
          print("get User error: ${error.toString()}");
          emit(UpdateUserErrrorDataState());
        }
        );
  }
}