import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:nodejs_mongodb/models/product_model.dart';
import 'package:nodejs_mongodb/scrrens/product/product_view.dart';

import 'package:nodejs_mongodb/utils/dialogs.dart';
import 'package:nodejs_mongodb/utils/router.dart';

import 'home_bloc/home_bloc.dart';
import 'home_bloc/home_event.dart';
import 'home_bloc/home_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<ProductModel> productsModel;
  late HomeBloc homeBloc;
  late bool isLoading;
  late bool isDialogActive;
  @override
  void initState() {
    super.initState();
    homeBloc = HomeBloc();
    homeBloc.add(InitialHomeEvent());
    productsModel = [];
    isLoading = false;
    isDialogActive = false;
  }

  @override
  void dispose() {
    homeBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocListener(
      bloc: homeBloc,
      listener: (context, state) {
        if (state is LoadingHomeState) {
          setState(() {
            isLoading = true;
          });
        } else if (state is FailedHomeState) {
          setState(() {
            isLoading = false;
          });
        } else if (state is SuccsesHomeState) {
          setState(() {
            productsModel = state.productsModel;
            isLoading = false;
          });
        } else if (state is LogoutLoadingHomeState) {
          isDialogActive = true;
          showDialog(
              context: context,
              builder: (context) => Dialogs.loadingDialog(size));
        } else if (state is LogoutSuccsesHomeState) {
          if (isDialogActive) {
            Navigator.pop(context);
            isDialogActive = false;
          }
          showDialog(
              context: context,
              builder: (context) => Dialogs.sucssesDialog(
                  content: const Text('Çıkış Başarılı'),
                  context: context,
                  onPressed: () {
                    Navigator.pop(context);
                    homeBloc.add(PushToLoginScreenHomeEvent());
                  }));
        }
      },
      child: SafeArea(
        child: Scaffold(
          body: isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : productsModel.isNotEmpty
                  ? ListView.builder(
                      itemCount: productsModel.length,
                      itemBuilder: (context, index) {
                        final product = productsModel[index];
                        return _card(product);
                      })
                  : const Center(
                      child: Text('Ürün Ekleyiniz'),
                    ),
          floatingActionButton: FloatingActionButton(
            child: IconButton(
                onPressed: () async {
                  await Routter.push(ProductView(), context);
                  homeBloc.add(InitialHomeEvent());
                },
                icon: const Icon(
                  Icons.add,
                )),
            onPressed: () {},
          ),
          appBar: AppBar(
            title: const Text('Nodejs_Mongodb'),
          ),
        ),
      ),
    );
  }

  Widget _card(ProductModel productModel) {
    return GestureDetector(
      onTap: () async {
        await Routter.push(
            ProductView(
              productModel: productModel,
            ),
            context);
        homeBloc.add(InitialHomeEvent());
      },
      child: SizedBox(
        height: 100,
        child: Card(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('id = ${productModel.productId}'),
              Text('name = ${productModel.productName}'),
            ],
          ),
        ),
      ),
    );
  }
}
