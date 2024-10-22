import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peachypastries/pages/about_us.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../pages/special_order.dart';
import '../pages/orders_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            //
            // UserAccountsDrawerHeader(
            //   accountName: Text('FoodWay', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white,
            //       shadows: [
            //         Shadow(color: Colors.black, blurRadius: 5)
            //       ]),),
            //   accountEmail: Text('HOME OF DELICIOUSNESS', style: TextStyle( color: Colors.white, shadows: [
            //     Shadow(color: Colors.black, blurRadius: 5)
            //   ]),),
            //   currentAccountPicture: Image.asset('assets/peachy_round.png',),
            //
            //   decoration: const BoxDecoration(
            //       color: Colors.black,
            //       //
            //       // image: DecorationImage(
            //       //   image: AssetImage('assets/images.jpeg-8.jpg',),
            //       //   fit: BoxFit.fitHeight,
            //       // )
            //   ),
            // ),
            const SizedBox(height: 20,),
            ClipRRect(

                borderRadius: BorderRadius.circular(50),
                child: Image.asset('assets/foodway.png',width: 100,)),
            TextButton(
                onPressed: (){
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>
                      AboutUs()
                  ));
                },
                child: const Text('About us')),
            Container(
              width: double.infinity,
              child: ListTile(
                onTap: (){
                  Navigator.pop(context);
                },
                leading: Icon(Icons.home, color: Colors.white,),
                title: const Text('Home', style: TextStyle(color: Colors.white),),
              ),
              margin: EdgeInsets.only(left: 40, right: 40, top: 50),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),

                  color: Colors.red,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade500,
                      blurRadius: 15,
                      offset: const Offset(4,4),
                    ),
                    BoxShadow(
                      color:  Colors.white,
                      blurRadius: 15,
                      offset: const Offset(-4,-4),
                    ),
                  ]
              ),
            ),
            //ORDERS
            Container(
              width: double.infinity,
              child: ListTile(
                onTap: (){
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>
                      MyOrders()
                  ));

                },
                leading: Icon(CupertinoIcons.gift, color: Colors.black,),
                title: const Text('My orders'),
                trailing: Icon(Icons.circle, color: Colors.green, size: 10,),
              ),
              margin: EdgeInsets.only(left: 40, right: 40, top: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.red,
                ),
              ),
            ),
            //favorite
            Container(
              width: double.infinity,
              child: ListTile(
                onTap: (){
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>
                      SpecialOrder()
                  ));
                },
                leading: Icon(CupertinoIcons.gift_fill, color: Colors.black,),
                title: const Text('Special Order'),
              ),
              margin: EdgeInsets.only(left: 40, right: 40, top: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.red,
                ),
              ),
            ),
            //REPORT
            Container(
              width: double.infinity,
              child: ListTile(
                onTap: () async {
                  String uri = "https://wa.me/+2348104778082";
                  //var urr_launchable = await //;
                  if(await canLaunchUrl(Uri.parse(uri))){
                    await launch(uri);
                  }
                },
                leading: Icon(Icons.support_agent, color: Colors.black,),
                title: const Text('Support'),
              ),
              margin: EdgeInsets.only(left: 40, right: 40, top: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.red,
                ),
              ),
            ),
            //share
            Container(
              width: double.infinity,
              child: ListTile(
                onTap: () async {
                  Share.share('Order your Parfaits, Smoothies, small chops, Cakes and many more on FoodWay https://foodway.web.app', subject: 'Share FoodWay');
                Navigator.pop(context);
                  },
                leading: Icon(Icons.share, color: Colors.black,),
                title: const Text('Share'),
              ),
              margin: EdgeInsets.only(left: 40, right: 40, top: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.red,
                ),
              ),
            ),
            Expanded(child: Container()),
            InkWell(
              onTap: () async {
                String uri = "https://instagram.com/ulonet.technology";
                //var urr_launchable = await //;
                if(await canLaunchUrl(Uri.parse(uri))){
                  await launch(uri);
                }
              },
              child: Container(
                margin: EdgeInsets.all(20),
                  child: const Text('Made by Ulonet Technology', style: TextStyle( fontSize: 12),)),
            )
          ],
        ),
      ),
    );
  }
}
