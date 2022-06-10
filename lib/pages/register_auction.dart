import 'package:auction/provider/register_auction/text_provider.dart';
import 'package:auction/widgets/register_auction/write_details.dart';
import 'package:auction/widgets/register_auction/write_name.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/register_auction/images_provider.dart';
import '../widgets/register_auction/pick_images.dart';
import '../widgets/register_auction/register_button.dart';

class MakeAuctionPage extends StatefulWidget{
  const MakeAuctionPage({Key? key}) : super(key:key);

  @override
  State<StatefulWidget> createState() {
    return _MakeAuctionPageState();
  }
}

class _MakeAuctionPageState extends State<MakeAuctionPage>{

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<AuctionImage>(create: (_) => AuctionImage()),
          ChangeNotifierProvider<AuctionText>(create: (_) => AuctionText()),
        ],
        child: Scaffold(
          appBar: AppBar(
            actions: const [ RegisterButtonWidget() ],
          ),
          body: ListView.builder(
            itemBuilder: (ctx, idx) {
              if(idx == 0) { return const PickImagesWidget(); }
              else if(idx == 1) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5, ),
                  child: const Text("상품명", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                );
              }
              else if(idx == 2) { return const WriteNameWidget(); }
              else if(idx == 3) {
                return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10,),
                    child: Row(
                      children: const [
                        Text("경매 시작가", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                      ],
                    )
                );
              }
              else if(idx == 4) {
                return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5,),
                    child: Row(
                      children: const [
                        Text("상한가", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                      ],
                    )
                );
              }
              else if(idx == 5) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5, ),
                  child: const Text("상품 설명", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                );
              }
              else if(idx == 6) { return const WriteDetailsWidget(); }
              else if(idx == 7) {
                return Container(
                    color: Colors.grey,
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: const [
                        Text("도움말\n"
                            "...\n...\n...\n...\n...\n...\n...",
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),),
                      ],
                    )
                );
              }
              return Container();
            }, itemCount: 9,
          ),
        )
    );
  }
}