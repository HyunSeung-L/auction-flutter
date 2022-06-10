
import 'package:auction/provider/register_auction/text_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WriteDetailsWidget extends StatefulWidget {

  const WriteDetailsWidget({Key? key}) : super(key:key);

  @override
  _WriteDetailsWidgetState createState() => _WriteDetailsWidgetState();
}

class _WriteDetailsWidgetState extends State<WriteDetailsWidget> {

  @override
  Widget build(BuildContext context) {
    AuctionText auctionText = Provider.of<AuctionText>(context);

    return Container(
        margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: TextField(
          controller: auctionText.detailsController,
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
}