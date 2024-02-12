import 'dart:convert';

import 'package:ebook/my_tabs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late List PopularBooks = [];
  late List books=[];


  late ScrollController _scrollController;
  late TabController _tabController;

  Future<void> ReadData() async {
    String data = await DefaultAssetBundle.of(context)
        .loadString("lib/json/PopularBooks.json");
    setState(() {
      PopularBooks = json.decode(data);
    });
    String SecondData = await DefaultAssetBundle.of(context)
        .loadString("lib/json/books.json");
    setState(() {
      books = json.decode(SecondData);
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _scrollController = ScrollController();
    ReadData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ImageIcon(
                      AssetImage("lib/images/apps.png"),
                      size: 24,
                      color: Colors.black,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.search,
                          size: 30,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.notifications,
                          size: 30,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Text(
                      "Popular Books",
                      style: TextStyle(fontSize: 30),
                    ),
                  )
                ],
              ),
              SizedBox(height: 20),
              Container(
                height: 180,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: -20,
                      right: 0,
                      child: Container(
                        height: 180,
                        child: PageView.builder(
                            controller: PageController(viewportFraction: 0.8),
                            itemCount:
                                PopularBooks == null ? 0 : PopularBooks.length,
                            itemBuilder: (context, index) {
                              return Container(
                                height: 180,
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    image: DecorationImage(
                                        image: AssetImage(
                                            PopularBooks[index]["img"]),
                                        fit: BoxFit.fill)),
                              );
                            }),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: NestedScrollView(
                controller: _scrollController,
                headerSliverBuilder: (BuildContext context, bool isScroll) {
                  return [
                    SliverAppBar(
                      pinned: true,
                      backgroundColor: Colors.white,
                      bottom: PreferredSize(
                        preferredSize: Size.fromHeight(50),
                        child: Container(
                          margin: EdgeInsets.only(bottom: 20),
                          child: TabBar(
                            tabAlignment: TabAlignment.center,
                            indicatorPadding: EdgeInsets.all(0),
                            indicatorSize: TabBarIndicatorSize.label,
                            labelPadding: EdgeInsets.only(right: 10),
                            controller: _tabController,
                            isScrollable: true,
                            indicator: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    blurRadius: 7,
                                    offset: Offset(0, 0),
                                  )
                                ]),
                            tabs: [
                              AppTab(color: Colors.deepOrange, text: "new"),
                              AppTab(color: Colors.pink, text: "Popular"),
                              AppTab(color: Colors.yellow, text: "Trending"),
                            ],
                          ),
                        ),
                      ),
                    )
                  ];
                },
                body: TabBarView(
                  controller: _tabController,
                  children: [
                    ListView.builder(
                        itemCount: books == null ? 0 : books.length,
                        itemBuilder: (_,i){
                      return Container(
                        margin: EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
                        child:  Container(
                          decoration:
                          BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 12,
                                offset: Offset(0,0),
                                color: Colors.grey.withOpacity(0.3),


                              )
                            ],

                          ),
                          child:
                          Container(
                            padding: EdgeInsets.all(8),
                            child: Row(
                              children: [
                                Container(height: 120,width: 90,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: AssetImage(books[i]["img"]),
                                    fit:BoxFit.fill,

                                  )
                                ),),
                                SizedBox(width: 10),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.star,color: Colors.yellow,size: 15,),
                                        SizedBox(width: 6,),
                                        Text(books[i]["rating"],style: TextStyle(color: Colors.yellow,fontWeight: FontWeight.w500,fontSize: 15),)
                                      ],
                                    ),
                                    Text(books[i]["title"],style: TextStyle(color: Colors.blueGrey,fontWeight: FontWeight.w700,fontSize: 17),),
                                    Text(books[i]["text"],style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 17),),
                                    SizedBox(height: 5),
                                    Container(
                                      decoration:
                                      BoxDecoration(
                                        color: Colors.blueAccent,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius: 5,
                                            offset: Offset(0,0),
                                            color: Colors.black.withOpacity(0.3),


                                          )
                                        ],

                                      ),
                                    height: 22,
                                    width: 60,
                                    child: Center(child: Text("Love",style: TextStyle(color: Colors.yellow,fontWeight: FontWeight.w400,fontSize: 16),)),
                                        )


                                  ],
                                )

                              ],
                            ),
                          ),

                        ),
                      );
                    }),
                    ListView.builder(
                        itemCount: books == null ? 0 : books.length,
                        itemBuilder: (_,i){
                      return Container(
                        margin: EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
                        child:  Container(
                          decoration:
                          BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 12,
                                offset: Offset(0,0),
                                color: Colors.grey.withOpacity(0.3),


                              )
                            ],

                          ),
                          child:
                          Container(
                            padding: EdgeInsets.all(8),
                            child: Row(
                              children: [
                                Container(height: 120,width: 90,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: AssetImage(books[i]["img"]),
                                  )
                                ),),
                                SizedBox(width: 10),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.star,color: Colors.yellow,size: 15,),
                                        SizedBox(width: 6,),
                                        Text(books[i]["rating"],style: TextStyle(color: Colors.yellow,fontWeight: FontWeight.w500,fontSize: 15),)
                                      ],
                                    ),
                                    Text(books[i]["title"],style: TextStyle(color: Colors.blueGrey,fontWeight: FontWeight.w700,fontSize: 17),),
                                    Text(books[i]["text"],style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 17),),
                                    SizedBox(height: 5),
                                    Container(
                                      decoration:
                                      BoxDecoration(
                                        color: Colors.blueAccent,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius: 5,
                                            offset: Offset(0,0),
                                            color: Colors.black.withOpacity(0.3),


                                          )
                                        ],

                                      ),
                                    height: 22,
                                    width: 60,
                                    child: Center(child: Text("Love",style: TextStyle(color: Colors.yellow,fontWeight: FontWeight.w400,fontSize: 16),)),
                                        )


                                  ],
                                )

                              ],
                            ),
                          ),

                        ),
                      );
                    }),
                    ListView.builder(
                        itemCount: books == null ? 0 : books.length,
                        itemBuilder: (_,i){
                          return Container(
                            margin: EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
                            child:  Container(
                              decoration:
                              BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 12,
                                    offset: Offset(0,0),
                                    color: Colors.grey.withOpacity(0.3),


                                  )
                                ],

                              ),
                              child:
                              Container(
                                padding: EdgeInsets.all(8),
                                child: Row(
                                  children: [
                                    Container(height: 120,width: 90,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          image: DecorationImage(
                                            image: AssetImage(books[i]["img"]),
                                          )
                                      ),),
                                    SizedBox(width: 10),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(Icons.star,color: Colors.yellow,size: 15,),
                                            SizedBox(width: 6,),
                                            Text(books[i]["rating"],style: TextStyle(color: Colors.yellow,fontWeight: FontWeight.w500,fontSize: 15),)
                                          ],
                                        ),
                                        Text(books[i]["title"],style: TextStyle(color: Colors.blueGrey,fontWeight: FontWeight.w700,fontSize: 17),),
                                        Text(books[i]["text"],style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 17),),
                                        SizedBox(height: 5),
                                        Container(
                                          decoration:
                                          BoxDecoration(
                                            color: Colors.blueAccent,
                                            borderRadius: BorderRadius.circular(10),
                                            boxShadow: [
                                              BoxShadow(
                                                blurRadius: 5,
                                                offset: Offset(0,0),
                                                color: Colors.black.withOpacity(0.3),


                                              )
                                            ],

                                          ),
                                          height: 22,
                                          width: 60,
                                          child: Center(child: Text("Love",style: TextStyle(color: Colors.yellow,fontWeight: FontWeight.w400,fontSize: 16),)),
                                        )


                                      ],
                                    )

                                  ],
                                ),
                              ),

                            ),
                          );
                        }),




                  ],
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
