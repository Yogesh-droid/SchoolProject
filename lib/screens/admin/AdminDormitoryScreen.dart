import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:app/utils/CardItem.dart';
import 'package:app/utils/FunctinsData.dart';
import 'package:flutter/services.dart';
import 'package:app/utils/widget/AppBarWidget.dart';

// ignore: must_be_immutable
class AdminDormitoryHome extends StatefulWidget {
  var _titles;
  var _images;

  AdminDormitoryHome(this._titles, this._images);

  @override
  _AdminDormitoryHomeState createState() => _AdminDormitoryHomeState(_titles, _images);
}

class _AdminDormitoryHomeState extends State<AdminDormitoryHome> {
  int currentSelectedIndex;
  var _titles;
  var _images;

  _AdminDormitoryHomeState(this._titles, this._images);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.indigo, //or set color with: Color(0xFF0000FF)
    ));
    return Padding(
      padding: EdgeInsets.only(top: statusBarHeight),
      child: Scaffold(
        appBar: AppBarWidget.header(context, 'Dormitory'),
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
                  AppFunction.getAdminDormitoryPage(context, _titles[index]);
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
}
