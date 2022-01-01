import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:nodejs_mongodb/models/product_model.dart';
import 'package:nodejs_mongodb/scrrens/home/home_service/home_service.dart';

import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeService homeService = HomeService();
  HomeBloc() : super(InitialHomeState()) {
    on(homeEventControl);
  }
  Future<void> homeEventControl(
      HomeEvent event, Emitter<HomeState> emit) async {
    if (event is InitialHomeEvent) {
      emit(LoadingHomeState());
      List<ProductModel> listProduct = [];
      try {
        final response = await homeService.getProductFromDb();
        if (response.statusCode == 200) {
          listProduct = (jsonDecode(response.body) as List<dynamic>)
              .map((e) => ProductModel.fromMap(e))
              .toList();

          emit(SuccsesHomeState(productsModel: listProduct));
        }
      } catch (e) {
        emit(FailedHomeState(error: e.toString()));
      }
    } else if (event is PushToLoginScreenHomeEvent) {
      emit(PushToLoginScreenHomeState());
    }
  }
}
