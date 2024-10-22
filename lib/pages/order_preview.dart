import 'dart:math';

import 'package:flutter/material.dart';

class OrderPreview extends StatefulWidget {
  final  recipientName, recipientPhone, recipientEmail, recipientAddress, recipientOtherInfo, orderTime,
      orderStatus, orderNames, orderQuantities,  orderAmounts;
  const OrderPreview({super.key, required this.recipientName, required this.recipientPhone, required this.recipientEmail, required this.recipientAddress, required this.recipientOtherInfo, required this.orderTime, required this.orderStatus, required this.orderNames, required this.orderQuantities, required this.orderAmounts});

  @override
  State<OrderPreview> createState() => _OrderPreviewState();
}

class _OrderPreviewState extends State<OrderPreview> {
  late List<dynamic> nameList, amountList, quantityList;

  RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
  String Function(Match) mathAFunction = (Match match) => '${match[1]},';

  @override
  void initState() {
    // TODO: implement initState
    nameList  = widget.orderNames;
    amountList  = widget.orderAmounts;
    quantityList  = widget.orderQuantities;
    print(nameList);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order details'),
        backgroundColor: Colors.red,
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Recipient name:'),
                  Text(widget.recipientName, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                  const SizedBox(height: 10,),
                  const Text('Recipient address:'),
                  Text(widget.recipientAddress, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                  const SizedBox(height: 10,),
                  const Text('Recipient phone number:'),
                  Text(widget.recipientPhone, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                  const SizedBox(height: 10,),
                  const Text('Recipient email address:'),
                  Text(widget.recipientEmail, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                  const SizedBox(height: 10,),
                  const Text('Recipient other description:'),
                  Text(widget.recipientOtherInfo, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                  const SizedBox(height: 10,),
                  RichText(

                    text: TextSpan(
                        style: TextStyle(color: Colors.black, fontSize: 20),
                        children: [
                          TextSpan(text: 'Status: '),
                          TextSpan(
                              text: widget.orderStatus,
                              style: TextStyle(
                                  color: widget.orderStatus == 'delivered'
                                      ? Colors.green : Colors.red, fontWeight: FontWeight.bold)
                          )
                        ]
                    ),

                  ),
                  const SizedBox(height: 20,),
                  Container(height: 1, color: Colors.red,),
                  const SizedBox(height: 20,),
                  const Row(
                   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Quantity', style: TextStyle(fontWeight: FontWeight.bold)),
                      Expanded(child: Text('       Item name', style: TextStyle(fontWeight: FontWeight.bold))),
                      Text('Amount', style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ), const SizedBox(height: 20,),
                  Container(height: 1, color: Colors.red,),
                  const SizedBox(height: 20,),
                ],
              ),
            ),

            Expanded(
              child: ListView.builder(
                  itemCount:  nameList.length,
                  itemBuilder: (context, index){
                    return ListTile(
                      leading: Text('${quantityList[index]}'),
                      title: Text('${nameList[index]} '),
                      trailing: Text('NGN ${amountList[index].toString().replaceAllMapped(reg, mathAFunction)} '),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
