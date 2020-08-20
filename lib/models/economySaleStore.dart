import 'dart:io';

import 'package:atbmarket_app/bl/parser.dart';
import 'package:atbmarket_app/models/saleItemsList.dart';

class EconomyItemsList extends SaleItemsList {
  @override
  void loadData({int tryCount = 0}) async {
    await parseHtmlFromUrl("https://www.atbmarket.com/hot/akcii/economy/")
        .then((val) {
      this.error = false;
      this.setListData(val);
      notifyListeners();
    }).catchError((_) async {
      try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          tryCount++;
          if (tryCount < 30)
            this.loadData(tryCount: tryCount);
          else {
            this.error = true;
            notifyListeners();
          }
        }
      } on SocketException catch (_) {
        print('not connected');
        this.error = true;
        notifyListeners();
      }
    });
  }
}
