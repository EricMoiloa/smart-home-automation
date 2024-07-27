import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smartlife/pages/nav%20pages/kitchen_page.dart';
import 'package:smartlife/pages/nav%20pages/outdoor_lights.dart';

import '../../utils/dimensions.dart';
import '../screens/living_room.dart';

class AutomationPage extends StatefulWidget {
  const AutomationPage({super.key});

  @override
  State<AutomationPage> createState() => _AutomationPageState();
}

class _AutomationPageState extends State<AutomationPage>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 2, vsync: this);
    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 243, 243, 1),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(
                Iconsax.textalign_left,
                color: Colors.black87,
              ),
              onPressed: () {},
            ),
            Container(
              // margin: EdgeInsets.only(right: 100),
              width: 50.0,
              height: 50.0,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/1.jpg"),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey.withOpacity(0.5)),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(Dimensions.radius30))),
              padding: EdgeInsets.all(Dimensions.width20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: Dimensions.width20),
                    child: Text("Welcome"),
                  ),
                  SizedBox(
                    height: Dimensions.height20,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            //Tab Bar
            Container(
              child: Align(
                alignment: Alignment.centerLeft,
                child: TabBar(
                    labelPadding: const EdgeInsets.only(left: 20, right: 0),
                    controller: _tabController,
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    isScrollable: true,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicator:
                        CircleTabIndicator(color: Colors.black26, radius: 4.0),
                    tabs: [
                      Tab(
                        text: "Living Room",
                      ),
                      Tab(text: "Kitchen"),
                    ]),
              ),
            ),
            SizedBox(
              height: 15,
            ),

            Container(
              padding: const EdgeInsets.only(left: 20.0),
              height: double.maxFinite,
              width: double.maxFinite,
              child: TabBarView(controller: _tabController, children: [
                LivingroomScreen(),
                kitchenScreen(),
              ]),
            )
          ],
        ),
      ),
    );
  }
}

class CircleTabIndicator extends Decoration {
  final Color color;
  double radius;

  CircleTabIndicator({required this.color, required this.radius});

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    // TODO: implement createBoxPainter
    return _circlePainter(color: color, radius: radius);
  }
}

class _circlePainter extends BoxPainter {
  final Color color;
  double radius;

  _circlePainter({required this.color, required this.radius});

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    // TODO: implement paint
    Paint _paint = Paint();
    _paint.color = color;
    _paint.isAntiAlias;
    final Offset circleOffset = Offset(
        configuration.size!.width / 2 - radius / 2,
        configuration.size!.height - radius);
    canvas.drawCircle(offset + circleOffset, radius, _paint);
  }
}
