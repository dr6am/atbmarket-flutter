import 'package:atbmarket_app/models/saleItemModel.dart';
import 'package:flutter/material.dart';

abstract class SaleItemsList extends ChangeNotifier {
  List<ItemModel> salesList = <ItemModel>[];

  bool error = false;
  void loadData() async {}

  void setListData(List<ItemModel> parsedArray) {
    salesList = parsedArray;
    print("list updated");
  }
}
