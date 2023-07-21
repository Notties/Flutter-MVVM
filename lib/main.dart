import 'package:flutter/material.dart';
import 'package:flutter_mvvm/users_list/views/home_screen.dart';
import 'package:flutter_mvvm/users_list/view_models/users_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => UsersViewModel(),
          )
        ],
        child: MaterialApp(
          title: 'MVVM',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              primaryColor: Colors.blue,
              brightness: Brightness.light,
              visualDensity: VisualDensity.adaptivePlatformDensity),
          home: HomeScreen(),
        ));
  }
}
