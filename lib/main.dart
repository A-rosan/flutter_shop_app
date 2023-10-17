import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app/shop_app.dart';
import 'bloc_observer.dart';
import 'shared/network/local/cash_helper.dart';
import 'shared/network/remote/dio_helper.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CashHelper.init();
  Bloc.observer = MyBlocObserver();
  runApp(ShopApp());
}