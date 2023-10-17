

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../shared/components/components.dart';
import '../../shared/network/local/cash_helper.dart';
import '../../shared/styles/colors.dart';
import '../login_screen/login_screen.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  var settingFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ShopCubit cubit = ShopCubit.get(context);
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is UpdateUserSuccessDataState) {
          showToast(
                msg: state.updateUser?.message.toString() ??
                    "something went wrong",
                toastState: ChoseState.SUCCESS,
              );
        }
        if (state is UpdateUserErrrorDataState) {
            showToast(
              msg: state.error ?? "somthing went Wrong",
              toastState: ChoseState.ERROR,
            );
          }
      },
      builder: (context, state) {
        var model = ShopCubit.get(context).userData;
        nameController.text = model?.data?.name ?? "Loading Name error";
        emailController.text = model?.data?.email ?? "Loading Email error";
        phoneController.text = model?.data?.phone ?? "Loading Phone error";

        return ConditionalBuilder(
          condition: cubit.userData != null,
          builder: (context) => GestureDetector(
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
                      key: settingFormKey,
                      child: Column(
                        children: [
                          const Image(
                            image: AssetImage('assets/images/loginPic.png'),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          if (state is UpdateUserLoadingDataState)
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const LinearProgressIndicator()
                              ),

                            const SizedBox(
                            height: 10,
                          ),
                          //name
                          defualtTxtForm(
                            controller: nameController,
                            type: TextInputType.name,
                            label: "Name",
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
                          defualtTxtForm(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            label: "Email",
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
                          defualtTxtForm(
                            controller: phoneController,
                            type: TextInputType.phone,
                            label: "Phone",
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
                          //edit profile
                          defualtButton(
                            text: "SignOut",
                            onPressed: () {
                              CashHelper.removeData(key: 'token').then((value) {
                                moveToAndFinish(context, LoginScreen());
                              });
                            },
                            color: defualtColor2,
                            raduis: 10,
                            isUpperCase: false,
                            fontSize: 18,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          //edit profile
                          defualtButton(
                            text: "Edit profile",
                            onPressed: () {
                              if (settingFormKey.currentState!.validate()) {
                                cubit.updateUserData(
                                    name: nameController.text,
                                    email: emailController.text,
                                    phone: phoneController.text);
                              }
                            },
                            color: defualtColor2,
                            raduis: 10,
                            isUpperCase: false,
                            fontSize: 18,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
