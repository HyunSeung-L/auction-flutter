import 'dart:io';

import 'package:auction/provider/register_auction/images_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PickImagesWidget extends StatefulWidget {

  const PickImagesWidget({Key? key}) : super(key:key);

  @override
  _PickImagesWidgetState createState() => _PickImagesWidgetState();
}

class _PickImagesWidgetState extends State<PickImagesWidget> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AuctionImage auctionImage = Provider.of<AuctionImage>(context);

    return SizedBox(
      height: 100,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.all(12),
          itemBuilder: (context, index) {
            List<Widget> _boxContents = [];
            for (int i=0; i<auctionImage.count; i++) {
              _boxContents.add(Container());
            }
            _boxContents.add(
              IconButton(
                  onPressed: (){
                    auctionImage.getImages();
                  },
                  icon: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.6),
                        shape: BoxShape.circle
                    ),
                    child: Icon(
                      CupertinoIcons.camera,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  )
              ),
            );
            return Container(
              child: Center(child: _boxContents[index]),
              decoration: (index <= auctionImage.count - 1) ?
              BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: FileImage(File(auctionImage.images[index].path)),
                ),
              ) :
              BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.black,),
              ),
              width: 60,
            );
          },
          separatorBuilder: (context, idx) {
            return const SizedBox(
              width: 12,
            );
          },
          itemCount: auctionImage.count + 1
      ),
    );
  }
}
