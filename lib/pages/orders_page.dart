import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:peachypastries/model/order.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'order_preview.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({super.key});

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  String email = '';
  List<Orders> orderlist = <Orders>[];
  bool loading = true;

  @override
  void initState() {
    // TODO: implement initState  add items to list
    getUserData();

    super.initState();
  }
  Future<void> getUserData() async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    email =  prefs.getString('email') ?? '';

    orderlist = getListOfMyOrders();

  }

   List<Orders> getListOfMyOrders() {
    List<Orders> lists = <Orders>[];
    FirebaseFirestore.instance.collection("order").snapshots().listen((event) {

      event.docs.forEach((element) {
        if(element.data()['recipientEmail'] == email){
          orderlist.add(
              Orders(
                  recipientName: element.data()['recipientName'],
                  recipientPhone: element.data()['recipientPhone'],
                  recipientEmail:element.data() ['recipientEmail'],
                  recipientAddress: element.data()['recipientAddress'],
                  recipientOtherInfo:element.data() ['recipientOtherInfo'],
                  orderTime: element.data()['orderTime'],
                  orderStatus: element.data()['orderStatus'],
                  orderNames: element.data()['orderNames'],
                  orderQuantities: element.data()['orderQuantities'],
                  orderAmounts: element.data()['orderAmounts']));
        }
          setState(() {
            loading = false;
          });
      });
    });

    return lists;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 50,),
          Row(
            children: [
              backButton(),
              Container(
                  margin: EdgeInsets.only(left: 20),
                  child: Text('My Orders', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),))
            ],
          ),
          Expanded(
              child: loading ? Center(child: CircularProgressIndicator(strokeWidth: 10,),)
              : orderlist.length == 0
              ?Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(CupertinoIcons.gift_alt, size: 50,),
                  const Text('No orders sent yet!'),
                  TextButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      child: const Text('Go to shop'))
                ],
              )
              :ListView.builder(
                itemCount: orderlist.length,
                  itemBuilder: (context, index){
                  DateTime date = DateTime.fromMicrosecondsSinceEpoch(orderlist[index].orderTime * 1000);
                  String time = DateFormat.yMMMMEEEEd().format(date).toString();
                  String orderStatus = orderlist[index].orderStatus;
                   String recipientName =  orderlist[index].recipientName;
                   String recipientPhone =  orderlist[index].recipientPhone;
                   String recipientEmail =  orderlist[index].recipientEmail;
                   String recipientAddress =  orderlist[index].recipientAddress;
                   String recipientOtherInfo =  orderlist[index].recipientOtherInfo;
                   dynamic orderNames =  orderlist[index].orderNames;
                   dynamic orderQuantities =  orderlist[index].orderQuantities;
                   dynamic orderAmounts =  orderlist[index].orderAmounts;

                    return ListTile(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>
                            OrderPreview(recipientName: recipientName, recipientPhone: recipientPhone, recipientEmail: recipientEmail, recipientAddress: recipientAddress, recipientOtherInfo: recipientOtherInfo, orderTime: time, orderStatus: orderStatus, orderNames: orderNames, orderQuantities: orderQuantities, orderAmounts: orderAmounts)
                        ));
                      },
                      leading: Icon(CupertinoIcons.gift),
                      title: RichText(
                        text: TextSpan(
                          style: TextStyle(color: Colors.black),
                            children: [
                              TextSpan(text: 'Order at $time '),
                              TextSpan(
                                  text: '[TAP TO VIEW]',
                                  style: TextStyle(fontWeight: FontWeight.bold)
                              )
                            ]
                        ),

                      ),
                      subtitle: RichText(

                        text: TextSpan(
                            style: TextStyle(color: Colors.black),
                          children: [
                            TextSpan(text: 'Status: '),
                            TextSpan(
                                text: orderStatus,
                              style: TextStyle(
                                  color: orderStatus == 'delivered'
                              ? Colors.green : Colors.red)
                            )
                          ]
                        ),

                      ),
                    );
                  }
              ))
        ],
      ),
    );
  }

  Widget backButton(){
    return
      Container(
        margin: EdgeInsets.only(left: 20),
        decoration: ShapeDecoration(
            color: Colors.black,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15)
            )
        ),
        child: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Icon(Icons.close, color: Colors.white,)),
      );
  }
  // String formatTimestamp(int timestamp) {
  //   var now = DateTime.now();
  //   var format = DateFormat('HH:mm a'); // Customize the format as needed
  //   var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000); // Convert seconds to milliseconds
  //   var diff = now.difference(date);
  //
  //   if (diff.inSeconds <= 0 ||
  //       diff.inSeconds > 0 && diff.inMinutes == 0 ||
  //       diff.inMinutes > 0 && diff.inHours == 0 ||
  //       diff.inHours > 0 && diff.inDays == 0) {
  //     return format.format(date);
  //   } else {
  //     return '${diff.inDays} DAYS AGO';
  //   }
  // }
}
