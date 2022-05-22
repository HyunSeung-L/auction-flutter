import 'package:auction/data/auction.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Http {
  static String baseUrl = 'http://192.168.45.96:8080';
  // 221.139.111.227
  // 192.168.45.96

  static void postAuction(String url, Map data) async {
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

  static Future<List<Auction>> getAuctionList(String url) async {
    String getUrl = baseUrl + url;

    final response = await http.get(Uri.parse(getUrl));
    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      return compute(parseAuctions, response.body);
    } else {
      throw Exception('Failed to load Auction List');
    }
  }

  static List<Auction> parseAuctions(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

    return parsed.map<Auction>((json) => Auction.fromJson(json)).toList();
  }

  static Future<AuctionList> getAuctionListTwo(String url) async {
    String getUrl = baseUrl + url;

    final response = await http.get(Uri.parse(getUrl));

    if (response.statusCode == 200) {
      return AuctionList.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Auction List');
    }
  }




  static Future<Auction> getAuction(String url) async {
    String getUrl = baseUrl + url;

    final response = await http.get(Uri.parse(getUrl));

    if (response.statusCode == 200) {
      return Auction.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Auction List');
    }
  }
}