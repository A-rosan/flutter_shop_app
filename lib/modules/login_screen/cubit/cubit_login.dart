

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_copy/modules/login_screen/cubit/states_login.dart';

import '../../../model/error_model.dart';
import '../../../model/login_modelQ.dart';
import '../../../shared/network/end_points.dart';
import '../../../shared/network/remote/dio_helper.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());
  static LoginCubit get(context) => BlocProvider.of(context);

   LoginModel ?loginModel;
   ErrorModel ?errorModel;
  void userLogin({required email, required password}) {
    emit(LoginLoadingState());
    DioHelper.postData(
      url: LOGIN,
      data: {'email': email, 'password': password},
    ).then((value) {
      if (value.data['status'] == true) {
        log(value.data.toString());
        loginModel = LoginModel.fromMap(value.data);
        print(loginModel?.message);
        print(loginModel?.status);
        print(loginModel?.data!.token);
        emit(LoginSuccessState(loginModel:loginModel!));
      }else{
        errorModel = ErrorModel.fromMap(value.data);
        emit(LoginErrorState(error: errorModel?.message));
      }
    }).catchError((error) {
      print(error.toString());
      emit(LoginErrorState(error: "Somthing went wrong"));
    });
  }

  IconData suffix = Icons.visibility_rounded;
  bool isPassword = true;
  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_rounded : Icons.visibility_off_rounded;
    emit(ChangePasswordVisibilityState());
  }
}
