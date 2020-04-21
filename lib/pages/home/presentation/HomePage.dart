import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hg_shopping_cart/core/get_it/injection_container.dart';
import 'package:hg_shopping_cart/pages/home/presentation/bloc/home_bloc.dart';
import 'package:hg_shopping_cart/pages/home/presentation/bloc/home_event.dart';
import 'package:hg_shopping_cart/pages/home/presentation/bloc/home_state.dart';
import 'package:hg_shopping_cart/pages/home/presentation/widgets/home_loaded_widget.dart';
import 'package:hg_shopping_cart/pages/home/presentation/widgets/home_loading_widget.dart';
import 'package:hg_shopping_cart/pages/home/presentation/widgets/home_with_error_widget.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: buildBody(context),
    );
  }

  BlocProvider<HomeBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<HomeBloc>()..add(HomeToListItemsEvent()),
      child: Center(
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                return _mapWidgetByHomeCurrentState(context, state);
              },
            )),
      ),
    );
  }

  _mapWidgetByHomeCurrentState(BuildContext context, HomeState state) {
    if (state is HomeLoadedState) {
      return HomeLoadedWidget();
    } else if (state is HomeErrorState) {
      return HomeWithErrorWidget();
    }
    return HomeLoadingWidget();
  }
}
