import 'package:Doctors/screens/main/MainScreen.dart';
import 'package:flutter/material.dart';


class LauncherScreen extends StatefulWidget{
  const LauncherScreen({super.key});
  @override
  State<StatefulWidget> createState() {
   return _LauncherScreen();
  }
}

class _LauncherScreen extends State<LauncherScreen>{
  
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 5)).then((dynamic){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>const MainScreen()));
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/icon/img.png', width: 100,height: 100,),
      ),
    );
  }
}