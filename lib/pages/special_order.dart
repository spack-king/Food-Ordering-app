import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../methods/post_method.dart';
import '../utilities/alerts.dart';

class SpecialOrder extends StatefulWidget {
  const SpecialOrder({super.key});

  @override
  State<SpecialOrder> createState() => _SpecialOrderState();
}

class _SpecialOrderState extends State<SpecialOrder> {
 // List<Orders> orderlist = <Orders>[];
  TextEditingController descEditingController = TextEditingController();
  TextEditingController phoneEditingController = TextEditingController();
  TextEditingController budgetEditingController = TextEditingController();
  bool isLoading = false;
  String errorText = '';

  @override
  void dispose() {
    // TODO: implement dispose
    descEditingController.dispose();
    phoneEditingController.dispose();
    budgetEditingController.dispose();
    super.dispose();
  }

  sendOrder() async {
    setState(() {
      errorText = '';
    });
    if(descEditingController.text.trim().isEmpty || descEditingController.text.length < 15){
      setState(() {
        errorText = 'Please describe what you want in details!';
      });
    }else if(budgetEditingController.text.trim().isEmpty){
      setState(() {
        errorText = 'Please enter your budget!';
      });
    }else if(phoneEditingController.text.trim().isEmpty){
      setState(() {
        errorText = 'Please enter your phone number!';
      });
    }else if(isLoading){
      return;
    }else{
      setState(() {
        isLoading = true;
      });
      String res = await FirestoreMethods().sendSpecialOrder(
          recipientOrder: descEditingController.text,
          recipientPhone: phoneEditingController.text,
          budget: int.parse(budgetEditingController.text)
      );
      if (res == 'Order sent successfully!'){
        showSpackSnackBar('Your order has been sent successfully!',  context, Colors.green, Icons.done);
        Navigator.pop(context);
      }
    }
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
                  child: Text('Special Order', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),))
            ],
          ),
          const SizedBox(height: 5,),
          isLoading ? LinearProgressIndicator() : Container(),
          const SizedBox(height: 10,),
          Expanded(
            child:
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: TextField(
                enabled: !isLoading,
                  controller: descEditingController,
                  //minLines: double,
                  maxLines: null,
                  minLines: null,
                  expands: true,
                  textCapitalization: TextCapitalization.sentences,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(

                      labelText: 'Describe what you want',
                      hintText: 'Tell us what you want. ',
                      helperText: 'Example: I want a double layer carrot cake with no icing',

                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      prefixIcon: Icon(Icons.description)
                  )
              ),
            ),
          ),
          const SizedBox(height: 20,),
          //budget
          Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            child: TextField(
                enabled: !isLoading,
                controller: budgetEditingController,
                textCapitalization: TextCapitalization.sentences,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: 'Enter your budget',
                    hintText: 'Enter your budget',

                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    prefixIcon: Icon(Icons.monetization_on)
                )
            ),
          ),
          const SizedBox(height: 10,),
          //phone
          Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            child: TextField(
                enabled: !isLoading,
                controller: phoneEditingController,
                textCapitalization: TextCapitalization.sentences,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(

                    labelText: 'Enter your phone number',
                    hintText: 'Enter your phone number',

                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    prefixIcon: Icon(Icons.phone)
                )
            ),
          ),
          //error widget

          Visibility(
              visible: errorText.isNotEmpty,
              child: Container(
                  margin: EdgeInsets.only(left: 20, bottom: 10),
                  child: Row(
                    children: [
                      Icon(Icons.error_outline, color: Colors.red,),
                      Text(errorText, style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),),
                    ],
                  ))
          ),

        ],
      ),
      bottomNavigationBar:
      InkWell(

          onTap: sendOrder,
          child: Container(
            width: double.infinity,
            height: 60,
            margin: EdgeInsets.all(20),
            alignment: Alignment.center,
            decoration:const ShapeDecoration(
              color: Colors.red,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25),)
              ),

            ),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: isLoading ? CircularProgressIndicator(color: Colors.white,) : Text('SEND ORDER', style: TextStyle( color: Colors.white, fontWeight: FontWeight.bold),),
            ),
          )
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
}
