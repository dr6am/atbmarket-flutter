import 'package:atbmarket_app/models/saleItemModel.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

Future<List<ItemModel>> parseHtmlFromUrl(String url) async {
  //final url = "https://www.atbmarket.com/hot/akcii/7day/";
  List<ItemModel> result;
  var response = await http.get(url);
  if (response.statusCode == 200) {
    print("got data...");
    var document = parse(response.body);
    var parsed = document.querySelector("ul.promo_list").children;
    result = parsed.map((element) {
      print("parsing...");
      var elParsed = parse(element.outerHtml);
      //querySelector("")
      String picName = "https://www.atbmarket.com/" +
          elParsed.querySelector(".promo_image_link img").attributes["src"];

      String name = elParsed
          .querySelector(".promo_info > .promo_info_text")
          .text
          .split("\n")
          .map((item) => item.trim())
          .join(" ");
      double price = double.parse(elParsed
              .querySelector(".promo_price")
              .text
              .trim()
              .split(" ")
              .map((item) => item.trim())
              .join("")
              .substring(
                  0,
                  elParsed
                          .querySelector(".promo_price")
                          .text
                          .trim()
                          .split(" ")
                          .map((item) => item.trim())
                          .join("")
                          .length -
                      3)) /
          100;

      return new ItemModel(
        name: name,
        price: price,
        picUrl: picName,
      );
    }).toList();
    print("parsed...");
    return result;
  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
}
