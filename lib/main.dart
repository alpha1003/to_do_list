import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/src/pages/home_page.dart';
import 'package:to_do_list/src/provider/cats_provider.dart';
import 'package:to_do_list/src/provider/list_provider.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
          ChangeNotifierProvider(create: (_) => new ListaProvider()),
          ChangeNotifierProvider(create: (_) => new CatsProvider())
      ],
      child: MaterialApp( 
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        home: EasySplashScreen(
           logo: Image.asset("images/logo.png"),
           logoSize: 150.0, 
           title: Text("To Do App"),
           loadingText: Text("Cargando..."),
           navigator: HomePage(),
        ), 
        theme: ThemeData.dark().copyWith(
           disabledColor: Colors.red[200],
        ),
      ),
    );
  } 

}