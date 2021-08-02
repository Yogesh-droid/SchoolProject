import 'package:app/newsFeedRepo/bloc/categories/category_list_bloc.dart';
import 'package:app/newsFeedRepo/bloc/drop_down_value/drop_down_cubit.dart';
import 'package:app/newsFeedRepo/bloc/news_feed_switch_bloc/switch_cubit.dart';
import 'package:app/newsFeedRepo/bloc/teacher_list_tile_cubit/teacher_list_tile_cubit.dart';
import 'package:app/newsFeedRepo/feed_category/feed_category_bloc.dart';
import 'package:app/newsFeedRepo/student_listTile_cubit/student_list_tile_cubit.dart';
import 'package:app/viewNewsFeed/bloc/view_news_feed_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:app/screens/SplashScreen.dart';
import 'package:app/utils/Utils.dart';
import 'package:app/newsFeedRepo/bloc/create_feed_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiBlocProvider(providers: [
    BlocProvider<CreateFeedBloc>(create: (context)=> CreateFeedBloc()),
    BlocProvider<SwitchCubit>(create: (context)=> SwitchCubit()),
    BlocProvider<DropDownCubit>(create: (context)=> DropDownCubit()),
    BlocProvider<FeedCategoryBloc>(create: (context)=> FeedCategoryBloc()),
    BlocProvider<StudentListTileCubit>(create: (context)=> StudentListTileCubit()),
    BlocProvider<TeacherListTileCubit>(create: (context)=> TeacherListTileCubit()),
    BlocProvider<CategoryListBloc>(create: (context)=> CategoryListBloc()),
    BlocProvider<ViewNewsFeedBloc>(create: (context)=> ViewNewsFeedBloc()),
  ],
      child: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isRTL;

  @override
  void initState() {
    super.initState();

    Utils.getIntValue('locale').then((value) {
      setState(() {
        isRTL = value == 0 ? true : false;
        //Utils.showToast('$isRTL');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return isRTL != null
            ? isRTL
                ? MaterialApp(
                    title: "app",
                    debugShowCheckedModeBanner: false,
                    //theme: basicTheme(),
                    home: Scaffold(
                      body: Splash(),
                    ),
                    localizationsDelegates: [
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                    ],
                    supportedLocales: [
                      Locale("fa",
                          "IR"), // OR Locale('ar', 'AE') OR Other RTL locales
                    ],
                  )
                : MaterialApp(
                    title: "app",
                    debugShowCheckedModeBanner: false,
                    //theme: basicTheme(),
                    home: Scaffold(
                      body: Splash(),
                    ),
                  )
            : Material(
                child: Directionality(
                    textDirection: TextDirection.ltr,
                    child: Center(child: Text('Loading...'))));
  }
}
