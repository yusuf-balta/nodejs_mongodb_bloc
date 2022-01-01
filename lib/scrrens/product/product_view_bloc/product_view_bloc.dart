import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:nodejs_mongodb/scrrens/product/product_service/product_service.dart';
import 'package:nodejs_mongodb/scrrens/product/product_view_bloc/product_view_event.dart';
import 'package:nodejs_mongodb/scrrens/product/product_view_bloc/product_view_state.dart';

class ProductViewBloc extends Bloc<ProductViewEvent, ProductViewState> {
  ProductService productService = ProductService();
  ProductViewBloc() : super(InitialProductViewState()) {
    on(productViewEventControl);
  }
  Future<void> productViewEventControl(
      ProductViewEvent event, Emitter<ProductViewState> emit) async {
    if (event is AddToDbProductViewEvent) {
      emit(LoadingAddToDbProductViewState());
      try {
        final response =
            await productService.addProductToDb(event.productModel);
        if (response.statusCode == 200) {
          emit(SuccsesAddToDbProductViewState());
        }
      } catch (e) {
        print(e);
      }
    } else if (event is UpdateToDbProductViewEvent) {
      emit(LoadingUpdateToDbProductViewState());
      try {
        final response =
            await productService.updateProductToDb(event.productModel);
        if (response.statusCode == 200) {
          emit(SuccsesUpdateToDbProductViewState());
        }
      } catch (e) {
        print(e);
      }
    } else if (event is DeleteToDbProductViewEvent) {
      emit(LoadingDeleteToDbProductViewState());
      try {
        final response =
            await productService.deleteProductToDb(event.productModel);
        if (response.statusCode == 200) {
          emit(SuccsesDeleteToDbProductViewState());
        }
      } catch (e) {
        print(e);
      }
    } else if (state is PushToHomeScrrenProductViewEvent) {
      emit(PushToHomeScreenProductViewState());
    }
  }
}
