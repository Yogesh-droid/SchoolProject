import 'dart:convert';
import 'package:app/screens/newsFeedScreens/news_feed.dart';
import 'package:app/viewNewsFeed/bloc/view_news_feed_bloc.dart';
import 'package:app/viewNewsFeed/model/viewNewsFeedResponse.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:app/utils/CardItem.dart';
import 'package:app/utils/FunctinsData.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:app/utils/Utils.dart';
import 'package:app/utils/apis/Apis.dart';
import 'package:app/utils/widget/ScaleRoute.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';
import 'package:app/screens/ActiveOnlineExamScreen.dart';
import 'package:app/screens/BookIssuedScreen.dart';
import 'package:app/screens/BookListScreen.dart';
import 'package:app/screens/ClassExamResult.dart';
import 'package:app/screens/Dormitory.dart';
import 'package:app/screens/ExaminationScreen.dart';
import 'package:app/screens/Fees.dart';
import 'package:app/screens/LibraryScreen.dart';
import 'package:app/screens/NoticeScreen.dart';
import 'package:app/screens/OnlineExamResultScreen.dart';
import 'package:app/screens/OnlineExamScreen.dart';
import 'package:app/screens/Profile.dart';
import 'package:app/screens/Routine.dart';
import 'package:app/screens/ScheduleScreen.dart';
import 'package:app/screens/SettingsScreen.dart';
import 'package:app/screens/StudentAttendance.dart';
import 'package:app/screens/StudentHomework.dart';
import 'package:app/screens/StudentTeacher.dart';
import 'package:app/screens/SubjectScreen.dart';
import 'package:app/screens/TimeLineScreen.dart';
import 'package:app/screens/TransportScreen.dart';
import 'package:app/screens/admin/AddFeeType.dart';
import 'package:app/screens/admin/AddLibraryBook.dart';
import 'package:app/screens/admin/AddRouteScreen.dart';
import 'package:app/screens/admin/AdminAddDormitory.dart';
import 'package:app/screens/admin/AdminAddMember.dart';
import 'package:app/screens/admin/AdminAddRoom.dart';
import 'package:app/screens/admin/AdminAddVehicle.dart';
import 'package:app/screens/admin/AdminAttendanceScreen.dart';
import 'package:app/screens/admin/AdminDormitoryScreen.dart';
import 'package:app/screens/admin/AdminFeeList.dart';
import 'package:app/screens/admin/AdminFeesHome.dart';
import 'package:app/screens/admin/AdminLeaveHomeScreen.dart';
import 'package:app/screens/admin/AdminLibraryScreen.dart';
import 'package:app/screens/admin/AdminSettings.dart';
import 'package:app/screens/admin/AdminStuffList.dart';
import 'package:app/screens/admin/AdminTransportScreen.dart';
import 'package:app/screens/parent/ChildListScreen.dart';
import 'package:app/screens/teacher/AboutScreen.dart';
import 'package:app/screens/teacher/AcademicsScreen.dart';
import 'package:app/screens/teacher/AddContentScreen.dart';
import 'package:app/screens/teacher/AddHomeworkScreen.dart';
import 'package:app/screens/teacher/ApplyLeaveScreen.dart';
import 'package:app/screens/teacher/AttendanceScreen.dart';
import 'package:app/screens/teacher/ClassAttendanceHome.dart';
import 'package:app/screens/teacher/ContentListScreen.dart';
import 'package:app/screens/teacher/ContentScreen.dart';
import 'package:app/screens/teacher/HomeworkScreen.dart';
import 'package:app/screens/teacher/LeaveListScreen.dart';
import 'package:app/screens/teacher/LeaveScreen.dart';
import 'package:app/screens/teacher/MySubjectScreen.dart';
import 'package:app/screens/teacher/SearchClassRoutine.dart';
import 'package:app/screens/teacher/StudentSearch.dart';
import 'package:app/screens/teacher/TeacherHomeworkListScreen.dart';
import 'package:app/screens/teacher/TeacherMyAttendance.dart';
import 'package:app/screens/teacher/TeacherRoutineScreen.dart';
import 'package:app/screens/zoom/virtual_class.dart';
import 'package:app/screens/zoom/virtual_meeting.dart';
import 'package:app/utils/widget/ScaleRoute.dart';
import 'package:app/utils/server/ProfileService.dart';
import 'package:app/utils/modal/InfixMap.dart';
import 'package:app/utils/widget/ProfileListRow.dart';


//notificatiopn handler
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

// Streams are created so that app can respond to notification-related events since the plugin is initialised in the `main` function
final BehaviorSubject<ReceivedNotification> didReceiveLocalNotificationSubject =
    BehaviorSubject<ReceivedNotification>();

final BehaviorSubject<String> selectNotificationSubject =
    BehaviorSubject<String>();

class ReceivedNotification {
  final int id;
  final String title;
  final String body;
  final String payload;

  ReceivedNotification(
      {@required this.id,
      @required this.title,
      @required this.body,
      @required this.payload});
}

// ignore: must_be_immutable
class Home extends StatefulWidget {
  var _titles;
  var _images;

  Home(this._titles, this._images);

  @override
  _HomeState createState() => _HomeState(_titles, _images);
}

class _HomeState extends State<Home> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  BuildContext context;

  String section = 'personal';

  String id;
  String image;
  String email;
  String password;
  String rule;

  ProfileService profileService;
  static var librarys = [
    'Book List',
    'Books Issued',
  ];
  static var libraryIcons = [
    'assets/images/fees_icon.png',
    'assets/images/fees_icon.png',
  ];
  static var examinations = [
    'Schedule',
    'Result',
  ];
  static var examinationIcons = [
    'assets/images/fees_icon.png',
    'assets/images/fees_icon.png',
  ];

  static var onlineExaminations = [
    'Active Exam',
    'Exam Result',
  ];
  static var onlineExaminationIcons = [
    'assets/images/fees_icon.png',
    'assets/images/fees_icon.png',
  ];
  static var homework = [
    'Add HW',
    'HW List',
  ];
  static var homeworkIcons = [
    'assets/images/addhw.png',
    'assets/images/hwlist.png',
  ];

  bool isTapped;
  int currentSelectedIndex;
  int rtlValue;
  String _name;
  String _email;
  String _password;
  String _rule;
  String _id;
  String schoolId;
  String isAdministrator;
  var _titles;
  var _images;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  _HomeState(this._titles, this._images);

  @override
  void dispose() {
    didReceiveLocalNotificationSubject.close();
    selectNotificationSubject.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      scaffoldKey.currentState.openDrawer();
    });

    //init settings for android
    var initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification:
            (int id, String title, String body, String payload) async {
      didReceiveLocalNotificationSubject.add(ReceivedNotification(
          id: id, title: title, body: body, payload: payload));
    });
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String payload) async {
      if (payload != null) {
        debugPrint('notification payload: ' + payload);
      }
      selectNotificationSubject.add(payload);
    });

    didReceiveLocalNotificationSubject.stream
        .listen((ReceivedNotification receivedNotification) async {
      await showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: receivedNotification.title != null
              ? Text(receivedNotification.title)
              : null,
          content: receivedNotification.body != null
              ? Text(receivedNotification.body)
              : null,
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text('Ok'),
              onPressed: () async {
//                Navigator.of(context, rootNavigator: true).pop();
//                await Navigator.push(
//                  context,
//                  MaterialPageRoute(
//                    builder: (context) =>
//                        SecondScreen(receivedNotification.payload),
//                  ),
//                );
              },
            )
          ],
        ),
      );
    });
    selectNotificationSubject.stream.listen((String payload) async {
//      await Navigator.push(
//        context,
//        MaterialPageRoute(builder: (context) => SecondScreen(payload)),
//      );
    });

    _firebaseMessaging.onTokenRefresh.listen(sendTokenToServer);
    _firebaseMessaging.getToken();

    _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
      print('onMessage: $message');
      final notification = message['notification'];
      setState(() {
        //messages.add(Message(title: notification['title'],body: notification['body']));
        //Utils.showToast(notification['title']);
        _showNotification(notification['title'], notification['body']);
      });
    }, onLaunch: (Map<String, dynamic> message) async {
      print('onLaunch: $message');
    }, onResume: (Map<String, dynamic> message) async {
      print('onResume: $message');
    });
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));

    isTapped = false;
    Utils.getStringValue('name').then((value) {
      _name = value;
    });
    Utils.getStringValue('email').then((value) {
      _email = value;
    });
    Utils.getStringValue('password').then((value) {
      _password = value;
    });
    Utils.getStringValue('schoolId').then((value) {
      schoolId = value;
    });
    Utils.getStringValue('rule').then((value) {
      _rule = value;
    });
    Utils.getStringValue('id').then((value) {
      _id = value;
    });
    Utils.getStringValue('isAdministrator').then((value) {
      isAdministrator = value;
    });
    Utils.getIntValue('locale').then((value) {
      setState(() {
        rtlValue = value;
      });
    });

  }

  @override
  Widget build(BuildContext context) {
     final double statusBarHeight = MediaQuery.of(context).padding.bottom;

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Color(0xFF6c3471), //or set color with: Color(0xFF0000FF)
    ));

     return Padding(
         padding: EdgeInsets.only(top: statusBarHeight),
    child: Scaffold(
    appBar: AppBar(
        elevation: 0.0,
        primary: true,
        centerTitle: true,
        title: Container(
          padding: EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: <Widget>[
              Image.asset(
                'assets/images/aha_logo.png',
                alignment: Alignment.center,

                width: 180.0,
              ),
              //Expanded(child: Container()),
              /*FutureBuilder(
                future: Utils.getStringValue('email'),
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  return getProfileImage(context, _email, _password, _rule);
                },
              ),*/

            ],
          ),
        ),
        actions: [
          IconButton(
            padding: const EdgeInsets.only(top: 0.0),
            icon: Icon(Icons.notifications_none),
            onPressed: () {},
          ),
          IconButton(
            padding: const EdgeInsets.only(top: 0.0),
            icon: Icon(Icons.message),
            onPressed: () {

            },
          ),
        ],
        flexibleSpace: Image(
          image: AssetImage('assets/images/tool_bar_bg.png'),
          fit: BoxFit.cover,
        ),
        backgroundColor: Colors.transparent,
      ),

      drawer: Drawer(

        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
        DrawerHeader(
        decoration: BoxDecoration(
          color: Color(0xff6c3471),
        ),
        child: Stack(
          children: <Widget>[

            getProfileHeaderTitle(),

            getProfileImage(context, _email, _password, _rule),


          ],
        ),
        ),

            ListTile(
              title: Text("News Feed", style: TextStyle(
                  color: Colors.grey[800], fontWeight: FontWeight.normal, fontSize: 16.0
              )),
              leading: Image.asset('assets/images/homework.png', height: 30.0, width: 30.0),
              onTap: (){ Navigator.of(context).pop();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NewsFeed()),
              );
              },
            ),
            ListTile(
              title: Text("Homework", style: TextStyle(
                  color: Colors.grey[800], fontWeight: FontWeight.normal, fontSize: 16.0
              )),
              leading: Image.asset('assets/images/homework.png', height: 30.0, width: 30.0),
              onTap: (){ Navigator.of(context).pop();Navigator.push(
                  context, ScaleRoute(page: HomeworkHomeScreen(homework, homeworkIcons)));},
            ),
            ListTile(
              title: Text("Attendance", style: TextStyle(
                  color: Colors.grey[800], fontWeight: FontWeight.normal, fontSize: 16.0
              )),
              leading: Image.asset('assets/images/attendance.png', height: 30.0, width: 30.0),
              onTap: (){ Navigator.of(context).pop();Navigator.push(
                  context, ScaleRoute(page: StudentAttendanceScreen(id: id)));},
            ),
            ListTile(
              title: Text("Examinations", style: TextStyle(
                  color: Colors.grey[800], fontWeight: FontWeight.normal, fontSize: 16.0
              )),
              leading: Image.asset('assets/images/examination.png', height: 30.0, width: 30.0),
              onTap: (){ Navigator.of(context).pop();Navigator.push(
                  context, ScaleRoute(page: ExaminationHome(examinations, examinationIcons,)));
              },
            ),
            ListTile(
              title: Text("Online Exam", style: TextStyle(
                  color: Colors.grey[800], fontWeight: FontWeight.normal, fontSize: 16.0
              )),
              leading: Image.asset('assets/images/onlineexam.png', height: 30.0, width: 30.0),
              onTap: (){ Navigator.of(context).pop();Navigator.push(
                  context,
                  ScaleRoute( page: OnlineExaminationHome( onlineExaminations, onlineExaminationIcons, id: id,)));
              },
            ),
            ListTile(
              title: Text("Fees", style: TextStyle(
                  color: Colors.grey[800], fontWeight: FontWeight.normal, fontSize: 16.0
              )),
              leading: Image.asset('assets/images/fees_icon.png', height: 30.0, width: 30.0),
              onTap: (){ Navigator.of(context).pop();Navigator.push(context, ScaleRoute(page: FeeScreen(id: id)));},
            ),
            ListTile(
              title: Text("Timeline", style: TextStyle(
                  color: Colors.grey[800], fontWeight: FontWeight.normal, fontSize: 16.0
              )),
              leading: Image.asset('assets/images/timeline.png', height: 30.0, width: 30.0),
              onTap: (){ Navigator.of(context).pop();Navigator.push(
                  context, ScaleRoute(page: TimelineScreen(id: id)));},
            ),
            ListTile(
              title: Text("Routine", style: TextStyle(
                  color: Colors.grey[800], fontWeight: FontWeight.normal, fontSize: 16.0
              )),
              leading: Image.asset('assets/images/routine.png', height: 30.0, width: 30.0),
              onTap: (){ Navigator.of(context).pop();Navigator.push(
                  context, ScaleRoute(page: Routine(id: id)));
              },
            ),
            ListTile(
              title: Text("Subjects", style: TextStyle(
                  color: Colors.grey[800], fontWeight: FontWeight.normal, fontSize: 16.0
              )),
              leading: Image.asset('assets/images/subjects.png', height: 30.0, width: 30.0),
              onTap: (){ Navigator.of(context).pop();Navigator.push(
                  context, ScaleRoute(page: SubjectScreen(id: id,)));
              },
            ),
            ListTile(
              title: Text("Teacher", style: TextStyle(
                  color: Colors.grey[800], fontWeight: FontWeight.normal, fontSize: 16.0
              )),
              leading: Image.asset('assets/images/teacher.png', height: 30.0, width: 30.0),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context, ScaleRoute(page: StudentTeacher(id: id,)));
              },
            ),
            ListTile(
              title: Text("Zoom", style: TextStyle(
                  color: Colors.grey[800], fontWeight: FontWeight.normal, fontSize: 16.0
              )),
              leading: Image.asset('assets/images/library.png', height: 30.0, width: 30.0),
              onTap: (){ Navigator.of(context).pop();Navigator.push(
                  context, ScaleRoute(
                  page: VirtualClassScreen(uid: id,)));},
            ),
            ListTile(
              title: Text("Notice", style: TextStyle(
                  color: Colors.grey[800], fontWeight: FontWeight.normal, fontSize: 16.0
              )),
              leading: Image.asset('assets/images/notice.png', height: 30.0, width: 30.0),
              onTap: (){ Navigator.of(context).pop();Navigator.push(
                  context, ScaleRoute(page: NoticeScreen()));
              },
            ),
            ListTile(
              title: Text("Profile", style: TextStyle(
                  color: Colors.grey[800], fontWeight: FontWeight.normal, fontSize: 16.0
              )),
              leading: Image.asset('assets/images/profile.png', height: 30.0, width: 30.0),
              onTap: (){ Navigator.of(context).pop();Navigator.push(
                  context,
                  ScaleRoute(page: Profile( id: id, image: image)));
              },
            ),

            SizedBox(
              width: 10.0,
            ),

            Container(
                child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: Column(
                      children: <Widget>[
                        Divider(
                          height: 1,
                          thickness: 1,
                        ),

                        ListTile(
                            onTap: (){
                              Navigator.push(context, ScaleRoute(page: SettingScreen()));
                            },
                            leading: Icon(Icons.settings),
                            title: Text("Settings")),
                        Divider(
                          height: 1,
                          thickness: 1,
                        ),
                        ListTile(
                            onTap: () {
                              Navigator.pop(context);showAlertDialog(context);
                            },
                            leading: Icon(Icons.logout),
                            title: Text("Logout")),
                      ],
                    ))),
          ],
        ),
      ),

      body: GridView.builder(
        itemCount: _titles.length,
        gridDelegate:
        SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
        itemBuilder: (context, index) {
          return CustomWidget(
            index: index,
            isSelected: currentSelectedIndex == index,
            onSelect: () {
              setState(() {
                currentSelectedIndex = index;
                if (_rule == '2') {
                  AppFunction.getDashboardPage(context, _titles[index],
                      id: _id);
                } else if (_rule == '4') {
                  AppFunction.getTeacherDashboardPage(
                      context, _titles[index], _id);
                } else if (_rule == '3') {
                  AppFunction.getParentDashboardPage(
                      context, _titles[index], _id);
                } else if (_rule == '1') {
                  if (isAdministrator == 'yes') {
                    AppFunction.getSaasAdminDashboardPage(
                        context, _titles[index]);
                  } else {
                    AppFunction.getAdminDashboardPage(
                        context, _titles[index], _id);
                  }
                }
              });
            },
            headline: _titles[index],
            icon: _images[index],
          );
        },
      ),
    ),
    );
  }

  Widget buildNewsCard(Data data) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: 300,
                  child: data.image!=null ? Image.network(data.imageLink,fit: BoxFit.fill,
                    errorBuilder: (context,e,t){
                      return Image.asset('assets/images/imageNotSupported.png',fit: BoxFit.scaleDown,);
                    },
                  ): Image.asset('assets/images/login_bg.png',fit: BoxFit.fill,)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('created by :'+data.createdBy),
              ),
              Container(
                height: 80,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(10.0)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(data.description,style: TextStyle(

                  ),),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right:8.0,top: 8.0),
                    child: Container(
                      width: 100,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(10.0)
                      ),
                      child: IconButton(icon: Icon(Icons.thumb_up_alt_outlined),color: Colors.white,onPressed: (){

                      },),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left:8.0,top: 8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(10.0)
                        ),
                        child: IconButton(icon: Icon(Icons.share),color: Colors.white,onPressed: (){

                        },),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget yesButton = FlatButton(
      child: Text("YES"),
      onPressed: () {
        Utils.clearAllValue();
//        Utils.saveBooleanValue('isLogged', false);
        Utils.saveIntValue('locale', rtlValue);
        Route route = MaterialPageRoute(builder: (context) => MyApp());
        Navigator.pushAndRemoveUntil(context, route, ModalRoute.withName('/'));
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        "Logout",
        style: Theme.of(context).textTheme.headline,
      ),
      content: Text("Would you like to logout?"),
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

  showStudentProfileDialog(BuildContext context) {
    showDialog<void>(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 80.0),
                child: Container(
                  height: MediaQuery.of(context).size.height / 8,
                  width: MediaQuery.of(context).size.width / 1.2,
                  decoration: BoxDecoration(
                      shape: BoxShape
                          .rectangle, // BoxShape.circle or BoxShape.retangle
                      //color: const Color(0xFF66BB6A),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.deepPurple,
                          blurRadius: 5.0,
                        ),
                      ]),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 0.0, top: 30.0, right: 0.0),
                      child: ListView(
                        children: <Widget>[
                          GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 0.0, bottom: 10.0, right: 0.0),
                        child: Text(
                              "Profile",
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headline,
                            ),
                      ),
                            onTap: () {
                              Navigator.push(
                                  context, ScaleRoute(page: Profile()));
                            },
                          ),

                        /*GestureDetector(
                          child: Padding(
                              padding: const EdgeInsets.only(
                                left: 0.0, bottom: 10.0, right: 0.0),
                              child: Text(
                            "Change Password",
                                style: Theme.of(context).textTheme.headline,
                              ),
                          ),
                          onTap: () {
                            Navigator.push(
                                context, ScaleRoute(page: Profile()));
                          },
                        ),*/
                          GestureDetector(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 0.0, bottom: 10.0, right: 0.0),
                            child: Text(
                              "Logout",
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headline,
                            ),
                            ),
                            onTap: () {
                              showAlertDialog(context);
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  showOhtersProfileDialog(BuildContext context) {
    showDialog<void>(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 80.0),
                child: Container(
                  height: MediaQuery.of(context).size.height / 6,
                  width: MediaQuery.of(context).size.width / 1.2,
                  decoration: BoxDecoration(
                      shape: BoxShape
                          .rectangle, // BoxShape.circle or BoxShape.retangle
                      //color: const Color(0xFF66BB6A),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.deepPurple.shade300,
                          blurRadius: 20.0,
                        ),
                      ]),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, top: 20.0, right: 15.0),
                      child: ListView(
                        children: <Widget>[
                          Text(
                            "Change Password",
                            textAlign: TextAlign.end,
                            style: Theme.of(context).textTheme.headline,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          GestureDetector(
                            child: Text(
                              "Logout",
                              textAlign: TextAlign.end,
                              style: Theme.of(context).textTheme.headline,
                            ),
                            onTap: () {
                              showAlertDialog(context);
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Future<String> getImageUrl(String email, String password, String rule) async {
    var image = 'http://saskolhmg.com/images/studentprofile.png';

    var response = await http.get(InfixApi.login(email, password));

    if (response.statusCode == 200) {
      Map<String, dynamic> user = jsonDecode(response.body) as Map;
      if (rule == '2')
        image = InfixApi.root + user['data']['userDetails']['student_photo'];
      else if (rule == '3')
        image = InfixApi.root + user['data']['userDetails']['fathers_photo'];
      else
        image = InfixApi.root + user['data']['userDetails']['staff_photo'];
    }
    return image == InfixApi.root
        ? 'http://saskolhmg.com/images/studentprofile.png'
        : '$image';
  }

  void navigateToPreviousPage(BuildContext context) {
    Navigator.pop(context);
  }

  void sendTokenToServer(String token) async {
    final response = await http.get(InfixApi.setToken(_id, token));

    if (response.statusCode == 200) {
      //SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      //sharedPreferences.setString('bearer_token', token);
      print('token updated : $token');
    } else {
      throw Exception('Failed to load');
    }
  }

  Widget getProfileHeaderRoll() {
    return FutureBuilder(
        future: Utils.getStringValue('password'),
        builder: (context, snapshot) {
          _password = snapshot.data;
          profileService = id == null ? ProfileService(email: _email,password: _password,schoolId:schoolId) : ProfileService(id: id);

          return FutureBuilder(
            future: profileService.fetchPersonalServices('profile'),
            builder: (context, snapshot1) {
              if (snapshot1.data != null) {
                return Align(
                  alignment: Alignment.centerRight + Alignment(0, .7),
                  child: Text('Roll No: ' +
                      snapshot1.data[3].value,
                    style: Theme.of(context).textTheme.headline.copyWith(color: Color(0xFFFFFFFF), fontSize: 14.0),
                  ),
                );
              } else {
                return Align(
                    alignment: Alignment.centerRight + Alignment(0, .7),
              child: Text(
                  'Loading...',
                  style: Theme.of(context).textTheme.headline.copyWith(color: Color(0xFFFFFFFF), fontSize: 14.0),
              ),
                );
              }
            },
          );
        });
  }

  Widget getProfileHeaderSection() {
    return FutureBuilder(
        future: Utils.getStringValue('password'),
        builder: (context, snapshot) {
          _password = snapshot.data;
          profileService = id == null ? ProfileService(email: _email,password: _password,schoolId:schoolId) : ProfileService(id: id);

          return FutureBuilder(
            future: profileService.fetchPersonalServices('profile'),
            builder: (context, snapshot1) {
              if (snapshot1.data != null) {
                return Align(
                  alignment: Alignment.centerRight + Alignment(0, .20),
                  child: Text('Section : ' +
                      snapshot1.data[1].value,
                    style: Theme.of(context).textTheme.headline.copyWith(color: Color(0xFFFFFFFF), fontSize: 12.0),
                  ),
                );
              } else {
                return Align(
                    alignment: Alignment.centerRight + Alignment(0, .20),
              child: Text(
                  'Loading...',
                  style: Theme.of(context).textTheme.headline.copyWith(color: Color(0xFFFFFFFF), fontSize: 12.0),
              ),
                );
              }
            },
          );
        });
  }

  Widget getProfileHeaderStd() {
    return FutureBuilder(
        future: Utils.getStringValue('password'),
        builder: (context, snapshot) {
          _password = snapshot.data;
          profileService = id == null ? ProfileService(email: _email,password: _password,schoolId:schoolId) : ProfileService(id: id);

          return FutureBuilder(
            future: profileService.fetchPersonalServices('profile'),
            builder: (context, snapshot1) {
              if (snapshot1.data != null) {
                return Align(
                  alignment: Alignment.topRight + Alignment(0, .65),
                  child: Text('Class : ' +
                      snapshot1.data[2].value,
                        style: Theme.of(context).textTheme.headline.copyWith(color: Color(0xFFFFFFFF), fontSize: 16.0),
                    ),
                );
              } else {
                return Align(
                    alignment: Alignment.topRight + Alignment(0, .65),
              child: Text(
                  'Loading...',
                  style: Theme.of(context).textTheme.headline.copyWith(color: Color(0xFFFFFFFF), fontSize: 16.0),
              ),
                );
              }
            },
          );
        });
  }

  Widget getProfileHeaderTitle() {
    return FutureBuilder(
        future: Utils.getStringValue('password'),
        builder: (context, snapshot) {
          _password = snapshot.data;
          profileService = id == null ? ProfileService(email: _email,password: _password,schoolId:schoolId) : ProfileService(id: id);

          return FutureBuilder(
            future: profileService.fetchPersonalServices('profile'),
            builder: (context, snapshot1) {
              if (snapshot1.data != null) {
                return Align(
                  alignment: Alignment.bottomCenter,
                  child: Text('Hi, ' +
                      snapshot1.data[0].value,
                    style: Theme.of(context).textTheme.headline.copyWith(color: Color(0xFFFFFFFF), fontSize: 20.0),
                  ),
                );
              } else {
                return Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    'Loading...',
                    style: Theme.of(context).textTheme.headline.copyWith(color: Color(0xFFFFFFFF), fontSize: 20.0),
                  ),
                );
              }
            },
          );
        });
  }

  Widget getProfileImage(
      BuildContext context, String email, String password, String rule) {
    return FutureBuilder(
      future: getImageUrl(email, password, rule),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasData) {
          Utils.saveStringValue('image', snapshot.data);
          return GestureDetector(
            /*onTap: () {
              rule == '2'
                  ? showStudentProfileDialog(context)
                  : showOhtersProfileDialog(context);
            },*/
            child: Container(
              alignment: Alignment.topCenter,

              child: Padding(
                padding: const EdgeInsets.only(top: 0.0),
                child: CircleAvatar(
                  radius: 50.0,
                  backgroundImage: NetworkImage(snapshot.data),
                  backgroundColor: Colors.transparent,
                ),
              ),
            ),
          );
        } else {
          return GestureDetector(
            /*onTap: () {
              rule == '2'
                  ? showStudentProfileDialog(context)
                  : showOhtersProfileDialog(context);
            },*/
            child: Align(
              alignment: Alignment.topCenter,
              child: CircleAvatar(
                radius: 50.0,
                backgroundImage: NetworkImage(
                    'http://saskolhmg.com/images/studentprofile.png'),
                backgroundColor: Colors.transparent,
              ),
            ),
          );
        }
      },
    );
  }

  Widget getProfileHeader() {
    return FutureBuilder(
        future: Utils.getStringValue('password'),
        builder: (context, snapshot) {
          _password = snapshot.data;
          profileService = id == null ? ProfileService(email: _email,password: _password,schoolId:schoolId) : ProfileService(id: id);

          return FutureBuilder(
            future: profileService.fetchPersonalServices('profile'),
            builder: (context, snapshot1) {
              if (snapshot1.data != null) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(snapshot1.data[0].value,
                        style: Theme.of(context).textTheme.headline),
                    Text(
                      'Class : ' +
                          snapshot1.data[2].value +
                          ' | Section : ' +
                          snapshot1.data[1].value +
                          ' | Roll No: ' +
                          snapshot1.data[3].value,
                      style: Theme.of(context).textTheme.title.copyWith(color: Color(0xFF727FC8)),
                    ),

                  ],
                );
              } else {
                return Text(
                  'Loading...',
                  style: Theme.of(context).textTheme.headline,
                );
              }
            },
          );
        });
  }

  Future<void> onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    await showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: title != null ? Text(title) : null,
        content: body != null ? Text(body) : null,
        actions: [
//          CupertinoDialogAction(
//            isDefaultAction: true,
//            child: Text('Ok'),
//            onPressed: () async {
//              Navigator.of(context, rootNavigator: true).pop();
//              await Navigator.push(
//                context,
//                MaterialPageRoute(
//                  builder: (context) => Home(payload),
//                ),
//              );
//            },
//          )
        ],
      ),
    );
  }

  static Future<void> _showNotification(String title, String body) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'infixEdu', 'infix', 'this channel description',
        importance: Importance.Max, priority: Priority.High, ticker: 'ticker');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, '$title', '$body', platformChannelSpecifics,
        payload: 'infixEdu');
  }
}
