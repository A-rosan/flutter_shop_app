

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app_copy/shared/components/components.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../model/get_favorit_model.dart';
import '../../shared/styles/colors.dart';

class FavoritScreen extends StatelessWidget {
  const FavoritScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ShopCubit cubit = ShopCubit.get(context);

    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ChangeFvoritSuccessState) {
          if (state.favoritModel?.status==false) {
            showToast(msg: state.favoritModel?.message.toString()??"something went Wrong", toastState:ChoseState.ERROR);
          }else{
            showToast(msg: state.favoritModel?.message.toString()??"something went Wrong", toastState:ChoseState.SUCCESS);
          }
        }
      },
      builder: (context, state) => ConditionalBuilder(
        condition: state is! GetFvoritLoadingState,
        builder: (context) => ListView.separated(
          itemBuilder: (context, index) =>
              favoritItems(cubit.getFavModel!.data!.data![index], context),
          separatorBuilder: (context, index) => myDivider(),
          itemCount: cubit.getFavModel!.data?.data?.length ??1, //if the data null length is 1
        ),
        fallback: (context) => const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Widget favoritItems(Datum getFavModel, context) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
          height: 120,
          child: Row(
            children: [
              //products images
              Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  Image(
                    image: NetworkImage("${getFavModel.product!.image}"),
                    width: 120,
                    height: 120,
                  ),
                  if (getFavModel.product?.discount != 0)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.red,
                      ),
                      child: Text(
                        'Discount',
                        style: GoogleFonts.abel(
                          color: Colors.white,
                          fontSize: 13,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      getFavModel.product?.name ?? "Name error",
                      style: GoogleFonts.abel(
                        color: defualtColor2,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        height: 1.1,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Text(
                          "${getFavModel.product!.price!.round()}\$",
                          style: GoogleFonts.abel(
                              fontSize: 15,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        if (getFavModel.product?.discount != 0)
                          Text(
                            "${getFavModel.product!.oldPrice!.round()}\$",
                            style: GoogleFonts.abel(
                              fontSize: 12,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        const Spacer(),
                        IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            ShopCubit.get(context)
                                .changeFavorit(getFavModel.product?.id);
                          },
                          icon: Icon(
                            (ShopCubit.get(context)
                                        .favorits[getFavModel.product?.id] ??
                                    false)
                                ? Icons.favorite
                                : Icons.favorite_border_outlined,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
}
