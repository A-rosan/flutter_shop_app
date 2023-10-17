

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app_copy/modules/search_screen/cubit/cubit.dart';
import 'package:shop_app_copy/modules/search_screen/cubit/states.dart';

import '../../model/search_model.dart';
import '../../shared/components/components.dart';
import '../../shared/styles/colors.dart';

class SearchScreen extends StatelessWidget {
  TextEditingController searchController = TextEditingController();
  var searchFormKey = GlobalKey<FormState>();
  SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
        SearchCubit cubit = SearchCubit.get(context);
          return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SafeArea(
              child: Form(
                key: searchFormKey,
                child: Column(children: [
                  defualtTxtForm(
                      controller: searchController,
                      type: TextInputType.text,
                      label: "Search here",
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Fill the searchFeild";
                        }
                        return null;
                      },
                      prefixIcon: Icons.search_rounded,
                      iconColor: defualtColor2,
                      fontWeight: FontWeight.bold,
                      labelFontSize: 18,
                      radius: 10,
                      onSubmitted: (String text) {
                        cubit.search(text: text);
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  if(state is SearchLoadingState)
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const LinearProgressIndicator(),
                  ),
                  if(state is SearchSuccessState)
                  Expanded(
                    child: ListView.separated(
                      itemBuilder: (context,index)=>searchItems(cubit.searchModel!.data!.data![index]),
                      separatorBuilder:(context,index)=>myDivider(),
                      itemCount:cubit.searchModel!.data?.data?.length??1 ,
          ),
          ),
                ]),
              ),
            ),
          ),
          );
        },
      ),
    );
  }

  Widget searchItems(DatumSearch getSearchModel) => Padding(
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
                    image: NetworkImage("${getSearchModel.image}"),
                    width: 120,
                    height: 120,
                  ),
                  if (getSearchModel.price != 0)
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
                      getSearchModel.name ?? "Name error",
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
                          "${getSearchModel.price!.round()}\$",
                          style: GoogleFonts.abel(
                              fontSize: 15,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 5,
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
