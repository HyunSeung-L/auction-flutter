import 'package:auction/connect/http.dart';
import 'package:auction/models/auction.dart';
import 'package:flutter/material.dart';

class Auctions with ChangeNotifier {

  Future<List<Auction>> _auctionList = Http.getAuctionList('/auction');

  Future<List<Auction>> get auctions => _auctionList;
  Future<int> get count async => await _auctionList.then((value) {
    return value.length;
  });

  void getAuctionList() async {
    _auctionList = Http.getAuctionList('/auction');
    notifyListeners();
  }
}