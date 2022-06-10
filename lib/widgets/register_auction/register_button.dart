import 'package:auction/models/auction.dart';
import 'package:auction/provider/register_auction/text_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';

import '../../provider/register_auction/images_provider.dart';

class RegisterButtonWidget extends StatefulWidget {

  const RegisterButtonWidget({Key ? key}) : super();

  @override
  _RegisterButtonWidgetState createState() => _RegisterButtonWidgetState();
}

class _RegisterButtonWidgetState extends State<RegisterButtonWidget>{

  @override
  Widget build(BuildContext context) {
    AuctionImage auctionImage = Provider.of<AuctionImage>(context);
    AuctionText auctionText = Provider.of<AuctionText>(context);
    // TODO: implement build
    return TextButton(
      child: const Text("경매 등록", style: TextStyle(color: Colors.white),),
      onPressed: () async {
        final Map data = Auction(
            name: auctionText.nameController.text, category: "tbd",
            details: auctionText.detailsController.text,
            lowerLimitPrice: 'tbd',
            upperLimitPrice: 'tbd'
        ).toMap();

        final List<MultipartFile> _images = [];
        for (int i=0; i<auctionImage.count; i++) {
          XFile image = auctionImage.images[i];
          MultipartFile _image = MultipartFile.fromFileSync(image.path, contentType: MediaType("image", "jpg"));
          _images.add(_image);
        }

        FormData _formData = FormData.fromMap({
          "auction": data,
          "images": _images
        });

        Dio dio = Dio();
        dio.options.contentType = 'multipart/form-data';
        //String currentLoginUserId = context.read<UserInfoProvider>().uid;

        final res = await dio.post(
            'http://192.168.45.45:8080/auction/register/images',
            // localhost:8080 -> when using ios Simulator
            // 10.0.2.2:8080 -> when using android emulator
            // 192.168.45.96:8080 -> when using real android device
            // 192.168.45.45:8080 -> when using real iphone device
            data: _formData
        );

        if (res.statusCode == 201) {
          print(res.data);
        } else {
          print('error');
        }
        // 이 페이지가 꺼질 때 이 페이지를 실행했던 친구에게  widget.todo를 넘겨준다
        //Navigator.of(context).pop();
      },
    );
  }

}
//
// Widget registerButton (TextEditingController nameController,
//     TextEditingController detailsController,
//     List<XFile> _pickedImgs) {
//   return TextButton(
//     child: const Text("경매 등록", style: TextStyle(color: Colors.white),),
//     onPressed: () async {
//
//       final Map data = Auction(
//           name: nameController.text, category: "tbd",
//           details: detailsController.text,
//           lowerLimitPrice: 'tbd',
//           upperLimitPrice: 'tbd'
//       ).toMap();
//
//       final List<MultipartFile> _images = [];
//       for (int i=0; i<_pickedImgs.length; i++) {
//         XFile image = _pickedImgs[i];
//         MultipartFile _image = MultipartFile.fromFileSync(image.path, contentType: MediaType("image", "jpg"));
//         _images.add(_image);
//       }
//
//       FormData _formData = FormData.fromMap({
//         "auction": data,
//         "images": _images
//       });
//
//       Dio dio = Dio();
//       dio.options.contentType = 'multipart/form-data';
//       //String currentLoginUserId = context.read<UserInfoProvider>().uid;
//
//       final res = await dio.post(
//           'http://192.168.45.45:8080/auction/register/images',
//           // localhost:8080 -> when using ios Simulator
//           // 10.0.2.2:8080 -> when using android emulator
//           // 192.168.45.96:8080 -> when using real android device
//           data: _formData
//       );
//
//       if (res.statusCode == 201) {
//         print(res.data);
//       } else {
//         print('error');
//       }
//
//       // 이 페이지가 꺼질 때 이 페이지를 실행했던 친구에게  widget.todo를 넘겨준다
//       //Navigator.of(context).pop();
//     },
//   );
// }
