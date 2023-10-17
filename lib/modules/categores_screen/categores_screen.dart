

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../model/category_model.dart';
import '../../shared/components/components.dart';
import '../../shared/styles/colors.dart';

class CategoresScreen extends StatelessWidget {
  const CategoresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ShopCubit cubit = ShopCubit.get(context);
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) => ListView.separated(
          itemBuilder: (context, index) =>
              categoryBuild(cubit.categoryModel!.data!.data![index]),
          separatorBuilder: (context, index) => myDivider(),
          itemCount: cubit.categoryModel!.data?.data?.length ?? 1 //if the data null length is 1
          ),
    );
  }

  Widget categoryBuild(Datum categoryModel) => Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          decoration: BoxDecoration(
            color: defualtColor2,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              Image(
                image: NetworkImage(categoryModel.image ??
                    "category image error"), //if there is no image => "category image error"
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Text(
                  categoryModel.name ??
                      "category name error", //if there is no name => "category name error"
                  style: GoogleFonts.abel(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.keyboard_arrow_right_rounded,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      );
}
