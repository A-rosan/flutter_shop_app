

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_copy/modules/search_screen/cubit/states.dart';

import '../../../model/search_model.dart';
import '../../../shared/network/end_points.dart';
import '../../../shared/network/local/cash_helper.dart';
import '../../../shared/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates>{
  SearchCubit():super(SearchInitialState());
  static SearchCubit get(context)=>BlocProvider.of(context);
  String? token = CashHelper.getData(key: 'token');
  SearchModel ?searchModel;
  void search({
    String ?text,
  }){
    emit(SearchLoadingState());
    DioHelper.postData(
      url: SEARCH,
      token: token,
      data: {
        'text':text,
      }
      )
      .then(
        (value) {
          searchModel=SearchModel.fromMap(value.data);
          print("search result: ${value.data}");
          emit(SearchSuccessState());
        }
        )
        .catchError(
          (error){
            print("Search error: $error");
            emit(SearchErrorState());
          }
        );
  }
}