import 'package:flutter/material.dart';

class AuctionText with ChangeNotifier {

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();

  TextEditingController get nameController => _nameController;
  TextEditingController get detailsController => _detailsController;
}