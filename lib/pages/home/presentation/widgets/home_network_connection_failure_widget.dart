import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hg_shopping_cart/core/util/constant/constant.dart';
import 'package:hg_shopping_cart/pages/home/presentation/bloc/home_bloc.dart';
import 'package:hg_shopping_cart/pages/home/presentation/bloc/home_event.dart';
import 'package:lottie/lottie.dart';

class HomeNetworkConnectionFailureWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _connectionFailureAnimation(),
        SizedBox(height: 10),
        _retryButton(context)
      ],
    );
  }

  Widget _connectionFailureAnimation() {
    return Lottie.asset(
      Constant.networkErrorAsset,
      width: 200,
      height: 200,
      fit: BoxFit.fill,
    );
  }

  Widget _retryButton(BuildContext context) {
    final didLoadEvent = HomeDidLoadEvent();

    return RaisedButton(
      child: Text("retry"),
      elevation: 5.0,
      textColor: Colors.white,
      color: Colors.green,
      splashColor: Colors.blue[200],
      animationDuration: Duration(seconds: 5),
      onPressed: () {
        didLoadEvent.retryLoad();
        BlocProvider.of<HomeBloc>(context).add(didLoadEvent);
      },
    );
  }
}
