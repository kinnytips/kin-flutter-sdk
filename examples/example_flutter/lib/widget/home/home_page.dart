import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kin_sdk_example_flutter/common/bloc/home/home_bloc.dart';
import 'package:kin_sdk_example_flutter/common/bloc/home/home_event.dart';
import 'package:kin_sdk_example_flutter/services/home_page_service.dart';

import 'home_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  final List<Widget> _children = [
    HomeWidget(),
  ];

  _changeIndex(int index) {
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => HomeBloc(
        )..add(
            LoadHomeEvent(),
        ),
      ),
    );
  }
}
