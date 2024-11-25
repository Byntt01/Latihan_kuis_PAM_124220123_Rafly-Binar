import 'package:flutter/material.dart';
import 'package:latihanresponsi/news_list.dart';
import 'package:latihanresponsi/blog_list.dart';
import 'package:latihanresponsi/reports_list.dart';


class MenuUtama extends StatefulWidget {
  const MenuUtama({Key? key}) : super(key: key);

  @override
  State<MenuUtama> createState() => _MenuUtama();
}

class _MenuUtama extends State<MenuUtama> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Center(
                child:Column (
                  children: [
                    Text ('SPACE FLIGHT NEWS'),
                  ],
                ),
              ),
            ),

            body: GridView.count(
                padding: const EdgeInsets.all(25),
                crossAxisCount: 1,
                children: <Widget>[
                  Card(
                    margin: const EdgeInsets.all(8),
                    child: InkWell(
                      onTap: (){},
                      splashColor: Colors.white70,
                      child: ElevatedButton(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            CircleAvatar(
                              backgroundImage: AssetImage('assets/image/news.jpg'),
                              radius: 100,
                            ),
                            Text("News",
                              style: TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold,),
                            ),
                            Text('Get an overview of the latest Spaceflight news, from various sources! Easily link your users to the right websites',
                              textAlign: TextAlign.justify,
                                style:TextStyle(color: Colors.black))
                          ],
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => NewsList()),
                          );
                        },

                      ),
                    ),
                  ),

                  Card(
                    margin: const EdgeInsets.all(8),
                    child: InkWell(
                      onTap: (){},
                      splashColor: Colors.white70,
                      child: ElevatedButton(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            CircleAvatar(
                              backgroundImage: AssetImage('assets/image/blog.jpg'),
                              radius: 100,
                            ),
                            Text("Blog", style: TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold,)),
                            Text('Blogs often provide a more detailed overview of launches and missions. A must-have for the serious spaceflight enthusiast',
                              textAlign: TextAlign.justify,
                                style:TextStyle(color: Colors.black))
                          ],
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => BlogList()),
                          );
                        },

                      ),
                    ),
                  ),

                  Card(
                    margin: const EdgeInsets.all(8),
                    child: InkWell(
                      onTap: (){},
                      splashColor: Colors.white70,
                      child: ElevatedButton(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: const <Widget>[
                            CircleAvatar(
                              backgroundImage: AssetImage('assets/image/report.jpg'),
                              radius: 100,
                            ),
                            Text("Reports", style: TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold,)),
                            Text('Space station and other missions often publish their data. With SNAPI, you can include it in your app as well!',
                              textAlign: TextAlign.justify,
                              style:TextStyle(color: Colors.black))
                          ],
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ReportsList()),
                          );
                        },

                      ),
                    ),
                  ),

                ]
            )
        )
    );
  }
}