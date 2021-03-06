import 'dart:convert';
import 'dart:io';

import 'package:app/newsFeedRepo/bloc/categories/category_list_bloc.dart' as post;
import 'package:app/newsFeedRepo/bloc/drop_down_value/drop_down_cubit.dart';
import 'package:app/newsFeedRepo/bloc/news_feed_switch_bloc/switch_cubit.dart';
import 'package:app/utils/apis/Apis.dart';
import 'package:app/utils/modal/newsFeedModels/categories_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddNewFeed extends StatefulWidget {
  const AddNewFeed({key}) : super(key: key);

  @override
  _AddNewFeedState createState() => _AddNewFeedState();
}

class _AddNewFeedState extends State<AddNewFeed> {
  int  activeState;
  String image;
  List<String> tagsList=[];
  String category ;
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text('Add News Feed'),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        primary: true,
        flexibleSpace: Image(
        image: AssetImage('assets/images/tool_bar_bg.png'),
        fit: BoxFit.cover,
      ),),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10.0),
              child: Card(
                elevation: 1.0,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: titleController,
                        decoration: InputDecoration(
                          hintText: 'Title',
                        ),
                        maxLines: 1,
                      ),
                    ),
                    SizedBox(height: 10.0,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: descController,
                        maxLines: 5,
                        decoration: InputDecoration(
                          labelText: 'Description',
                          //hintText: 'description',
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: BlocBuilder<SwitchCubit,int>(
                        builder: (context, state) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Status:'),
                              Row(
                                children: [
                                  Text('Active'),
                                  Radio<int>(value: 1, groupValue: state, onChanged: (value){
                                    activeState = 1;
                                    context.read<SwitchCubit>().updateSwitch(1);
                                  }),
                                ],
                              ),
                              Row(
                                children: [
                                  Text('InActive'),
                                  Radio<int>(value: 2, groupValue: state, onChanged: (value){
                                    activeState = 0;
                                    context.read<SwitchCubit>().updateSwitch(2);
                                  }),
                                ],
                              ),
                            ],
                          );
                        }
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            image ?? "Browse Image"
                          ),
                          MaterialButton(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                              onPressed: (){
                                _updateImage();
                              },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: Colors.purple,
                            ),
                            width: 80,
                            height: 40,
                            child: Center(
                              child :Text('Browse',style: TextStyle(color: Colors.white),)
                            ),
                          ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Divider(color: Colors.black,),
                    ),
                    getDropDownForRoles(context),
                    SizedBox(height: 10.0,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: Text('Group To')),
                    ),
                    SizedBox(height: 10.0,),
                    BlocBuilder<post.CategoryListBloc,post.CategoryListState>(
                      builder: (context, state) {
                        if(state is post.CommonPostState){
                          List<CategoriesModel> classList = state.allList;
                          return ListView(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            children: [
                              buildCheckBoxTile(state.studentModel),
                              buildCheckBoxTile(state.teacherModel),
                              Divider(color: Colors.black,),
                              ...classList.map((e) => buildCheckBoxTile(e)).toList()
                            ],
                          );
                        }
                        if(state is post.StudentPostState){
                          List<CategoriesModel> classList = state.allList;
                          //return buildCheckBoxTile(state.studentModel);
                          return ListView(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            children: [
                              buildCheckBoxTile(state.studentModel),
                              Divider(color: Colors.black,),
                              ...classList.map((e) => buildCheckBoxTile(e)).toList()
                            ],
                          );
                        }
                        if(state is post.TeacherPostState){
                          return buildCheckBoxTile(state.teacherModel);
                        }
                        return Container();
                      }
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.blueAccent,
        height: 50,
        child: MaterialButton(
          onPressed: () async {
            SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
            var email = await sharedPreferences.get('email');
            var password = await sharedPreferences.get('password');
            var response1 = await http.get(InfixApi.login(email, password));
            var token = '';
            if (response1.statusCode == 200) {
              Map<String, dynamic> user = jsonDecode(response1.body) as Map;
              token = user['data']['accessToken'];
            }
            Map<String,dynamic> body = {
              "title":titleController.text,
              "description":descController.text,
              "category":category,
              "tag":tagsList,
              "image_link":"https://images.indianexpress.com/2021/07/Guru-Purnima-feature-card-1.jpg",
              "created_by":"18",
              "active_status":activeState,
              "is_published":1
            };
            await http.post("http://ahaschool.in/api/save-forum-data",
            body: jsonEncode(body),
            headers: {
              "Accept": "application/json",
              "content-type": "application/json",
              "Authorization":token
            }).then((value){
              print(value.body);
            });
          },
          child: Text('save'),
        )
      ),
    );
  }

  Widget getDropDownForRoles(BuildContext context1) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 60,
        width: MediaQuery.of(context1).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.black),
        ),
        child: BlocBuilder<DropDownCubit,String>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                  value: state.isNotEmpty ? state : 'Teacher\'s post',
                  onChanged: (value) {
                    category = value;
                  context1.read<DropDownCubit>().updateRoleValue(value);
                  //context1.read<FeedCategoryBloc>().add(PostEvent(value));
                  tagsList.clear();
                    context.read<post.CategoryListBloc>().add(post.PostEvent(value));
                },
                  items: [
                  DropdownMenuItem(
                      value: 'Teacher\'s post',
                      child: Text('Teacher\'s post')),
                  DropdownMenuItem(
                  value :'Student\'s post',
                      child: Text('Student\'s post')),
                  DropdownMenuItem(
                    value: 'Parents\'s post',
                      child: Text('Parents\'s post')),
                  DropdownMenuItem(
                      value: 'Common post',
                      child: Text('Common post')),
                ],

                ),
              );
            }
          )
      ),
    );
  }

  Widget buildCheckBoxTile(CategoriesModel model) {
    if(model.value){
      tagsList.add(model.title);
    }
    return CheckboxListTile(
        title: Text(model.title),
        value: model.value,
        onChanged: (value) {
          tagsList.clear();
          context.read<post.CategoryListBloc>().add(post.UpdateValue(id: model.id,value: value));
        });
  }

  Future _updateImage() async {
    ImagePicker imagePicker = ImagePicker();
    var fileImage = await imagePicker.getImage(source: ImageSource.gallery);
    if (fileImage != null) {
      setState(() {
        image = File(fileImage.path).path;
      });
    } else {

    }
  }

}
