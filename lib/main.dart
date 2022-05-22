import 'package:auction/connect/http.dart';
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

  List<Auction> auctionData = [
    Auction(
        name: "상품명1",
        category: "TBD",
        lowerLimitPrice: "1000",
        upperLimitPrice: "100000",
        details: "상품설명1"
    ),
    Auction(
        name: "상품명2",
        category: "TBD",
        lowerLimitPrice: "2000",
        upperLimitPrice: "200000",
        details: "상품설명2"
    ),
  ];

  late Future<List<Auction>> auctionList;

  @override
  void initState() {
    super.initState();
    auctionList = Http.getAuctionList('/auction');
  }

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

  Widget getMainPage() {
    return ListView.builder(
      itemBuilder: (ctx, idx) {
        if (idx == 0) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            color: Colors.cyan,
            width: MediaQuery.of(context).size.width,
            height: 60,
          );
        }else if (idx == 1) {
          if (auctionData.isEmpty) {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              child: const Text("진행 중인 경매가 없습니다.",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              color: Colors.amber,
              width: MediaQuery.of(context).size.width,
              height: 60,
            );
          } else {
            return FutureBuilder<List<Auction>> (
              future: auctionList,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return SingleChildScrollView(
                    physics: const ScrollPhysics(),
                    child: Column(
                      children: [
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,   // List가 null일 경우 처리 어떻게?
                          itemBuilder: (BuildContext context, int idx) {
                            Auction auction = snapshot.data![idx];
                            return InkWell(
                                splashColor: Colors.amber,
                                highlightColor: Colors.pink,
                                onTap: (){},
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.blueAccent)
                                  ),
                                  padding: const EdgeInsets.all(3.0),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 20
                                  ),
                                  child: Column(
                                    children: [
                                      Row(children: [Text('상품명 : ' + auction.name)],),
                                      Row(children: [Text('상한가 : ' + auction.upperLimitPrice)],),
                                      Row(children: [Text('시작가 : ' + auction.lowerLimitPrice)],),
                                    ],
                                  ),
                                )
                            );
                          },
                        )
                      ],
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                // 기본적으로 로딩 Spinner를 보여줍니다.
                return const CircularProgressIndicator();
              },
            );
          }
        }else {
          return Container();
        }
      },
      itemCount: 5,
    );
  }

}
