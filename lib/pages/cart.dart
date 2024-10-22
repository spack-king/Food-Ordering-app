import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hive/hive.dart';
import 'package:peachypastries/model/product_model.dart';
import 'package:peachypastries/pages/item_preview.dart';
import 'package:peachypastries/provider/cart_provider.dart';

import '../service/api.dart';
import 'checkout_page.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  TextEditingController controller = TextEditingController();
 var box =  Hive.box<CartProvider>('cart_db');


  RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
  String Function(Match) mathAFunction = (Match match) => '${match[1]},';

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
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
                  child: Text('My Cart', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),))
            ],
          ),

          Expanded(
              child: box.length == 0
              ?Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(CupertinoIcons.shopping_cart, size: 50,).animate().slideX(delay: 1000.milliseconds),
                  const Text('Your cart is empty at the moment'),
                  TextButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      child: Text('Add item to cart'))
                ],
              )
              :ListView.builder(
                  itemCount: box.length,
                  itemBuilder: (BuildContext context, int index){

                    var item = box.getAt(index);
                    String name= item!.ItemName;
                    String picture = item!.picture;
                    String description = item!.description;
                    double amount = item!.amount;
                    double initialAmount = item!.initialAmount;
                    int quantity= item!.quantity;
                    String  ItemType= item!.ItemType;

                    return Dismissible(
                      key: Key(name),
                      background: Container(padding:EdgeInsets.only(left: 20), color: Colors.red, child: (Row(children: [Icon(CupertinoIcons.delete)],)),),
                     
                      direction: DismissDirection.startToEnd,
                      onDismissed: (direction) {
                        //DismissDirection.startToEnd
                        deleteItem(index);
                        setState(() {

                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 10, right: 10, bottom: 15),
                        child: InkWell(
                          onTap: () async {
                            Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                ItemPreview(image: picture, name: name, description: description, amount: amount, initialAmouunt: initialAmount,)
                            )).then((value) {
                              setState(() {

                              });
                            });
                          },
                          child: Row(
                            children: [
                               Image.asset(picture, width: 70,),
                               Expanded(child: Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [

                                   Text(name, style: TextStyle(fontWeight: FontWeight.bold),),
                                   Text('NGN ${amount.toString().replaceAllMapped(reg, mathAFunction)}', style: TextStyle(fontSize: 18, color: Colors.green, fontWeight: FontWeight.bold),),
                                 ],
                               )),

                               //add or subtract
                               Row(
                                children: [
                                  //decrement
                                  IconButton(
                                      onPressed: (){
                                        if(quantity == 1)return;
                                        var value = CartProvider(name, ItemType, amount - initialAmount, description, picture, quantity -1, true, initialAmount);
                                        box.putAt(index, value);
                                        setState(() {

                                        });
                                      },
                                      icon: Icon(Icons.remove_circle, )),
                                  Text('${quantity}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, ),),
                                  //increment
                                  IconButton(
                                      onPressed: (){
                                        //add up
                                        var value = CartProvider(name, ItemType, amount + initialAmount, description, picture, quantity +1, true,initialAmount );
                                        box.putAt(index, value);
                                        setState(() {

                                        });
                                      },
                                      icon: Icon(Icons.add_circle, )),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
              )
          ),
          Visibility(
            visible: box.length > 0,
              child:
              InkWell(
                onTap: (){
                  proceedToCheckOut();
                },
                child: Container(
                  margin: EdgeInsets.all( 20),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  decoration:const ShapeDecoration(shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20),)
                  ),
                      color: Colors.black
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Proceed to checkout', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),),
                      Icon(Icons.shopping_cart_checkout, color: Colors.white,),
                    ],
                  ),
                ),
              ),
          )
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
            icon: Icon(Icons.arrow_back_outlined, color: Colors.white,)),
      );
  }

  void deleteItem(int index) {
    box.deleteAt(index);
  }

  void proceedToCheckOut() {

    Navigator.push(context, MaterialPageRoute(builder: (context) =>
      CheckOutPage()
    )).then((value) {
      setState(() {

      });
    });
  }
}
