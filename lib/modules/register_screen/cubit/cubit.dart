

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_copy/modules/register_screen/cubit/states.dart';

import '../../../model/error_model.dart';
import '../../../model/login_modelQ.dart';
import '../../../shared/network/end_points.dart';
import '../../../shared/network/remote/dio_helper.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());
  static RegisterCubit get(context) => BlocProvider.of(context);

   LoginModel ?loginModel;
   ErrorModel ?errorModel;
  void userRegiste({required email, required password,required name,required phone}) {
    emit(RegisterLoadingState());
    DioHelper.postData(
      url: Register,
      data: {'email': email, 'password': password,'name':name,'phone':phone},
    ).then((value) {
      if (value.data['status'] == true) {
        log(value.data.toString());
        loginModel = LoginModel.fromMap(value.data);
        print(loginModel?.message);
        print(loginModel?.status);
        print(loginModel?.data!.token);
        emit(RegisterSuccessState(loginModel:loginModel!));
      }else{
        errorModel = ErrorModel.fromMap(value.data);
        emit(RegisterErrorState(error: errorModel?.message));
      }
    }).catchError((error) {
      print(error.toString());
      emit(RegisterErrorState(error: "Somthing went wrong"));
    });
  }

  IconData suffix = Icons.visibility_rounded;
  bool isPassword = true;
  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_rounded : Icons.visibility_off_rounded;
    emit(ChangePassworRegisterdVisibilityState());
  }
}
