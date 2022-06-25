import 'dart:io';


import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class DownloadingDialog extends StatefulWidget {
  const DownloadingDialog({Key? key}) : super(key: key);

  @override
  _DownloadingDialogState createState() => _DownloadingDialogState();
}

class _DownloadingDialogState extends State<DownloadingDialog> {
  Dio dio = Dio();
  double progress = 0.0;

  void startDownloading() async {
    const String url =
        'https://staging-merchx.sgp1.digitaloceanspaces.com/1653896481145-rabbits.mp4';

    const String fileName = "TextVideppp.mp4";

    String path = await _getFilePath(fileName);

    await dio.download(
      url,
      path,
      onReceiveProgress: (recivedBytes, totalBytes) {
        setState(() {
          progress = recivedBytes / totalBytes;
        });

        print(progress);
      },
      deleteOnError: true,
    ).then((_) {
      print(_.data);
      Navigator.pop(context);
    });
  }

  Future<String> _getFilePath(String filename) async {
    final directory = await getApplicationDocumentsDirectory();
    createAppFolder();
    print("${directory.path}/sifatVideos/$filename");
    return "${directory.path}/sifatVideos/$filename";
  }

  void createAppFolder() async {
    final directory = await getExternalStorageDirectory();
    final dirPath = '${directory?.path}/sifatVideos' ;
    await new Directory(dirPath).create();
  }


  @override
  void initState() {
    super.initState();
    startDownloading();
  }

  @override
  Widget build(BuildContext context) {
    String downloadingprogress = (progress * 100).toInt().toString();

    return AlertDialog(
      backgroundColor: Colors.black,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator.adaptive(),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: (){

            },
            child: Text(
              "Downloading: $downloadingprogress%",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 17,
              ),
            ),
          ),


        ],
      ),
    );
  }
}