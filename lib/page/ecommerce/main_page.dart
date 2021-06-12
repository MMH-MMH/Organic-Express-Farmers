import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:organic/page/ecommerce/search_bar_home.dart';
import 'package:organic/widget/carousel_indicator.dart';
import 'package:organic/widget/horizontal_list_view.dart';
import 'package:organic/widget/navbar.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ConsumerMain extends StatefulWidget {
  _ConsumerMainState createState() => _ConsumerMainState();
}

class _ConsumerMainState extends State<ConsumerMain> {
  List<String> adList = [
    'https://codecanyon.img.customer.envatousercontent.com/files/201787761/banner%20intro.jpg?auto=compress%2Cformat&q=80&fit=crop&crop=top&max-h=8000&max-w=590&s=70a1c7c1e090863e2ea624db76295a0f',
    'https://mk0adespressoj4m2p68.kinstacdn.com/wp-content/uploads/2019/07/facebook-offer-ads.jpg',
    'https://assets.keap.com/image/upload/v1547580346/Blog%20thumbnail%20images/Screen_Shot_2019-01-15_at_12.25.23_PM.png',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQuX7EvcOkWOCYRFGR78Dxa2oNQb2OPCI7uqg&usqp=CAU'
  ];

  List<Map<String, String>> products = [
    {
      "title": "Product 1",
      "url":
          'https://codecanyon.img.customer.envatousercontent.com/files/201787761/banner%20intro.jpg?auto=compress%2Cformat&q=80&fit=crop&crop=top&max-h=8000&max-w=590&s=70a1c7c1e090863e2ea624db76295a0f',
    },
    {
      "title": "Product 2",
      "url":
          'https://mk0adespressoj4m2p68.kinstacdn.com/wp-content/uploads/2019/07/facebook-offer-ads.jpg',
    },
    {
      "title": "Product 3",
      "url":
          'https://assets.keap.com/image/upload/v1547580346/Blog%20thumbnail%20images/Screen_Shot_2019-01-15_at_12.25.23_PM.png',
    },
    {
      "title": "Product 4",
      "url":
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQuX7EvcOkWOCYRFGR78Dxa2oNQb2OPCI7uqg&usqp=CAU'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 20),
        CarouselWithIndicator(adList),
        SizedBox(height: 20),
        HorizontalListView("Categories", products),
        SizedBox(height: 20),
        HorizontalListView("Top Products", products),
      ],
    );
  }
}
