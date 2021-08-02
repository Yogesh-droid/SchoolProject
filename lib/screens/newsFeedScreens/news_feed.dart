import 'package:app/viewNewsFeed/bloc/view_news_feed_bloc.dart';
import 'package:app/viewNewsFeed/model/viewNewsFeedResponse.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'add_new_feed.dart';

class NewsFeed extends StatefulWidget {
  const NewsFeed({key}) : super(key: key);

  @override
  _NewsFeedState createState() => _NewsFeedState();
}

class _NewsFeedState extends State<NewsFeed> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<ViewNewsFeedBloc>().add(ViewNewsFeed());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        elevation: 0.0,
        primary: true,
        centerTitle: true,
        title: Container(
          padding: EdgeInsets.all(10.0),
          child: Text('News feed'),
        ),
        actions: [
          IconButton(
            padding: const EdgeInsets.only(top: 0.0),
            icon: Icon(Icons.add_circle),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => AddNewFeed()));
            },
          ),
        ],
        flexibleSpace: Image(
          image: AssetImage('assets/images/tool_bar_bg.png'),
          fit: BoxFit.cover,
        ),
        backgroundColor: Colors.transparent,
      ),
      body: BlocBuilder<ViewNewsFeedBloc,ViewNewsFeedState>(
        builder: (context, state) {
          if(state is ViewAllNewsFeed){
            return Container(
                child: ListView.builder(
                    itemCount: state.response.data.length != null ? state.response.data.length : 0,
                    itemBuilder: (context,index){
                      return buildNewsCard(state.response.data.elementAt(index));
                    })
            );
          }
          return Container();
        }
      )
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
}
