import 'package:atbmarket_app/models/7daysSaleStore.dart';
import 'package:atbmarket_app/models/economySaleStore.dart';
import 'package:atbmarket_app/models/saleTypeEnum.dart';
import 'package:atbmarket_app/screens/sale_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final itemsListStore = SevenDaysItemsList();

class HomeScreen extends StatelessWidget {
  static String routeName = "/";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("АТБ"),
        actions: <Widget>[
          refreshButton(),
        ],
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                buildSectionDescription("Акции:", context),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SaleContainer(
                          width: MediaQuery.of(context).size.width / 2.5,
                          height: MediaQuery.of(context).size.width / 1.5,
                          title: "7 дней",
                          thumbPath: 'assets/7days.jpg',
                          onTap: () {
                            print("tap");
                            Navigator.pushNamed(context, SaleScreen.routeName,
                                arguments: SaleType.SevenDays);
                          }),
                      Spacer(),
                      SaleContainer(
                          width: MediaQuery.of(context).size.width / 2.5,
                          height: MediaQuery.of(context).size.width / 1.5,
                          title: "Экономия",
                          thumbPath: "assets/economy.jpg",
                          onTap: () {
                            print("tap");
                            Navigator.pushNamed(context, SaleScreen.routeName,
                                arguments: SaleType.Economy);
                          }),
                    ],
                  ),
                ),
                SizedBox(
                  height: 35,
                ),
                buildSectionDescription("Магазины на карте:", context),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 170,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.grey[100],
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container buildSectionDescription(String text, BuildContext context) {
    return Container(
      child: Text(
        text,
        style: Theme.of(context).textTheme.headline2,
      ),
    );
  }
}

class refreshButton extends StatelessWidget {
  const refreshButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.refresh),
      onPressed: () {
        final snackBar = SnackBar(content: Text('Обновлено!'));
        Scaffold.of(context).showSnackBar(snackBar);
        Provider.of<SevenDaysItemsList>(context, listen: false).loadData();
        Provider.of<EconomyItemsList>(context, listen: false).loadData();
      },
    );
  }
}

class SaleContainer extends StatelessWidget {
  SaleContainer(
      {Key key,
      this.width,
      this.height,
      this.title,
      this.caption = null,
      this.thumbPath,
      this.onTap})
      : super(key: key);
  final double width;
  final double height;
  final String title;
  final String caption;
  final String thumbPath;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.grey[100],
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          image: DecorationImage(
            image: new ExactAssetImage(thumbPath),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
            padding: EdgeInsets.only(
              top: height * 0.75,
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Theme.of(context).backgroundColor,
              ),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        title,
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      if (caption != null)
                        Text(
                          caption,
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.caption,
                        ),
                    ],
                  ),
                ),
              ),
            )),
      ),
      onTap: onTap,
    );
  }
}
