import 'package:flutter/material.dart';

import 'modules/hello_screen/hello_screen.dart';

void main()
{
  runApp(myapp());
  //Bloc.observer = MyBlocObserver();
}

class myapp extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home : helloScreen(),
    );
  }


}