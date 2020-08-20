import 'dart:io';

import 'package:atbmarket_app/models/7daysSaleStore.dart';
import 'package:atbmarket_app/models/economySaleStore.dart';
import 'package:atbmarket_app/models/saleItemModel.dart';
import 'package:atbmarket_app/models/saleItemsList.dart';
import 'package:atbmarket_app/models/saleTypeEnum.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SaleScreen extends StatelessWidget {
  static String routeName = "/sale-screen";

  @override
  Widget build(BuildContext context) {
    final SaleType type = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(type == SaleType.SevenDays ? "7 дней" : "Економия"),
      ),
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(child: SellsList()),
      ),
    );
  }
}

class SellsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final SaleType type = ModalRoute.of(context).settings.arguments;
    final SaleItemsList _items = type == SaleType.SevenDays
        ? Provider.of<SevenDaysItemsList>(context)
        : Provider.of<EconomyItemsList>(context);
    var salesList = _items.salesList;
    Widget child;
    print("rebuilt");
    print(salesList.length);
    if (salesList.length > 0) {
      child = Wrap(
        spacing: 10,
        runSpacing: 10,
        children: <Widget>[
          ...salesList.map((elem) => ProductCell(
                data: elem,
              ))
        ],
      );
    } else if (_items.error) {
      child = Column(
        children: <Widget>[
          SizedBox(
            child: Icon(
              Icons.error,
              size: 60,
            ),
            width: 60,
            height: 60,
          ),
          Padding(
            padding: EdgeInsets.only(top: 16),
            child:
                Text('Произошла ошибка\n  Проверьте подключение к интернету'),
          )
        ],
      );
    } else {
      child = Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          SizedBox(
            child: CircularProgressIndicator(),
            width: 60,
            height: 60,
          ),
          Padding(
            padding: EdgeInsets.only(top: 16),
            child: Text('Awaiting result...'),
          )
        ],
      );
    }
    sleep(Duration(milliseconds: 500));
    return Center(child: child);
  }
}

class ProductCell extends StatelessWidget {
  ProductCell({this.data});

  final ItemModel data;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      decoration: BoxDecoration(
          //border: Border.all(color: Colors.black87),
          borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width * 0.4,
              height: MediaQuery.of(context).size.width * 0.4,
              decoration: BoxDecoration(
                  //color: Colors.black87,
                  ),
              child: Image.network(data.picUrl),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Column(
                children: <Widget>[
                  Container(
                    child: Text(
                      data.name,
                      softWrap: true,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      color: Colors.redAccent,
                      child: Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: Text(data.price.toStringAsFixed(2) + " грн")))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
