import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:gallery_saver/gallery_saver.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String apikey = "..API_KEY..";
  String responsestring = "";
  Map<String, dynamic> imageMap = Map();
  List<dynamic> imgList = [];
  TextEditingController searchcategoryController = TextEditingController();

  void savetogall(String imglink) async {
    await GallerySaver.saveImage(imglink, toDcim: true);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.black,
        content: Text(
          "saved to gallery",
          style: TextStyle(color: Colors.purple),
        )));
  }

  void getData() async {
    String queryname = searchcategoryController.text != ""
        ? searchcategoryController.text
        : "inspiration";
    var response = await http.get(
        Uri.parse(
            "https://api.pexels.com/v1/search?query=${queryname}&per_page=50"),
        headers: {"Authorization": apikey});
    //Map<String,dynamic> jsonResponseBody = jsonDecode(response.body);
    //print(jsonResponseBody.toString());
    //imageMap = jsonResponseBody ;
    //[0]['src']['original']
    //responsestring=jsonResponseBody['photos'].toString();
    imageMap = jsonDecode(response.body);
    print(imageMap.toString());
    imgList = imageMap['photos'];
    setState(() {
      imageMap;
      imgList;
      queryname;
    });
  }


  /*
  AppBar(
            backgroundColor: Color.fromRGBO(1, 1, 1, 0.023529411764705882),
            title: RichText(
              text: TextSpan(
                  text: "Inspi",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                      letterSpacing: 1.5),
                  children: [
                    TextSpan(
                        text: "Nation",
                        style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 30,
                            color: Colors.purpleAccent))
                  ]),
            ),
          ),
   */

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:
          Scaffold(
          backgroundColor: Color.fromRGBO(16, 16, 16, 0.984313725490196),
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
              pinned: true,
              floating: false,
              snap: false,
              backgroundColor: Colors.black,
              centerTitle: false,
              expandedHeight: 310,
              //collapsedHeight: 120,
              flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                      children: [Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(bottomRight: Radius.circular(10),bottomLeft: Radius.circular(10)),

                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage("https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/67bd6e8d-605f-4803-92a3-624298b4b26e/dfqj8u9-0e46e53c-f208-4f51-ba68-938c754608cd.png?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7InBhdGgiOiJcL2ZcLzY3YmQ2ZThkLTYwNWYtNDgwMy05MmEzLTYyNDI5OGI0YjI2ZVwvZGZxajh1OS0wZTQ2ZTUzYy1mMjA4LTRmNTEtYmE2OC05MzhjNzU0NjA4Y2QucG5nIn1dXSwiYXVkIjpbInVybjpzZXJ2aWNlOmZpbGUuZG93bmxvYWQiXX0.jGl0COAL50agm73D-lPHOG8l4F1WLZ8S-5NYSLjTWPI")
                            )
                        ),
                      ),
                        Container(
                          //height: 200,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(bottomRight: Radius.circular(10),bottomLeft: Radius.circular(10)),
                                color: Colors.white,
                                gradient: LinearGradient(
                                    end: FractionalOffset.topCenter,
                                    begin: FractionalOffset.bottomCenter,
                                    colors: [
                                      Color.fromRGBO(16, 16, 16, 1.0),
                                      Colors.transparent
                                      // Color.fromRGBO(250, 105, 0, 0.0)
                                      // Color.fromRGBO(
                                      //     255, 255, 255, 0.023529411764705882)
                                    ]
                                )))]
                  ),
          title: RichText(
          text: TextSpan(
              text: "Inspi",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                  letterSpacing: 1.5),
              children: [
                TextSpan(
                    text: "Nation",
                    style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 30,
                        color: Colors.purpleAccent))
              ]))
              )
              ),
              SliverToBoxAdapter(
                child:Container(
                  height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding:
                            const EdgeInsets.symmetric(vertical: 6, horizontal: 22),
                        child: TextField(
                          onSubmitted: (value) => getData(),
                          controller: searchcategoryController,
                          decoration: InputDecoration(
                            hintText: "What are you looking for",
                            icon: Icon(Icons.search, color: Colors.black, size: 20),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // ElevatedButton(
                  //     style: ElevatedButton.styleFrom(
                  //         backgroundColor: Colors.purpleAccent,
                  //         shape: RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(40))),
                  //     onPressed: () => getData(),
                  //     child: Padding(
                  //       padding: const EdgeInsets.all(10),
                  //       child: Text(
                  //         "Search",
                  //         style: TextStyle(
                  //             color: Colors.black,
                  //             letterSpacing: 1.8,
                  //             fontWeight: FontWeight.w400,
                  //             fontSize: 20),
                  //       ),
                  //     )),
                  SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Container(
                      //color: Colors.black,
                      height: 40,
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: Center(
                        child: Text(
                          searchcategoryController.text != ""
                              ? (imgList.length != 0
                                  ? "Showing ${imgList.length} results for ${searchcategoryController.text}"
                                  : "No results found")
                              : "Find your \"inspiration\"",
                          maxLines: 1,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              letterSpacing: 1.2,
                              fontWeight: FontWeight.w300,
                              overflow: TextOverflow.ellipsis),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),

                  //imgList[index]['src']['original'].toString() //this is link to img original
                  Expanded(
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 300,
                            mainAxisExtent: 300,
                            crossAxisSpacing: 2,
                            mainAxisSpacing: 2),
                        cacheExtent: double.infinity,
                        itemCount: imgList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 8),
                            child: Stack(
                              children: [
                                Container(
                                    height: 600,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(imgList[index]
                                                    ['src']['medium']
                                                .toString())))),
                                Positioned(
                                    left: 6,
                                    bottom: 3,
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(50)
                                          ),
                                            backgroundColor: Colors.black),
                                        onPressed: () => savetogall(imgList[index]
                                                ['src']['medium']
                                            .toString()),
                                        child: Icon(Icons.download_rounded,color: Colors.purpleAccent,size: 20,)))
                              ],
                            ),
                          );
                        }),
                  )
                  // Expanded(
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(18.0),
                  //     child: Container(
                  //       decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(20),
                  //         image: DecorationImage(
                  //           fit: BoxFit.cover,
                  //           image: NetworkImage(responsestring)
                  //         )
                  //       ),
                  //     ),
                  //   ),
                  // )
                ],
              ),
            ),)]
          ),

      ),
    );
  }
}

/*

ListView.builder(
                    cacheExtent: double.infinity,
                    itemCount: imgList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 8),
                        child: Stack(
                          children: [
                            Container(
                                height: 300,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                        image: NetworkImage(imgList[index]
                                                ['src']['medium']
                                            .toString())))),
                            Positioned(
                                left: 12,
                                bottom: 12,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.black
                                    ),
                                    onPressed: () => savetogall(imgList[index]
                                            ['src']['medium']
                                        .toString()),
                                    child: Text(
                                      "save to gallery",
                                      style: TextStyle(color: Colors.amber),
                                    )))
                          ],
                        ),
                      );
                    })

 */
