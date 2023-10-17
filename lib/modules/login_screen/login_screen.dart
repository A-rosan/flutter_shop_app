

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app_copy/modules/login_screen/cubit/cubit_login.dart';
import 'package:shop_app_copy/modules/login_screen/cubit/states_login.dart';

import '../../layout/home_layout.dart';
import '../../shared/components/components.dart';
import '../../shared/network/local/cash_helper.dart';
import '../../shared/styles/colors.dart';
import '../register_screen/register_screen.dart';

class LoginScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  String? token = CashHelper.getData(key: 'token');
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            print(state.loginModel?.message);
            print(state.loginModel?.data!.token);
            CashHelper.saveData(
              key: 'token',
              value: state.loginModel?.data?.token,
            ).then((value) {
              token=state.loginModel?.data?.token;
              showToast(
                msg: state.loginModel?.message.toString() ??
                    "something went wrong",
                toastState: ChoseState.SUCCESS,
              );
              moveToAndFinish(context, HomeLayout());
            });
          }
          if (state is LoginErrorState) {
            showToast(
              msg: state.error ?? "somthing went Wrong",
              toastState: ChoseState.ERROR,
            );
          }
        },
        builder: (context, state) {
          return GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
            child: Scaffold(
              body: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Image(
                              image: AssetImage("assets/images/loginPic.png")),
                          const SizedBox(
                            height: 40,
                          ),
                          Text(
                            "Login",
                            style: GoogleFonts.abel(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: defualtColor2,
                            ),
                          ),
                          Text(
                            "login now to browes hot offers",
                            style: GoogleFonts.abel(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          //email
                          defualtTxtForm(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            label: "Email",
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter your email";
                              }
                              return null;
                            },
                            prefixIcon: Icons.email_rounded,
                            radius: 10,
                            iconColor: defualtColor2,
                            onSubmitted: (value) {},
                            fontWeight: FontWeight.bold,
                          ),
                          const SizedBox(
                            height: 15,
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
                            suffixIcon: LoginCubit.get(context).suffix,
                            isPassword: LoginCubit.get(context).isPassword,
                            suffixFunction: () {
                              LoginCubit.get(context)
                                  .changePasswordVisibility();
                            },
                            radius: 10,
                            iconColor: defualtColor2,
                            onSubmitted: (value) {},
                            fontWeight: FontWeight.bold,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          //login button
                          Center(
                            child: ConditionalBuilder(
                              condition: state is! LoginLoadingState,
                              builder: (context) => defualtButton(
                                text: "Login",
                                onPressed: () {
                                  if (formKey.currentState != null &&
                                      formKey.currentState!.validate()) {
                                    LoginCubit.get(context).userLogin(
                                      email: emailController.text.trim(),
                                      password: passwordController.text.trim(),
                                    );
                                  } else {
                                    print("login error");
                                  }
                                },
                                color: defualtColor2,
                                raduis: 10,
                                isUpperCase: false,
                              ),
                              fallback: (context) =>
                                  const CircularProgressIndicator(),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don\'t have account ?",
                                style: GoogleFonts.abel(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              ),
                              TextButton(
                                  onPressed: () {
                                    moveTo(context, RegisterScreen());
                                  },
                                  child: Text(
                                    "Rigister",
                                    style: GoogleFonts.abel(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  )),
                            ],
                          )
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
