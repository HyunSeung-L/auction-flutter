import 'package:auction/provider/register_auction/text_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WriteNameWidget extends StatefulWidget {

  const WriteNameWidget({Key? key}) : super(key:key);

  @override
  _WriteNameWidgetState createState() => _WriteNameWidgetState();
}

class _WriteNameWidgetState extends State<WriteNameWidget> {

  @override
  Widget build(BuildContext context) {
    AuctionText auctionText = Provider.of<AuctionText>(context);

    return Container(
        color: Colors.white54,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: TextField(
          controller: auctionText.nameController,
          style: const TextStyle(fontSize: 20),
          decoration: const InputDecoration(
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)
              )
          ),
        )
    );
  }
}