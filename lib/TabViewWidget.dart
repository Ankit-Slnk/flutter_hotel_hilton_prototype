import 'package:flutter/material.dart';
import 'package:testing/home.dart';

class TabViewWidget extends StatefulWidget {
  @override
  _TabViewWidgetState createState() => _TabViewWidgetState();
}

class _TabViewWidgetState extends State<TabViewWidget> {
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  int listCounter = 0;
  List<int> qtyList = [0, 0, 0, 0];

  @override
  void initState() {
    _loadVerticalItems();
    super.initState();
  }

  Future<void> _loadVerticalItems() async {
    for (int i = 1; i <= 4; i++) {
      await Future.delayed(Duration(milliseconds: 200));
      listCounter++;
      listKey.currentState.insertItem(listCounter - 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: AnimatedList(
            padding: EdgeInsets.all(20),
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            key: listKey,
            initialItemCount: listCounter,
            itemBuilder: (context, index, animation) {
              return slidefromBottomToTop(context, index, animation);
            },
          ),
        ),
        AnimatedOpacity(
          opacity: qtyList.where((element) => element == 0).toList().length == 4
              ? 0
              : 1,
          curve: Curves.easeOutSine,
          duration: Duration(milliseconds: 500),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () async {
                  showGeneralDialog(
                    barrierColor: Colors.black.withOpacity(0.5),
                    transitionBuilder: (context, a1, a2, widget) {
                      return Transform.scale(
                        scale: a1.value,
                        child: Opacity(
                          opacity: a1.value,
                          child: AlertDialog(
                            title: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                  size: 50,
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text('Order Received'),
                              ],
                            ),
                            content: Text(
                              'Your order number A1234 will be delivered to your room in next 30 minutes.',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      );
                    },
                    transitionDuration: Duration(milliseconds: 200),
                    barrierDismissible: false,
                    barrierLabel: '',
                    context: context,
                    pageBuilder: (context, animation1, animation2) {},
                  );

                  await Future.delayed(Duration(milliseconds: 1500));

                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return HomeScreen();
                    }),
                    (route) => false,
                  );
                },
                child: Container(
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    "Order",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget slidefromBottomToTop(BuildContext context, int index, animation) {
    return SlideTransition(
      position: CurvedAnimation(
        curve: Curves.easeOut,
        parent: animation,
      ).drive((Tween<Offset>(
        begin: Offset(1, 1),
        end: Offset(0, 0),
      ))),
      child: Container(
        height: 120,
        child: gridItemView(index),
      ),
    );
  }

  Widget gridItemView(int item) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 20,
      ),
      child: Row(
        children: [
          Container(
            height: 100,
            width: 100,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Row(
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                        ),
                        Container(
                          height: 50,
                          width: 50,
                          color: Color(0xffFCD13E),
                        ),
                      ],
                    ),
                  ],
                ),
                Image.asset(
                  "assets/pizza.png",
                  height: 70,
                  width: 70,
                ),
              ],
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'BBQ Pizza',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 12,
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  if (qtyList[item] > 0) {
                    if (mounted)
                      setState(() {
                        qtyList[item]--;
                      });
                  }
                },
                child: Container(
                  color: Colors.transparent,
                  alignment: Alignment.center,
                  child: Text(
                    "-",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  qtyList[item].toString(),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                width: 8,
              ),
              GestureDetector(
                onTap: () {
                  if (qtyList[item] < 5) {
                    if (mounted)
                      setState(() {
                        qtyList[item]++;
                      });
                  }
                },
                child: Container(
                  color: Colors.transparent,
                  alignment: Alignment.center,
                  child: Text(
                    "+",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
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
}
