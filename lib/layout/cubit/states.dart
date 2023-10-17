import '../../model/favorit_model.dart';
import '../../model/login_modelQ.dart';

abstract class ShopStates{}
class ShopInisialState extends ShopStates{}

class ChangeBottomNav extends ShopStates{}

class HomeLoadingDataState extends ShopStates{}

class HomeSuccessDataState extends ShopStates{}

class HomeErrrorDataState extends ShopStates{}

class CategoryLoadingDataState extends ShopStates{}

class CategorySuccessDataState extends ShopStates{}

class CategoryErrrorDataState extends ShopStates{}

class ChangeFvoritSuccessState extends ShopStates{
  final FavoritModel ?favoritModel;
  ChangeFvoritSuccessState({this.favoritModel});
}
class ChangeFvoritState extends ShopStates{}

class ChangeFvoritErrorState extends ShopStates{}

class GetFvoritLoadingState extends ShopStates{}

class GetFvoritSuccessState extends ShopStates{}

class GetFvoritErrorState extends ShopStates{}

class GetUserLoadingDataState extends ShopStates{}

class GetUserSuccessDataState extends ShopStates{
  final LoginModel ?getUser;
  GetUserSuccessDataState({this.getUser});
}

class GetUserErrrorDataState extends ShopStates{}

class UpdateUserLoadingDataState extends ShopStates{}

class UpdateUserSuccessDataState extends ShopStates{
  final LoginModel ?updateUser;
  UpdateUserSuccessDataState({this.updateUser});
}

class UpdateUserErrrorDataState extends ShopStates{
  final String ?error;
  UpdateUserErrrorDataState({this.error});
}