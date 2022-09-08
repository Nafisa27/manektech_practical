import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manektech_prac/app_utils/app_color.dart';
import 'package:manektech_prac/app_utils/app_string.dart';
import 'package:manektech_prac/app_utils/dimens.dart';
import 'package:manektech_prac/common_widget/product_list_view.dart';
import 'package:manektech_prac/model/product_response_model.dart';
import 'package:manektech_prac/ui/dashboard/bloc/dashboard_bloc.dart';
import 'package:manektech_prac/ui/dashboard/bloc/dashboard_event.dart';
import 'package:manektech_prac/ui/dashboard/bloc/dashboard_state.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final List<ProductData>? productData = [];
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          dashboardTitle,
          style: TextStyle(color: colorWhite, fontSize: Dimens.textSize_16),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.shopping_cart,
              color: colorWhite,
            ),
            onPressed: () {
              Navigator.pushNamed(context, "/CartProductScreen");
            },
          )
        ],
        backgroundColor: primaryColor,
      ),
      body: BlocConsumer<DashboardBloc, DashboardState>(
        listener: (blocContext, state) {
          if (state is DashboardLoadingState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text("Load More")));
          } else if (state is DashboardSuccessState &&
              state.productList!.isEmpty) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text(noMoreData)));
          } else if (state is DashboardErrorState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.errorMessage)));
            blocContext.read()<DashboardBloc>().isFetching = false;
          }
          return;
        },
        builder: (context, state) {
          if (state is DashboardInitialState ||
              state is DashboardLoadingState && productData!.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is DashboardLoadingState) {
          } else if (state is DashboardSuccessState) {
            productData!.addAll(state.productList!);

            context.read<DashboardBloc>().isFetching = false;
          } else if (state is DashboardErrorState && productData!.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    context.read()<DashboardBloc>()
                      ..isFetching = true
                      ..add(FetchProductEvent());
                  },
                  icon: const Icon(Icons.refresh),
                ),
                const SizedBox(height: 15),
                Text(state.errorMessage, textAlign: TextAlign.center),
              ],
            );
          }
          return GridView.builder(
            controller: _scrollController
              ..addListener(() {
                if (_scrollController.offset ==
                        _scrollController.position.maxScrollExtent &&
                    !context.read<DashboardBloc>().isFetching) {
                  context.read<DashboardBloc>()
                    ..isFetching = true
                    ..add(FetchProductEvent());
                }
              }),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return ProductGridView(productData![index]);
            },
            scrollDirection: Axis.vertical,
            itemCount: productData!.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 1.0,
              mainAxisSpacing: 1.0,
            ),
          );
          //return ProductGridView(productData!);
        },
      ),
    );
  }
}
