import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'main.dart';

class FirstSwipe extends StatefulWidget {
  const FirstSwipe({super.key});

  @override
  State<FirstSwipe> createState() => _FirstSwipeState();
}

class _FirstSwipeState extends State<FirstSwipe> {

  var controller;
  //MyHomePage(title: 'FoodWay');
  Color textColor = Colors.white;
  Color bgClor =Colors.red;

  @override
  void initState() {
    controller = PageController(
      viewportFraction: 0.8,
    );
    super.initState();
  }

  void pageChanged(int page){
    switch(page){
      case 0:
        setState(() {
          textColor = Colors.white;
          bgClor =  Colors.red;//Colors.red;
        });
        break;
      case 1:
        setState(() {
           bgClor = Colors.white;
          textColor = Colors.black;
        });
        break;
      case 2:
        setState(() {
          textColor = Colors.white;
          bgClor =  Colors.red;//
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // scaffold
      home: Scaffold(
        body:
        Container(
          color: bgClor,
          child: Column(
            children: [
              const SizedBox(height: 50,),
              Text('Why choose us?', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: textColor),),
              const SizedBox(height: 20,),
              Expanded(
                child:  PageView(
                 // scrollDirection: Axis.vertical,
                  onPageChanged: (page){
                    pageChanged(page);
                  },
                  physics: const BouncingScrollPhysics(),
                  controller:controller,
                  children: [
                    fast(),
                    easy(),
                    delivery(),
                  ],
                ),
              ),

              Container(
                height: 40,
                margin: EdgeInsets.all(10),
                alignment: Alignment.center,
                child: SmoothPageIndicator(
                  controller: controller,
                  count:  3,
                  effect:  ExpandingDotsEffect(
                    activeDotColor: textColor,
                      strokeWidth: 1,
                      dotHeight: 10
                  ),

                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget fast(){
    return Column(
      children: [
        Expanded(child: Image.asset('assets/fast.png', fit: BoxFit.fitWidth,).animate().shakeX()),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Fast and reliable', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white),),
            Text('We deliver your orders fast and reliably', textAlign: TextAlign.center, style: TextStyle(fontSize: 20, color: Colors.white ),),
          ],
        ),
        const SizedBox(height: 20,)
      ],
    );
  }
  Widget easy(){
    return Column(
      children: [

        Expanded(child: Image.asset('assets/easy.png',  width: 200, height: 200, fit: BoxFit.fitWidth,).animate().fadeIn()),
         Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Easy ordering', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.black),),
            Text('Order and pay at your convenience', textAlign: TextAlign.center, style: TextStyle(fontSize: 20, color: Colors.black),),
          ],
        ),
        const SizedBox(height: 20,)
      ],
    );
  }
  Widget delivery(){
    return Column(
      children: [

        Expanded(child: Center(child: Image.asset('assets/delivery.png', width: 200, height: 200, fit: BoxFit.fitWidth,))).animate().flipV(),
         Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Free Delivery', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white),),
            Text('Free delivery for all your orders!', textAlign: TextAlign.center, style: TextStyle(fontSize: 20, color: Colors.white),),

            InkWell(
              onTap: ()  {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
                    MyHomePage(title: 'FoodWay',)
                ));
              },
              child: kIsWeb ? Container(
                width: double.infinity,
                height: 60,
                margin: EdgeInsets.all(20),
                alignment: Alignment.center,
                decoration:const ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25),)
                  ),

                ),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Continue', style: TextStyle( color: Colors.red, fontWeight: FontWeight.bold),),
                      Icon(Icons.arrow_right_alt_outlined, size: 30, color: Colors.red,),
                    ].animate(interval: 1000.milliseconds).shakeX(duration: 500.milliseconds, delay: 2000.milliseconds),
                  ),
                ),
              )
                  : Container(
                width: double.infinity,
                height: 60,
                margin: EdgeInsets.all(20),
                alignment: Alignment.center,
                decoration:const ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25),)
                  ),

                ),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Proceed', style: TextStyle( color: Colors.black, fontWeight: FontWeight.bold),),
                      Icon(Icons.arrow_right_alt_outlined, size: 30, color: Colors.black,),
                    ].animate(interval: 1000.milliseconds).shakeX(duration: 500.milliseconds, delay: 2000.milliseconds),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20,)
      ],
    );
  }

}