import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manektech_prac/ui/cart/bloc/cart_bloc.dart';
import 'package:manektech_prac/ui/cart/bloc/cart_event.dart';
import 'package:manektech_prac/ui/cart/view/cart_screen.dart';
import 'package:manektech_prac/ui/dashboard/bloc/dashboard_bloc.dart';
import 'package:manektech_prac/ui/dashboard/bloc/dashboard_event.dart';
import 'package:manektech_prac/ui/dashboard/repository/dashboard_repository.dart';
import 'package:manektech_prac/ui/dashboard/view/dashboard_screen.dart';

class Routes {
  static Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case "/Home":
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => DashboardBloc(DashboardRepository())..add(FetchProductEvent()),
                  child: const DashboardScreen(),
                ));
      case "/CartProductScreen":
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => CartBloc()..add(FetchCartEvent()),
                  child: const CartScreen(),
                ));
    }
    return null;
  }
}
