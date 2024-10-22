import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:peachypastries/methods/post_method.dart';
import 'package:peachypastries/service/payment_integration.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../provider/cart_provider.dart';
import '../utilities/alerts.dart';
import 'home.dart';

class CheckOutPage extends StatefulWidget {
  const CheckOutPage({super.key});

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {

  var box =  Hive.box<CartProvider>('cart_db');

  RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
  String Function(Match) mathAFunction = (Match match) => '${match[1]},';

  TextEditingController nameEditingController = TextEditingController();
  TextEditingController addressEditingController = TextEditingController();
  TextEditingController phoneEditingController = TextEditingController();
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController infoEditingController = TextEditingController();

  String name = 'Your name', address = 'Delivery address', phone = 'Reachable phone number',
      email ='Your email address', info = 'Additional info';
  String errorText = '';
  bool inFoPage = false;

  //real
 var publicKey = 'pk_live_79cfe5b4d69c8d90982ea316d77397ffa4c059d7';
  //test
 //var publicKey = 'pk_test_55e328c4e63fb8b883db8904cb79eb5fad5e529a';
 // final plugin = PaystackPlugin();

  @override
  void initState() {
    getUserData();
    super.initState();
   // plugin.initialize(publicKey: publicKey);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    nameEditingController.dispose();
    addressEditingController.dispose();
    phoneEditingController.dispose();
    emailEditingController.dispose();
    infoEditingController.dispose();
    super.dispose();
  }

  getUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    name =  prefs.getString('username') ?? '';
    address =  prefs.getString('address') ?? '';
    phone =  prefs.getString('phone') ?? '';
    email =  prefs.getString('email') ?? '';
    info =  prefs.getString('info') ?? '';

    nameEditingController.text = name;
    addressEditingController.text = address;
    phoneEditingController.text = phone;
    emailEditingController.text = email;
    infoEditingController.text = info;

    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: inFoPage
        ? inFoWidget()
        :Column(

          children: [
            const SizedBox(height: 20,),
            Row(
              children: [
                backButton(),
                Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Text('Item summary', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),))
              ],
            ),
            Text( box.length == 0 ? 'Oh no, you removed all items from the cart!'
            :'', style: TextStyle(fontSize: 18),),
            Expanded(
                child: ListView.builder(
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
                              Text('${quantity}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, ),),
                              const SizedBox(width: 20,)

                            ],
                          ),
                        ),
                      );
                    }
                )
            ),



            Visibility(
              visible: box.length > 0,
              child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //TOTAL AMOUNT
                  RichText(
                    text: TextSpan(
                        children: [
                          TextSpan(text: 'Total amount: ', style: TextStyle(color: Colors.black, fontSize: 20)),
                          TextSpan(text: 'NGN ${getTotal().toString().replaceAllMapped(reg, mathAFunction)}', style: TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold)),
                        ]
                    ),

                  ),
                  //TOTAL QUANTITY
                  RichText(
                    text: TextSpan(
                        children: [
                          TextSpan(text: 'Total quantity: ', style: TextStyle(color: Colors.black, fontSize: 18)),
                          TextSpan(text: '${getTotalQuantity().toString().replaceAllMapped(reg, mathAFunction)}', style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold)),
                        ]
                    ),

                  ),
                ],
              ),),
            Visibility(
              visible: box.length > 0,
              child:
              InkWell(
                onTap: (){
                  setState(() {
                    inFoPage = true;
                  });
                },
                child: Container(
                  margin: EdgeInsets.all( 20),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  decoration:const ShapeDecoration(shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20),)
                  ),
                     color: Colors.red,
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Continue', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  double getTotal(){
    double total = 0.0;
    for(int n = 0; n < box.length; n++){
      total = total + box.getAt(n)!.amount;
    }
    // print(total);
    return total;
  }
  int getTotalQuantity(){
    int total = 0;
    for(int n = 0; n < box.length; n++){
      total = total + box.getAt(n)!.quantity;
    }
    // print(total);
    return total;
  }
  void deleteItem(int index) {
    box.deleteAt(index);
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
              if(inFoPage){
                setState(() {
                  inFoPage = false;
                });
              }else{

                Navigator.pop(context);
              }
            },
            icon: Icon(Icons.close_rounded, color: Colors.white,)),
      );
  }

  inFoWidget(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 20,),
        Row(
          children: [
            backButton(),
            Container(
                margin: EdgeInsets.only(left: 20),
                child: Text('Pick up infomation', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),))
          ],
        ),
        Expanded(
            child: Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    //name
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20, top: 5),
                      child: TextField(
                          controller: nameEditingController,
                          maxLines: 1,
                          textCapitalization: TextCapitalization.sentences,

                          decoration: InputDecoration(
                              labelText: 'Your name',
                              hintText: 'Your name',
                              helperText: '',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              prefixIcon: Icon(CupertinoIcons.person_alt)
                          )
                      ),
                    ),
                    //address
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20),
                      child: TextField(
                        controller: addressEditingController,
                        maxLines: 1,
                        textCapitalization: TextCapitalization.sentences,
                        decoration: InputDecoration(
                            labelText: 'Delivery address',
                            hintText: 'Delivery address',
                            helperText: '',

                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),
                            prefixIcon: Icon(CupertinoIcons.location_fill)
                        ),
                        keyboardType: TextInputType.streetAddress,
                      ),
                    ),
                    //email
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                      child: TextField(
                          controller: emailEditingController,
                          maxLines: 1,
                          textCapitalization: TextCapitalization.sentences,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              labelText: 'Email address',
                              hintText: 'Email address',
                              helperText: 'Suggestion: Use same email address for all your orders',

                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              prefixIcon: Icon(CupertinoIcons.mail)
                          )
                      ),
                    ),
                    //PHONE
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20),
                      child: TextField(
                          controller: phoneEditingController,
                          maxLines: 1,
                          textCapitalization: TextCapitalization.sentences,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                              labelText: 'Reachable phone number',
                              hintText: 'Reachable phone number',
                              helperText: '',

                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              prefixIcon: Icon(CupertinoIcons.phone_fill)
                          )
                      ),
                    ),
                    //more info
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20),
                      child: TextField(
                          controller: infoEditingController,
                          maxLines: 6,
                          minLines: 3,
                          textCapitalization: TextCapitalization.sentences,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              labelText: 'Additional information',
                              hintText: 'Additional information',
                              helperText: '',

                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              prefixIcon: Icon(CupertinoIcons.info_circle_fill)
                          )
                      ),
                    ),
                    //error text
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

                    InkWell(
                      onTap: (){
                        checkInfoEntered();
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 20, right: 20),
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                        decoration:const ShapeDecoration(shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20),)
                        ),
                           color: Colors.red,
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Place order', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),),
                            Icon(Icons.payment, color: Colors.white,),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ))

      ],
    );
  }

  Future<void> checkInfoEntered() async {
    setState(() {
      errorText = '';
    });
    if(nameEditingController.text.trim().isEmpty){
      setState(() {
        errorText = 'Enter your name!';
      });
    }else if(addressEditingController.text.trim().isEmpty){
      setState(() {
        errorText = 'Delivery address is needed!';
      });

    }else if(phoneEditingController.text.trim().isEmpty){
      setState(() {
        errorText = 'Phone number is needed!';
      });
    }else if(emailEditingController.text.trim().isEmpty){
      setState(() {
        errorText = 'Email address is needed!';
      });
    }
    else{

      //add info to pref
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('username', nameEditingController.text);
      prefs.setString('address', addressEditingController.text);
      prefs.setString('phone', phoneEditingController.text);
      prefs.setString('email', emailEditingController.text);
      prefs.setString('info', infoEditingController.text);

      pay();
    }
  }

  Future<void> pay() async {

    if(kIsWeb){
      //web implementeation for paystack
      try{
        await PaystackPopup.openPaystackPopup
          (
            pkTest: publicKey,
            email: emailEditingController.text,
            amount: (getTotal() * 100).toString(),
            ref: DateTime.timestamp().toString(),
            onClosed: (){
              setState(() {
                errorText = 'Transaction interrupted!';
              });
            },
            onSuccess: (){
              sendOrders();
            });

      }catch(e){
        setState(() {
          errorText = e.toString();
        });
      }
    }
  }

  void sendOrders() async {
    List<String> orderNames = <String>[];
    List<int> orderQuantities = <int>[];
    List<double> orderAmounts = <double>[];
    String recipientName = nameEditingController.text;
    String recipientPhone = phoneEditingController.text;
    String recipientEmail = emailEditingController.text;
    String recipientAddress = addressEditingController.text;
    String recipientOtherInfo = infoEditingController.text;
    int orderTime = DateTime.timestamp().millisecondsSinceEpoch;
    String orderStatus = 'Pending';

    int boxLength = box.length;
    int x = 0;
    do{
      orderNames.add(box.getAt(x)!.ItemName);
      orderQuantities.add(box.getAt(x)!.quantity);
      orderAmounts.add(box.getAt(x)!.amount);
      box.deleteAt(x);
      boxLength--;
    }while(boxLength != x);

    String res = await FirestoreMethods().sendOrder(recipientName: recipientName, recipientPhone: recipientPhone, recipientEmail: recipientEmail, recipientAddress: recipientAddress, recipientOtherInfo: recipientOtherInfo, orderTime: orderTime, orderStatus: orderStatus, orderNames: orderNames, orderQuantities: orderQuantities, orderAmounts: orderAmounts);
    if(res == 'Order sent successfully!'){



      showSpackSnackBar('Your order has been sent successfully!',  context, Colors.green, Icons.done);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
          const HomePage()
      ));
    }
  }
}
