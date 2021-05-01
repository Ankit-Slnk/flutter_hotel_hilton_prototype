import 'package:flutter/material.dart';
import 'package:testing/detail.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<AnimatedListState> horizontalListKey =
      GlobalKey<AnimatedListState>();
  int horizontalListCounter = 0;
  final GlobalKey<AnimatedListState> gridListKey =
      GlobalKey<AnimatedListState>();
  int gridListCounter = 0;

  @override
  void initState() {
    _loadHorizontalItems();
    _loadVerticalItems();
    super.initState();
  }

  Future<void> _loadHorizontalItems() async {
    for (int i = 1; i <= 2; i++) {
      await Future.delayed(Duration(milliseconds: 200));
      horizontalListCounter++;
      horizontalListKey.currentState.insertItem(horizontalListCounter - 1);
    }
  }

  Future<void> _loadVerticalItems() async {
    for (int i = 1; i <= 4; i++) {
      await Future.delayed(Duration(milliseconds: 200));
      gridListCounter++;
      gridListKey.currentState.insertItem(gridListCounter - 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.sort,
            color: Colors.black,
          ),
          onPressed: () {},
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
        bottom: PreferredSize(
          child: Text(
            "ROOM SERVICE",
            style: TextStyle(
              color: Color(0xFFC9C8C8),
              fontSize: 14,
            ),
          ),
          preferredSize: Size.fromHeight(14),
        ),
      ),
      body: body(),
    );
  }

  Widget body() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(
              left: 20,
              top: 32,
            ),
            child: Text(
              "Popular Facilities",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          Container(
            height: 100,
            child: AnimatedList(
              padding: EdgeInsets.all(20),
              scrollDirection: Axis.horizontal,
              key: horizontalListKey,
              initialItemCount: horizontalListCounter,
              itemBuilder: (context, index, animation) {
                return slidefromRightToLeft(context, index, animation);
              },
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              "All Services",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          AnimatedList(
            padding: EdgeInsets.all(20),
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            key: gridListKey,
            initialItemCount: gridListCounter,
            itemBuilder: (context, index, animation) {
              return slidefromBottomToTop(context, index, animation);
            },
          ),
        ],
      ),
    );
  }

  Widget slidefromBottomToTop(BuildContext context, int index, animation) {
    return SlideTransition(
      position: CurvedAnimation(
        curve: Curves.easeOut,
        parent: animation,
      ).drive((Tween<Offset>(
        begin: Offset(0, 1),
        end: Offset(0, 0),
      ))),
      child: Container(
        height: 120,
        child: Row(
          children: [
            Expanded(child: gridItemView(index)),
            SizedBox(
              width: 20,
            ),
            Expanded(child: gridItemView(index + 5)),
          ],
        ),
      ),
    );
  }

  Widget gridItemView(int item) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                DetailWidget(
              item: item,
            ),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return child;
            },
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(
          bottom: 20,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              blurRadius: 7,
              color: Color(0xffeeeeee),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              item == 0
                  ? Icons.smartphone
                  : item == 5
                      ? Icons.lunch_dining
                      : item == 0
                          ? Icons.person
                          : item == 6
                              ? Icons.local_laundry_service
                              : item == 2
                                  ? Icons.carpenter
                                  : item == 7
                                      ? Icons.wifi
                                      : item == 3
                                          ? Icons.lightbulb
                                          : Icons.thermostat_rounded,
              size: 28,
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              item == 0
                  ? 'Smartphone'
                  : item == 5
                      ? "Order Meal"
                      : item == 1
                          ? "Personal Assistance"
                          : item == 6
                              ? "Laundry"
                              : item == 2
                                  ? "Carpenter"
                                  : item == 7
                                      ? "Wi-fi"
                                      : item == 3
                                          ? "Light"
                                          : "Temperature",
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget slidefromRightToLeft(BuildContext context, int index, animation) {
    return SlideTransition(
      position: CurvedAnimation(
        curve: Curves.easeInOut,
        parent: animation,
      ).drive((Tween<Offset>(
        begin: Offset(1, 0),
        end: Offset(0, 0),
      ))),
      child: horizontalItemView(index),
    );
  }

  Widget horizontalItemView(int item) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
      ),
      margin: EdgeInsets.only(
        right: item == 0 ? 20 : 0,
      ),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(
            item == 0 ? Icons.spa : Icons.lunch_dining,
            color: Colors.white,
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            item == 0 ? "Get a Massage" : "Order a Meal",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }
}
