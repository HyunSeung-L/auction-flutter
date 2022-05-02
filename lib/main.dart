import 'package:auction/data/auction.dart';
import 'package:auction/pages/makeAuction.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: '경매식 중고거래 앱'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: getMainPage(),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.short_text_rounded),
              label: "TBD1"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_box),
              label: "TBD2"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.arrow_right),
              label: "TBD3"
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (ctx) => const AuctionMakePage()
              )
          );
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget getMainPage(){
    return Column (
      children: [
        Container(
          height: 100,
          color: Colors.amber,
          child: const Center(
            child: Text("가로 스크롤로 해시태그 및 카테고리 등을 클릭",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
          ),
          margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        ),
        Container(
          height: 450,
          color: Colors.pink,
          child: const Center(
            child: Text("ListView로 스크롤 가능한 경매 리스트 표시",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              textAlign: TextAlign.center,
            ),
          ),
          margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        ),
      ]
    );
  }
}
