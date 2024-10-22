import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hive/hive.dart';

import '../provider/cart_provider.dart';
import 'cart.dart';

class ItemPreview extends StatefulWidget {
  final image, name, description, amount, initialAmouunt;
  const ItemPreview({super.key, required this.image,required this.name,required this.description,required this.amount, required this.initialAmouunt});

  @override
  State<ItemPreview> createState() => _ItemPreviewState();
}

class _ItemPreviewState extends State<ItemPreview> with SingleTickerProviderStateMixin{

  RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
  String Function(Match) mathAFunction = (Match match) => '${match[1]},';

  //hive
  var box =  Hive.box<CartProvider>('cart_db');
  int counter= 0;
  bool addedToCart = false;
  late double amount, initialAmount;
  late int quantity;
  bool isLiked = false;
  @override
  void initState() {
    // TODO: implement initState
    runCounterCheck();
    checkIfAddeToCart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: AnimatedBackground(

        vsync: this,
        behaviour: RandomParticleBehaviour(
            options: ParticleOptions(
              //image:   Image.asset('assets/cake.png', width: 40,),
                baseColor:Colors.red,
                particleCount: 10,
                spawnMaxSpeed: 100,
                spawnMinSpeed: 50
            )
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //picture
                  Expanded(child: Center(
                    child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        child: Image.asset(widget.image)),
                  )),
                  const SizedBox(height: 10,),
                  //price
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(

                          margin: EdgeInsets.only(left: 20),
                          child: Text('NGN ${amount.toString().replaceAllMapped(reg, mathAFunction)}', style: TextStyle(color: Colors.green, fontSize: 40, fontWeight: FontWeight.bold),)),
                      IconButton(
                          onPressed: (){
                            setState(() {
                              isLiked = !isLiked;
                            });
                          },
                          icon: Icon( isLiked
                              ?Icons.favorite
                              :Icons.favorite_border
                            , color: Colors.red,))
                    ],
                  ),
                  //name
                  Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Text(widget.name, style: TextStyle(fontSize: 30),)),
                  //DESCc
                  const SizedBox(height: 20,),
                  Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Text('Description',)),
                  Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Text(widget.description, style: TextStyle(fontSize: 20),)),

                  //bottom
                  Container(
                    margin: EdgeInsets.all(20),
                    child: Row(
                      children: [
                        //plus minus
                        Expanded(
                          child:
                          Container(
                            margin: EdgeInsets.all( 5),
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            decoration:const ShapeDecoration(shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(25),)
                            ),
                                color: Colors.black
                            ),
                            child: Row(

                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                //decrement
                                IconButton(
                                    onPressed: (){
                                      if(quantity == 1)return;
                                      var cartItem = CartProvider(widget.name,
                                          'itemType',
                                          amount - initialAmount, widget.description, widget.image,
                                          quantity - 1, true, widget.initialAmouunt);
                                      box.put(widget.name, cartItem);
                                      checkIfAddeToCart();
                                    },
                                    icon: Icon(Icons.remove_circle,color: Colors.white, )),
                                Text('${quantity}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white, ),),
                                //increment
                                IconButton(
                                    onPressed: (){
                                      //add up
                                      var cartItem = CartProvider(widget.name,
                                          'itemType',
                                          amount + initialAmount, widget.description, widget.image,
                                          quantity + 1, true, widget.initialAmouunt);
                                      box.put(widget.name, cartItem);

                                      checkIfAddeToCart();
                                    },
                                    icon: Icon(Icons.add_circle, color: Colors.white,)),
                              ],
                            ),
                          ),),
                        //ad cart
                        InkWell(
                          onTap: (){
                            addedToCart = box.get(widget.name) != null;
                            if(addedToCart){
                              box.delete(widget.name);
                              checkIfAddeToCart();

                            }
                            else{
                              var cartItem = CartProvider(widget.name,
                                  'itemType',
                                  amount, widget.description, widget.image,
                                  1, true, widget.amount);
                              box.put(widget.name, cartItem);
                            }
                            runCounterCheck();
                            checkIfAddeToCart();
                          },
                          child:
                          addedToCart
                              ? Container(
                            margin: EdgeInsets.all( 5),
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black,),
                                borderRadius: BorderRadius.all(Radius.circular(25))

                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.remove_shopping_cart, color: Colors.black,),
                                const Text('Remove', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),),
                              ],
                            ),
                          )
                              :Container(
                            margin: EdgeInsets.all( 5),
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                            decoration:const ShapeDecoration(shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(25),)
                            ),
                                color: Colors.black
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.add_shopping_cart_sharp, color: Colors.white,),
                                const Text('Add', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),),
                              ],
                            ),
                          ),
                        ),

                      ],
                    ),
                  )
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  backButton(),
                  Container(
                    margin: EdgeInsets.only(right: 20),
                    child:  IconButton(onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>
                          Cart()
                      )).then((value) {
                        runCounterCheck();
                        checkIfAddeToCart();
                      });
                    },
                        icon: Badge(
                            label: counter == 0 ? null
                                :Container(
                                padding: EdgeInsets.all(1),
                                decoration: new BoxDecoration(
                                  //color: Colors.blue,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                constraints: BoxConstraints(
                                  minWidth: 12,
                                  minHeight: 12,
                                ),
                                child: Text('$counter', style: TextStyle(color: Colors.white),)),
                            child:Icon(Icons.shopping_cart_outlined, size: 30, ) ),
                        tooltip: 'Cart'
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget backButton(){
    return
      Container(
        margin: EdgeInsets.only(left: 20, top: 10),
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

  void runCounterCheck() {

    counter = box.length;
    setState(() {

    });
  }

  void checkIfAddeToCart() {
    addedToCart = box.get(widget.name) != null;

    amount = widget.initialAmouunt;
    quantity = 1;

    if(addedToCart){
      amount = box.get(widget.name)!.amount;
      initialAmount = box.get(widget.name)!.initialAmount;
      quantity = box.get(widget.name)!.quantity;
    }
    setState(() {

    });
  }
}
