

import 'package:auction/data/auction.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuctionMakePage extends StatefulWidget{

  const AuctionMakePage({Key? key}) : super(key:key);

  @override
  State<StatefulWidget> createState() {
    return _AuctionMakePageState();
  }

}

class _AuctionMakePageState extends State<AuctionMakePage>{

  TextEditingController nameController = TextEditingController();
  TextEditingController detailsController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            child: const Text("경매 등록", style: TextStyle(color: Colors.white),),
            onPressed: () async {

              final Auction _auction = Auction(
                  name: nameController.text, category: "tbd",
                  details: detailsController.text,
                  lowerLimitPrice: 'tbd',
                  upperLimitPrice: 'tbd'
              );

              Map data = _auction.toMap();
              _postRequest('/auction/make', data);

              // 이 페이지가 꺼질 때 이 페이지를 실행했던 친구에게  widget.todo를 넘겨준다
              //Navigator.of(context).pop();
            },
          )
        ],
      ),
      body: ListView.builder(
        itemBuilder: (ctx, idx) {
          if(idx == 0) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5, ),
              child: const Text("상품명", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            );
          }
          if(idx == 1) {
            return Container(
                color: Colors.white54,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  controller: nameController,
                  style: const TextStyle(fontSize: 20),
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)
                      )
                  ),
                )
            );
          }
          else if(idx == 2) {
            return Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: const [
                    Text("경매 시작가", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                  ],
                )
            );
          }
          else if(idx == 3) {
            return Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: const [
                    Text("상한가", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                  ],
                )
            );
          }
          else if(idx == 4) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5, ),
              child: const Text("상품 설명", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            );
          }
          else if(idx == 5) {
            return Container(
                margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                child: TextField(
                  controller: detailsController,
                  minLines: 10,
                  maxLines: 20,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)
                      )
                  ),
                )
            );
          }
          else if(idx == 6) {
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
    );
  }
}

_postRequest(String url, Map data) async {
  String baseUrl = 'http://10.0.2.2:8080';
  String postUrl = baseUrl + url;
  var body = json.encode(data);
  try {
    final response = await http.post(
        Uri.parse(postUrl),
        headers: {"Content-Type": "application/json"},
        body: body
    );
  } catch (e) {
    print(e);
  }
}