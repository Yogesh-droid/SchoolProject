import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:file_utils/file_utils.dart';
import 'package:app/utils/FunctinsData.dart';
import 'package:app/utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:app/utils/apis/Apis.dart';
import 'package:app/utils/modal/StudentHomework.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permissions_plugin/permissions_plugin.dart';

// ignore: must_be_immutable
class StudentHomeworkRow extends StatelessWidget {
  Homework homework;

  StudentHomeworkRow(this.homework);

  Random random = Random();

  GlobalKey _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _globalKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    homework.subjectName,
                    style: Theme.of(context)
                        .textTheme
                        .title
                        .copyWith(fontSize: 15.0),
                    maxLines: 1,
                  ),
                ),
                Container(
                  width: 80.0,
                  child: GestureDetector(
                    onTap: () {
                      checkPermissions(context);
                      showDownloadAlertDialog(_globalKey.currentContext);
                    },
                    child: Text(
                      'download',
                      textAlign: TextAlign.end,
                      style: Theme.of(context).textTheme.title.copyWith(
                          color: Colors.deepPurpleAccent,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                ),
                Container(
                  width: 80.0,
                  child: GestureDetector(
                    onTap: () {
                      showAlertDialog(context);
                    },
                    child: Text(
                      'view',
                      textAlign: TextAlign.end,
                      style: Theme.of(context).textTheme.title.copyWith(
                          color: Colors.deepPurpleAccent,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Created',
                          maxLines: 1,
                          style: Theme.of(context)
                              .textTheme
                              .display1
                              .copyWith(fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          homework.homeworkDate == null
                              ? 'not assigned'
                              : homework.homeworkDate,
                          maxLines: 1,
                          style: Theme.of(context).textTheme.display1,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Submission',
                          maxLines: 1,
                          style: Theme.of(context)
                              .textTheme
                              .display1
                              .copyWith(fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          homework.submissionDate == null
                              ? 'not assigned'
                              : homework.submissionDate,
                          maxLines: 1,
                          style: Theme.of(context).textTheme.display1,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Evaluation',
                          maxLines: 1,
                          style: Theme.of(context)
                              .textTheme
                              .display1
                              .copyWith(fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          homework.evaluationDate == null
                              ? 'not assigned'
                              : homework.evaluationDate,
                          maxLines: 1,
                          style: Theme.of(context).textTheme.display1,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Status',
                          maxLines: 1,
                          style: Theme.of(context)
                              .textTheme
                              .display1
                              .copyWith(fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        getStatus(context, homework.status),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 0.5,
              margin: EdgeInsets.only(top: 10.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerRight,
                    end: Alignment.centerLeft,
                    colors: [Colors.purple, Colors.deepPurple]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    showDialog<void>(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(0),
              child: Container(
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 20.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              homework.subjectName,
                              style: Theme.of(context).textTheme.headline,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Created',
                                    maxLines: 1,
                                    style: Theme.of(context)
                                        .textTheme
                                        .display1
                                        .copyWith(fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    homework.homeworkDate,
                                    maxLines: 1,
                                    style: Theme.of(context).textTheme.display1,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Submission',
                                    maxLines: 1,
                                    style: Theme.of(context)
                                        .textTheme
                                        .display1
                                        .copyWith(fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    homework.submissionDate,
                                    maxLines: 1,
                                    style: Theme.of(context).textTheme.display1,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Evaluation',
                                    maxLines: 1,
                                    style: Theme.of(context)
                                        .textTheme
                                        .display1
                                        .copyWith(fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    homework.evaluationDate == null
                                        ? 'not assigned'
                                        : homework.evaluationDate,
                                    maxLines: 1,
                                    style: Theme.of(context).textTheme.display1,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Status',
                                    maxLines: 1,
                                    style: Theme.of(context)
                                        .textTheme
                                        .display1
                                        .copyWith(fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  getStatus(context, homework.status),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              homework.description == null
                                  ? ''
                                  : homework.description,
                              maxLines: 10,
                              style: Theme.of(context).textTheme.display1,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }

  Widget getStatus(BuildContext context, String status) {
    if (status == 'I') {
      return Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(color: Colors.redAccent),
        child: Padding(
          padding: const EdgeInsets.only(left: 5.0, right: 5.0),
          child: Text(
            'Incomplete',
            textAlign: TextAlign.center,
            maxLines: 1,
            style: Theme.of(context)
                .textTheme
                .display1
                .copyWith(color: Colors.white, fontWeight: FontWeight.w500),
          ),
        ),
      );
    }
    else if (status == 'C') {
      return Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(color: Colors.greenAccent),
        child: Padding(
          padding: const EdgeInsets.only(left: 5.0, right: 5.0),
          child: Text(
            'Completed',
            textAlign: TextAlign.center,
            maxLines: 1,
            style: Theme.of(context)
                .textTheme
                .display1
                .copyWith(color: Colors.white, fontWeight: FontWeight.w500),
          ),
        ),
      );
    }else{
      return Container();
    }
  }

  showDownloadAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("no"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget yesButton = FlatButton(
      child: Text("download"),
      onPressed: () {
        homework.fileUrl != null ? downloadFile(homework.fileUrl) : Utils.showToast('no file found');
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        "Download",
        style: Theme.of(context).textTheme.headline,
      ),
      content: Text("Would you like to download the file?"),
      actions: [
        cancelButton,
        yesButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<void> downloadFile(String url) async {
    var progress = "";
    Dio dio = Dio();

    String dirloc = "";
    if (Platform.isAndroid) {
      dirloc = "/sdcard/download/";
    } else {
      dirloc = (await getApplicationDocumentsDirectory()).path;
    }
    Utils.showToast(dirloc);

    try {
      FileUtils.mkdir([dirloc]);
      await dio
          .download(InfixApi.root + url, dirloc + AppFunction.getExtention(url),
              onReceiveProgress: (receivedBytes, totalBytes) {
        progress =
            ((receivedBytes / totalBytes) * 100).toStringAsFixed(0) + "%";
      });
    } catch (e) {
      print(e);
    }
    progress = "Download Completed.Go to the download folder to find the file";
  }

  Future<void> checkPermissions(BuildContext context) async {
    Map<Permission, PermissionState> permission =
        await PermissionsPlugin.checkPermissions([
      Permission.WRITE_EXTERNAL_STORAGE,
    ]);

    if (permission[Permission.WRITE_EXTERNAL_STORAGE] !=
        PermissionState.GRANTED) {
      try {
        permission = await PermissionsPlugin.requestPermissions([
          Permission.WRITE_EXTERNAL_STORAGE,
        ]);
      } on Exception {
        debugPrint("Error");
      }

      if (permission[Permission.WRITE_EXTERNAL_STORAGE] ==
          PermissionState.GRANTED)
        print("write  permission ok");
      else
        permissionsDenied(context);
    } else {
      print("write permission ok");
    }
  }

  void permissionsDenied(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext _context) {
          return SimpleDialog(
            title: const Text("Permission denied"),
            children: <Widget>[
              Container(
                padding:
                    EdgeInsets.only(left: 30, right: 30, top: 15, bottom: 15),
                child: const Text(
                  "You must grant all permission to use this application",
                  style: TextStyle(fontSize: 18, color: Colors.black54),
                ),
              )
            ],
          );
        });
  }
}
