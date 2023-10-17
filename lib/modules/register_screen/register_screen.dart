

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_copy/modules/register_screen/cubit/cubit.dart';
import 'package:shop_app_copy/modules/register_screen/cubit/states.dart';

import '../../shared/components/components.dart';
import '../../shared/network/local/cash_helper.dart';
import '../../shared/styles/colors.dart';
import '../login_screen/login_screen.dart';

class RegisterScreen extends StatelessWidget {
   RegisterScreen({super.key});
  var formRegisterKey=GlobalKey<FormState>();
  TextEditingController nameController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  TextEditingController phoneController=TextEditingController();
  TextEditingController passwordController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>RegisterCubit(),
      child: BlocConsumer<RegisterCubit,RegisterStates>(
        listener: (context,state){
          if (state is RegisterSuccessState) {
            print(state.loginModel?.message);
            print(state.loginModel?.data!.token);
            CashHelper.saveData(
              key: 'token',
              value: state.loginModel?.data?.token,
            ).then((value) {
              showToast(
                msg: state.loginModel?.message.toString() ??
                    "something went wrong",
                toastState: ChoseState.SUCCESS,
              );
              moveToAndFinish(context, LoginScreen());
            });
          }
          if (state is RegisterErrorState) {
            showToast(
              msg: state.error ?? "somthing went Wrong",
              toastState: ChoseState.ERROR,
            );
          }
        },
        builder: (context,state){
          return GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
            child: Scaffold(
              appBar: AppBar(),
              body: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formRegisterKey,
                      child: Column(
                        children: [
                          const Image(
                              image: AssetImage('assets/images/loginPic.png')),
                          //name
                          defualtTxtForm(
                            controller: nameController,
                            type: TextInputType.name,
                            label: "Enter your Name",
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter your Name";
                              }
                              return null;
                            },
                            prefixIcon: Icons.person_rounded,
                            radius: 10,
                            iconColor: defualtColor2,
                            fontWeight: FontWeight.bold,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          //email
                          defualtTxtForm(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            label: "Enter your Email",
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter your Email";
                              }
                              return null;
                            },
                            prefixIcon: Icons.email_rounded,
                            radius: 10,
                            iconColor: defualtColor2,
                            fontWeight: FontWeight.bold,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          //phone
                          defualtTxtForm(
                            controller: phoneController,
                            type: TextInputType.phone,
                            label: "Enter your Phone",
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter your Phone";
                              }
                              return null;
                            },
                            prefixIcon: Icons.phone_android_rounded,
                            radius: 10,
                            iconColor: defualtColor2,
                            fontWeight: FontWeight.bold,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          //password
                          defualtTxtForm(
                            controller: passwordController,
                            type: TextInputType.visiblePassword,
                            label: "Password",
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter your password";
                              }
                              return null;
                            },
                            prefixIcon: Icons.lock_rounded,
                            suffixIcon: RegisterCubit.get(context).suffix,
                            isPassword: RegisterCubit.get(context).isPassword,
                            suffixFunction: () {
                              RegisterCubit.get(context)
                                  .changePasswordVisibility();
                            },
                            radius: 10,
                            iconColor: defualtColor2,
                            onSubmitted: (value) {},
                            fontWeight: FontWeight.bold,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          //Register button
                          ConditionalBuilder(
                            condition:state is! RegisterLoadingState,
                            builder: (context)=>defualtButton(
                              text: "Register Now",
                              onPressed: () {
                                 if (formRegisterKey.currentState != null &&
                                      formRegisterKey.currentState!.validate()) {
                                    RegisterCubit.get(context).userRegiste(
                                      email: emailController.text.trim(),
                                      password: passwordController.text.trim(),
                                      name:nameController.text.trim(),
                                      phone:phoneController.text.trim(),
                                    );
                                  } else {
                                    print("Register error");
                                  }
                              },
                              color: defualtColor2,
                              raduis: 10,
                              isUpperCase: false,
                              fontSize: 18,
                            ), 
                            fallback: (context)=> const Center(child: CircularProgressIndicator(),),
                          ),
                          
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        ),
      );
  }
}