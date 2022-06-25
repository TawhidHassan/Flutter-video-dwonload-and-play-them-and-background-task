import 'dart:io';
import 'dart:io' as io;
import 'dart:math';
import 'package:cron/cron.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';

import 'Widgets/floating_action_button_widget.dart';

class VideoShowPage extends StatefulWidget {
  const VideoShowPage({Key? key}) : super(key: key);

  @override
  _VideoShowPageState createState() => _VideoShowPageState();
}

class _VideoShowPageState extends State<VideoShowPage> {
  final File file = File(
      '/data/user/0/com.example.video_file_dwonload/app_flutter/TextVideoxxx.mp4');
  VideoPlayerController? controller;
  List<dynamic> files= [];
  void getAllFile()async{
    final directory = await getApplicationDocumentsDirectory();
    // print("${directory.path}/sifatVideos/");
    files=io.Directory("${directory.path}/sifatVideos/").listSync();
    setState(() {
      
    });
    debugPrint(files.toString());
  }


  @override
  void initState() {
    super.initState();
    getAllFile();
    final cron = Cron();
    cron.schedule(Schedule.parse('18 17 25 6 *'), () async {
      debugPrint('every XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX');

      controller = VideoPlayerController.file(files[0])
        ..addListener(() => setState(() {}))
        ..setLooping(true)
        ..initialize().then((_) {
          controller?.play();
          setState(() {});
        });

      Fluttertoast.showToast(msg: "every XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX");
    });

  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child:Column(
            children: [
              controller !=null && controller!.value.isInitialized? AspectRatio(
                  aspectRatio: controller!.value.aspectRatio,
                  child: VideoPlayer(controller!)):Container(child: Text("video font found"),),
              Column(
                children: files.map((e) => InkWell(
                    onTap: (){
                      controller = VideoPlayerController.file(e)
                        ..addListener(() => setState(() {}))
                        ..setLooping(true)
                        ..initialize().then((_) {
                          controller?.play();
                          setState(() {});
                        });
                    },
                    child: Container(
                      color: Colors.deepOrangeAccent,
                      padding: EdgeInsets.all(12),
                      margin: EdgeInsets.all(4),
                      child: Text(textSlice(e.toString()),style: TextStyle(color: Colors.white),),
                    ))
              ).toList(),
              )
            ],
          )
        ),
      ),
    );
  }


}

String textSlice(String value){
  const start = "sifatVideos/";
  const end = ".mp4";
  final startIndex = value.indexOf(start);
  final endIndex = value.indexOf(end, startIndex + start.length);

  // print(value.substring(startIndex + start.length, endIndex)); // bro

  return value.substring(startIndex + start.length, endIndex);

}
