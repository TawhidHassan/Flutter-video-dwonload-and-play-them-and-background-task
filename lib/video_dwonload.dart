import 'package:cron/cron.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:video_file_dwonload/secudle_task_page.dart';
import 'package:video_file_dwonload/video_load_page.dart';
import 'package:workmanager/workmanager.dart';

import 'downloading_dialog.dart';


class VideoDwonloadPage extends StatefulWidget {
  const VideoDwonloadPage({Key? key}) : super(key: key);

  @override
  _VideoDwonloadPageState createState() => _VideoDwonloadPageState();
}

class _VideoDwonloadPageState extends State<VideoDwonloadPage> {
  bool isCliclk=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // One off task registration

    Workmanager().registerPeriodicTask(
      "taskTwo",
      "backUp",
      frequency: Duration(minutes: 16),
    );
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Center(child: InkWell(
            onTap: (){
              Navigator.push(context,MaterialPageRoute(builder: (context) => const VideoShowPage()));
            },
            child: Text("Video page"))),
        actions: [
          InkWell(
              onTap: (){
                Navigator.push(context,MaterialPageRoute(builder: (context) => const Secudletask()));
              },
              child: Icon(Icons.timer)),
        ],
      ),
      body:Container(
        child: Center(
          child:InkWell(
              onTap: (){
                // Workmanager().registerPeriodicTask(
                //   "taskOne",
                //   "backUp2",
                //   initialDelay: Duration(seconds: 5),
                // );
                final cron = Cron();
                if(!isCliclk){

                  cron.schedule(Schedule.parse('13 17 25 6 *'), () async {
                    debugPrint('every XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX');
                    showDialog(
                      context: context,
                      builder: (context) => const DownloadingDialog(),
                    );
                    Fluttertoast.showToast(msg: "every XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX");
                  });

                  setState(() {
                    isCliclk=true;
                  });
                }


              },
              child: Text("Create secudle")),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => const DownloadingDialog(),
          );
        },
        tooltip: 'Download File',
        child: const Icon(Icons.download),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
