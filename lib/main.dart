import 'package:cron/cron.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:video_file_dwonload/video_dwonload.dart';
import 'package:workmanager/workmanager.dart';



void callbackDispatcher() {
// this method will be called every hour
  Workmanager().executeTask((task, inputdata) async {
    switch (task) {
      case "backUp2":
        debugPrint("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
        Fluttertoast.showToast(msg: "this method was called from native!");
        break;

      case Workmanager.iOSBackgroundTask:
        print("iOS background fetch delegate ran");
        break;
    }

    //Return true when the task executed successfully or not
    return Future.value(true);
  });
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Workmanager().initialize(callbackDispatcher); //Android only (see below)



  final cron = Cron();


  // cron.schedule(Schedule.parse('42 16 * * *'), () async {
  //   print('specifice time call a funtion');
  // });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const VideoDwonloadPage(),
    );
  }
}


