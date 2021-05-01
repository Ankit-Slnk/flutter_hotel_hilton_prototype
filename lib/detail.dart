import 'package:flutter/material.dart';
import 'package:testing/TabViewWidget.dart';

class DetailWidget extends StatefulWidget {
  int item;
  DetailWidget({
    @required this.item,
  });
  @override
  _DetailWidgetState createState() => _DetailWidgetState();
}

class _DetailWidgetState extends State<DetailWidget>
    with TickerProviderStateMixin {
  var squareScaleA = 0.5;
  AnimationController _controllerA;
  int selectedIndex1 = 1;
  int selectedIndex2 = 3;

  @override
  void initState() {
    _controllerA = AnimationController(
        vsync: this,
        lowerBound: 0.5,
        upperBound: 1.0,
        duration: Duration(milliseconds: 500));
    _controllerA.addListener(() {
      setState(() {
        squareScaleA = _controllerA.value;
      });
    });

    _controllerA.forward(from: 0.0);
    super.initState();
  }

  @override
  void dispose() {
    _controllerA.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(
              Icons.keyboard_backspace_rounded,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            "Hotel Hilton",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.grid_view,
                color: Colors.black,
              ),
              onPressed: () {},
            ),
          ],
        ),
        body: body(),
      ),
    );
  }

  Widget body() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: 32,
              bottom: 20,
            ),
            child: Text(
              "Order Meal",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
          ),
          TabBar(
            labelPadding: EdgeInsets.zero,
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(
                color: Colors.black,
                width: 2,
              ),
            ),
            isScrollable: true,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.black,
            tabs: [
              tabItemView("Italian", 0),
              tabItemView("Chinese", 1),
              tabItemView("Arabic", 2),
              tabItemView("Indian", 3),
              tabItemView("French", 4),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: List.generate(5, (index) => TabViewWidget()),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  filterTap();
                },
                child: Container(
                  color: Colors.transparent,
                  child: Transform.scale(
                    scale: squareScaleA,
                    child: Container(
                      margin: EdgeInsets.only(
                        bottom: 20,
                      ),
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Icon(
                        Icons.filter_list_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  filterTap() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              margin: EdgeInsets.only(
                bottom: 20,
              ),
              height: 250,
              child: Column(
                children: [
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    "Filter",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Divider(
                    color: Colors.white,
                    thickness: 1,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIndex1 = 0;
                            });
                          },
                          child: itemView1(0),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIndex1 = 1;
                            });
                          },
                          child: itemView1(1),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIndex1 = 2;
                            });
                          },
                          child: itemView1(2),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIndex1 = 3;
                            });
                          },
                          child: itemView1(3),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Divider(
                    color: Colors.white,
                    thickness: 1,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIndex2 = 0;
                            });
                          },
                          child: itemView2(0),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIndex2 = 1;
                            });
                          },
                          child: itemView2(1),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIndex2 = 2;
                            });
                          },
                          child: itemView2(2),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIndex2 = 3;
                            });
                          },
                          child: itemView2(3),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget itemView2(int index) {
    return Container(
      color: Colors.transparent,
      height: 50,
      child: Column(
        children: [
          Text(
            index == 0
                ? "1"
                : index == 1
                    ? "30"
                    : index == 2
                        ? "45"
                        : "60",
            style: TextStyle(
                color: selectedIndex2 == index ? Colors.white : Colors.grey,
                fontWeight: selectedIndex2 == index
                    ? FontWeight.bold
                    : FontWeight.normal),
          ),
          Text(
            "min",
            style: TextStyle(
                color: selectedIndex2 == index ? Colors.white : Colors.grey,
                fontWeight: selectedIndex2 == index
                    ? FontWeight.bold
                    : FontWeight.normal),
          )
        ],
      ),
    );
  }

  Widget itemView1(int index) {
    return Container(
      color: Colors.transparent,
      height: 50,
      child: Column(
        children: [
          Icon(
            index == 0
                ? Icons.lunch_dining
                : index == 1
                    ? Icons.free_breakfast
                    : index == 2
                        ? Icons.fastfood
                        : Icons.local_bar,
            color: selectedIndex1 == index ? Colors.white : Colors.grey,
          ),
          Text(
            index == 0
                ? "Salad"
                : index == 1
                    ? "Breakfast"
                    : index == 2
                        ? "Fast Food"
                        : "Beverages",
            style: TextStyle(
                color: selectedIndex1 == index ? Colors.white : Colors.grey,
                fontWeight: selectedIndex1 == index
                    ? FontWeight.bold
                    : FontWeight.normal),
          )
        ],
      ),
    );
  }

  Widget tabItemView(String text, int index) {
    return Container(
      alignment: Alignment.center,
      width: 100,
      padding: EdgeInsets.only(
        bottom: 4,
      ),
      child: Text(text),
    );
  }
}
