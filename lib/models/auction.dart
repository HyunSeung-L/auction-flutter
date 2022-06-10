class Auction {
  //product information
  String name;
  String category;
  String details;

  String lowerLimitPrice; // 시작 가격
  String upperLimitPrice; // 상한 가격
  //List<String> images;

  Auction({
    required this.name,
    required this.category,
    required this.lowerLimitPrice,
    required this.upperLimitPrice,
    required this.details
    //required this.images
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'category': category,
      'lowerLimitPrice': lowerLimitPrice,
      'upperLimitPrice': upperLimitPrice,
      'details': details
    };
  }

  factory Auction.fromJson(Map<String, dynamic> json) {
    return Auction(
        name: json['name'],
        category: json['category'],
        lowerLimitPrice: json['lowerLimitPrice'],
        upperLimitPrice: json['upperLimitPrice'],
        details: json['details'],
        //images: json['images']
    );
  }
}

class AuctionList {
  final List<Auction> auctions;
  final int count;

  AuctionList({
    required this.auctions,
    required this.count
  });

  int length() {
    return count;
  }

  factory AuctionList.fromJson(List<dynamic> parsedJson) {
    List<Auction> auctions = List<Auction>.empty();
    auctions = parsedJson.map((i)=>Auction.fromJson(i)).toList();
    int count = auctions.isNotEmpty ? auctions.length : 0;

    return AuctionList(
        auctions: auctions,
        count: count
    );
  }
}