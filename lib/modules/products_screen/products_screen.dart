

//SHOP HOME SCREEN
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app_copy/shared/styles/colors.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../model/category_model.dart';
import '../../model/home_model.dart';
import '../../shared/components/components.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
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
      builder: (context, state) {
        return ConditionalBuilder(
          condition: cubit.homeModel != null && cubit.categoryModel != null,
          builder: (context) =>
              productsBuilder(cubit.homeModel!, cubit.categoryModel!, context),
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget productsBuilder(
          HomeModel model, CategoryModel categoryModel, context) =>
      SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Ad images
            CarouselSlider(
              items: model.data?.banners
                  ?.map((e) => Image(
                        image: NetworkImage("${e.image}"),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ))
                  .toList(),
              options: CarouselOptions(
                height: 220,
                initialPage: 0,
                //keep scroll the images
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                //every 3s move the image
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
                viewportFraction: 1.0,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            //column between Ad images and products
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Category",
                    style: GoogleFonts.abel(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: defualtColor2),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 100,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) =>
                          stakBuilder(categoryModel.data!.data![index]),
                      separatorBuilder: (context, index) => const SizedBox(
                        width: 3,
                      ),
                      itemCount: categoryModel.data!.data!.length,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "New product",
                    style: GoogleFonts.abel(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: defualtColor2,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              color: Colors.grey[300],
              child: GridView.count(
                mainAxisSpacing: 1,
                crossAxisSpacing: 1,
                childAspectRatio: 1 / 1.53,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                children: [
                  ...List.generate(
                    model.data!.products!.length,
                    (index) => productsGridBuild(
                        model.data!.products![index], context),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget productsGridBuild(Product productModel, context) => Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //products images
            Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Image(
                  image: NetworkImage(productModel.image ?? "loading image"),
                  width: double.infinity,
                  height: 200,
                ),
                if (productModel.discount != 0)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      color: Colors.red,
                    ),
                    child: Text(
                      'discount',
                      style: GoogleFonts.abel(
                        color: Colors.white,
                        fontSize: 13,
                      ),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productModel.name ?? "name error",
                    style: GoogleFonts.abel(
                      color: defualtColor2,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      height: 1.1,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: [
                      Text(
                        "${productModel.price!.round()}\$",
                        style: GoogleFonts.abel(
                            fontSize: 15,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      if (productModel.discount != 0)
                        Text(
                          "${productModel.oldPrice!.round()}\$",
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
                          ShopCubit.get(context).changeFavorit(productModel.id);
                        },
                        icon: Icon(
                          (ShopCubit.get(context).favorits[productModel.id] ?? false )
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
      );
  Widget stakBuilder(Datum categoryModel) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Image(
              image:
                  NetworkImage(categoryModel.image ?? "category image error"),
              fit: BoxFit.cover,
              width: 100,
              height: 100,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: defualtColor2,
              ),
              width: 100,
              child: Text(
                categoryModel.name ?? "category name error",
                textAlign: TextAlign.center,
                style: GoogleFonts.abel(color: Colors.white),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      );
}
