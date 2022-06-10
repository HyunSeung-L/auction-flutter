
import 'package:auction/models/auction.dart';
import 'package:flutter/material.dart';
import 'package:auction/utilities/widget_utils.dart';
import 'package:provider/provider.dart';

import '../provider/auctions_provider.dart';

class MainPageWidget extends StatefulWidget {

  const MainPageWidget({Key? key}) : super(key:key);

  @override
  _MainPageWidgetWidgetState createState() => _MainPageWidgetWidgetState();
}

class _MainPageWidgetWidgetState extends State<MainPageWidget> {

  @override
  Widget build(BuildContext context) {
    Auctions auctions = Provider.of<Auctions>(context);

    return ListView.builder(
      itemBuilder: (ctx, idx) {
        if (idx == 0) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            color: Colors.cyan,
            width: WidgetUtils.getScreenWidth(),
            height: 60,
          );
        }else if (idx == 1) {
          if (auctions.count == 0) {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              child: const Text("진행 중인 경매가 없습니다.",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              color: Colors.amber,
              width: WidgetUtils.getScreenWidth(),
              height: 60,
            );
          } else {
            return FutureBuilder<List<Auction>> (
              future: auctions.auctions,
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
