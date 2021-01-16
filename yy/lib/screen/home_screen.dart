import 'package:flutter/material.dart';
import 'package:yy/global_state.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

class Home_Screen extends StatefulWidget {
  @override
  Home_Screen_State createState() => Home_Screen_State();
}

class Home_Screen_State extends State<Home_Screen> {
  Global_State _global_key = Global_State.instance;
  int _car_list_size;
  int _car_selected_index;

  void _load_cat() async {
    http.post(
      null,
      //'http://slumberjer.com/bookdepo/php/load_books.php',
      body: {},
    ).then((res) {
      if (res.body == 'failed') {
        print('no data');
      } else {
        //print(res.body);
        var books_jscode = json.decode(res.body);
        _global_key.cat_list = books_jscode['books'];
        _car_list_size = _global_key.cat_list.length;
        print(_car_list_size);
      }

      // if (res.body == 'nodata') {
      //   print('failed');
      // } else {
      //   print('yes');
      // }

      // if (res.body == "success") {
      //   Toast.show(
      //     "Get success.",
      //     context,
      //     duration: 4,
      //     gravity: Toast.BOTTOM,
      //   );
      // } else {
      //   print(res);
      //   Toast.show(
      //     "Get failed",
      //     context,
      //     duration: Toast.LENGTH_LONG,
      //     gravity: Toast.BOTTOM,
      //   );
      // }
    }).catchError((err) {
      print(err);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomPadding: true,
        appBar: AppBar(
          backgroundColor: Colors.deepOrange,
          title: Text(
            "Hope 4 Cat",
            style: TextStyle(fontSize: 30),
          ),
        ),
        body: Container(
          color: Colors.amber[100],
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
              childAspectRatio: 0.55,
            ),
            itemBuilder: (context, index) => InkWell(
              onTap: () {
                _car_selected_index = index;
                Navigator.of(context).pushNamedAndRemoveUntil(
                  "/CatDetailScreen",
                  (route) => true,
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.brown[900]),
                  color: Colors.white70,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 2,
                      offset: Offset(0, 2), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      height: 270,
                      child: Column(
                        children: [
                          Container(
                            child: null,
                            //   Image.network(
                            //     "http://slumberjer.com/bookdepo/bookcover/${book_list[index]['cover']}.jpg",
                            //     height: 170,
                            //   ),
                            //   decoration: BoxDecoration(
                            //     border: Border.all(
                            //       color: Colors.black,
                            //       width: 3,
                            //     ),
                            //   ),
                          ),

                          SizedBox(
                            height: 20,
                          ),
                          //book title
                          Text(
                            "",
                            //_global_key.cat_list[index]['cattitle'].toString(),
                            textAlign: TextAlign.center,
                            // overflow: TextOverflow.ellipsis,
                            // softWrap: false,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          //author
                          Text(
                            "",
                            //'Author: ${_global_key.cat_list[index]['author'].toString()}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    //price and rating bar
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.amber[400],
                        borderRadius: BorderRadiusDirectional.vertical(
                          bottom: Radius.circular(20),
                        ),
                      ),
                      child: Column(
                        children: [
                          //price
                          Container(
                            padding: EdgeInsets.fromLTRB(0, 10, 20, 0),
                            alignment: Alignment.centerRight,
                            child: Text(
                              "",
                              //'RM ${_global_key.cat_list[index]['price'].toString()}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          // Container(
                          //   padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                          //   alignment: Alignment.centerRight,
                          //   child: RatingBarIndicator(
                          //     rating: double.parse(book_list[index]['rating']),
                          //     itemBuilder: (context, index) => Icon(
                          //       Icons.star,
                          //       color: Colors.deepPurple,
                          //     ),
                          //     itemCount: 5,
                          //     itemSize: 20.0,
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            itemCount: 2,
          ),
        ),
        bottomNavigationBar: Row(
          children: [
            _build_bottom_navigation_bar_item(
              index: 0,
              icon: Icon(Icons.home),
              title: "home",
            ),
            _build_bottom_navigation_bar_item(
              index: 1,
              icon: Icon(Icons.laptop_mac),
              title: "Laptop",
            ),
            _build_bottom_navigation_bar_item(
              index: 2,
              icon: Icon(Icons.phone),
              title: "Phone",
            ),
            _build_bottom_navigation_bar_item(
              index: 3,
              icon: Icon(Icons.gamepad),
              title: "Game",
            ),
          ],
        ),
      ),
    );
  }

  //customised bottom navigation bar item
  Widget _build_bottom_navigation_bar_item(
      {int index, Icon icon, String title}) {
    return GestureDetector(
      onTap: () => setState(
        () {
          _global_key.navigation_bar_index = index;
          print(index); //check index
          if (index == 0)
            Navigator.of(context).pushReplacementNamed("/HomeScreen");
          else if (index == 1)
            Navigator.of(context).pushReplacementNamed("/UploadCatScreen");
          else if (index == 2)
            Navigator.of(context).pushReplacementNamed("/ProfileScreen");
        },
      ),
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width / 4,
        padding: const EdgeInsets.all(7),
        decoration: BoxDecoration(
          gradient: _global_key.navigation_bar_index == index
              ? LinearGradient(
                  colors: [
                    Colors.green.withOpacity(0.9),
                    Colors.green.withOpacity(0.2),
                    Colors.green.withOpacity(0.01),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                )
              : LinearGradient(
                  colors: [
                    Colors.white,
                    Colors.white,
                  ],
                ),
        ),
        child: Column(
          children: [
            icon,
            Text(title),
          ],
        ),
      ),
    );
  }
}
