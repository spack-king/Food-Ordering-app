import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  String data = 'Welcome to FoodWay! \n Our services are as follows:\n 1. Celebration cake(Birthday cakes, Wedding cakes, Engagement cakes, House warming'
      'Bridal shower, Graduation cakes and lots more./n 2. We have a varieties of cakes such as Vanilla cake, Strawberry cake, Lemon cake, Fruit cake, Carrot cake,'
      ' Chocolate cake, Red velvet cake and many more. We sell naked cakes as well\n 3. We do surprise packages for all celebration\n 4. Snacks\n 5. Yogurt Parfait/'
      'Cake parfait\n 6. Food Tray \n 7. Small chops\n we can serve you better.';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text('About us'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
            child: Column(
              children: [

                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                    child: Image.asset('assets/foodway.png',width: 200,)),
                Container(
                  margin: EdgeInsets.only(top: 20),
                    child: Text(data, style: TextStyle(fontSize: 30),))
              ].animate(interval: 1000.ms).slideY(begin: 1, duration: 1000.ms),
            )),
      ),
    );
  }
}
