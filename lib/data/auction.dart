class Auction {
  //product information
  String name;
  String category;
  String details;

  String lowerLimitPrice; // 시작 가격
  String upperLimitPrice; // 상한 가격

  Auction({
    required this.name,
    required this.category,
    required this.lowerLimitPrice,
    required this.upperLimitPrice,
    required this.details,
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
}