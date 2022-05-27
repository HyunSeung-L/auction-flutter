


import 'dart:io';

import 'package:auction/data/auction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_picker/image_picker.dart';

import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart';


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

  final ImagePicker _picker = ImagePicker();
  List<XFile> _pickedImgs = [];

  Future<void> _pickImg() async {
    final List<XFile>? images = await _picker.pickMultiImage();
    if (images != null) {
      setState(() {
        _pickedImgs = images;
      });
    }
  }

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

              final Map data = Auction(
                  name: nameController.text, category: "tbd",
                  details: detailsController.text,
                  lowerLimitPrice: 'tbd',
                  upperLimitPrice: 'tbd'
              ).toMap();
              //_postRequest('/auction/register', data);

              final List<MultipartFile> _images = [];
              for (int i=0; i<_pickedImgs.length; i++) {
                XFile image = _pickedImgs[i];
                MultipartFile _image = MultipartFile.fromFileSync(image.path, contentType: MediaType("image", "jpg"));
                _images.add(_image);
              }

              FormData _formData = FormData.fromMap({
                "auction": data,
                "images": _images
              });

              //print(_formData.fields);

              Dio dio = Dio();
              dio.options.contentType = 'multipart/form-data';
              //String currentLoginUserId = context.read<UserInfoProvider>().uid;

              final res = await dio.post(
                //'http://192.168.45.96:8080/auction/register/images',
                'http://192.168.45.96:8080/auction/register/images',
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
          )
        ],
      ),
      body: ListView.builder(
        itemBuilder: (ctx, idx) {
          if(idx == 0) {
            return SizedBox(
              height: 100,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.all(12),
                  itemBuilder: (context, index) {
                    List<Widget> _boxContents = [];
                    for (int i=0; i<_pickedImgs.length; i++) {
                      _boxContents.add(Container());
                    }
                    _boxContents.add(
                      IconButton(
                        onPressed: (){
                          _pickImg();
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
                      decoration: (index <= _pickedImgs.length - 1)
                        ? BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: FileImage(File(_pickedImgs[index].path)),
                          ),
                        ) : null,
                      width: 60,
                    );
                  },
                  separatorBuilder: (context, idx) {
                    return const SizedBox(
                      width: 12,
                    );
                  },
                  itemCount: _pickedImgs.length + 1
              ),
            );
          }
          else if(idx == 1) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5, ),
              child: const Text("상품명", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            );
          }
          else if(idx == 2) {
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
          else if(idx == 3) {
            return Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: const [
                    Text("경매 시작가", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),

                  ],
                )
            );
          }
          else if(idx == 4) {
            return Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
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
          else if(idx == 6) {
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