import 'package:animated_background/animated_background.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hive/hive.dart';
import 'package:peachypastries/model/product_model.dart';
import 'package:peachypastries/pages/item_preview.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/drawer.dart';
import '../provider/cart_provider.dart';
import '../provider/product_list.dart';
import '../utilities/colors.dart';
import '../utilities/global_variable.dart';
import 'cart.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin{

  late TabController tabController;
  late List<Products> productList, cake_productList, choop_productList, smoothiesproductList;
  List<Products> testList = <Products>[];

  RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
  String Function(Match) mathAFunction = (Match match) => '${match[1]},';

  //hive
  var box =  Hive.box<CartProvider>('cart_db');
  int counter= 0;
  bool addedToCart = false;

  static List<Tab> tabs = [
    Tab(
      icon: Row(
        children: [
          Icon(Icons.storefront_sharp),
          Text('All'),
        ],
      ),
    ),
    Tab(
      icon: Row(
        children: [
          Image.asset('assets/cake.png'),
          Text('Cakes'),
        ],
      ),
    ),
    Tab(
      icon: Row(
        children: [
          Image.asset('assets/small_chop.png'),
          Text('Chops & Rolls'),
        ],
      ),
    ),
    Tab(
      icon: Row(
        children: [
          Image.asset('assets/parfait.png'),
          Text('Smoothies & Drinks'),
        ],
      ),
    ),
  ];

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  
  String name = '';
  @override
  void initState(){
    super.initState();
    runCounterCheck();

    productList = ProductList().productLists;
    cake_productList = ProductList().cake_productLists;
    choop_productList = ProductList().chops_productLists;
    smoothiesproductList = ProductList().smoothies_productLists;
    shuffleAllLists();
    
    tabController = TabController(length: 4, vsync: this);

    getUserData();
  }

  getUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    name =  prefs.getString('username') ?? '';

    setState(() {
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: MyDrawer(),
      ),
      body: SafeArea(
        child: AnimatedBackground(
          vsync: this,
          behaviour: RandomParticleBehaviour(
            options: ParticleOptions(
              //image:   Image.asset('assets/cake.png', width: 40,),
              baseColor: Colors.red,
              particleCount: 50,
              spawnMaxSpeed: 100,
              spawnMinSpeed: 50
            )
          ),
          child: Container(
            margin: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10,),
                //custom app bar
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: (){
                          _scaffoldKey.currentState?.openDrawer();
                          //Scaffold.of(context).openDrawer();
                        }, icon: Icon(CupertinoIcons.line_horizontal_3_decrease, size: 30,)),
                    IconButton(onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>
                          Cart()
                      )).then((value) {
                       runCounterCheck();
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
                  ],
                ),
                //welcome text
                Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Text('Hi, $name', maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)),
                Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Text('Welcome to FoodWay', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),)),
                Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Text('HOME OF DELICIOUSNESS',)),
                const SizedBox(height: 10,),
                //HORIZONTAL SLIDING ...
                TabBar(
                  tabs: tabs,
                  physics: const BouncingScrollPhysics(),
                  controller: tabController,
                  indicator: BoxDecoration(

                      borderRadius: BorderRadius.circular(10),
                      color: primaryColor
                  ),
                  unselectedLabelColor: primaryColor,
                  isScrollable: true,

                ),
                Expanded(
                  child: TabBarView(
                      physics: const BouncingScrollPhysics(),
                      controller: tabController,
                      children: [
                        //all
                      CustomInkWell(productList),
                    //cake
                    CustomInkWell(cake_productList),
                    //chops
                    CustomInkWell(choop_productList),
                    //smoothies
                    CustomInkWell(smoothiesproductList),
                      ]
                  ),
                )

              ],//.animate(interval: 100.milliseconds).slideX(duration: 500.milliseconds, delay: 2000.milliseconds),
            ),
          ),
        ),
      ),
    );
  }

  CustomInkWell(List<Products> list_item) {


    return Container(

      margin: MediaQuery.of(context).size.width > webScreenSize
          ?  EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width /10, vertical: 10)
          :  null,
      child: GridView.builder(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: list_item.length,
          gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: MediaQuery.of(context).size.width > webScreenSize
                  ? 3 : 2,
              crossAxisSpacing: 5,
              mainAxisSpacing: 1.5,
              childAspectRatio: 0.7
          ),
          itemBuilder: (context, index){
            addedToCart = box.get(list_item[index].ItemName) != null;

            int delay = 300;

            return InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                    ItemPreview(image: list_item[index].picture, name: list_item[index].ItemName, description: list_item[index].description, amount: list_item[index].amount, initialAmouunt: list_item[index].amount,)
                )).then((value) {
                  runCounterCheck();
                });
              },
              child: Stack(
                children: [
                  Card(
                      margin:const EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20),)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              child: Center(
                                child: ClipRRect(

                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                    child: Image.asset(list_item[index].picture)),
                              )),
                          Container(
                            margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
                            child:  Text(list_item[index].ItemName, style: const TextStyle( fontSize: 20), maxLines: 2, overflow: TextOverflow.ellipsis, ),),
                          Container(
                            margin: const EdgeInsets.only(left: 10),
                            child:  Text('NGN ${list_item[index].amount.toString().replaceAllMapped(reg, mathAFunction)}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),),
                          //add to cart

                          InkWell(
                            onTap: (){
                              addedToCart = box.get(list_item[index].ItemName) != null;
                              if(addedToCart){
                                print('about');
                                box.delete(list_item[index].ItemName);
                                print('deleted');

                              }else{
                                var cartItem = CartProvider(list_item[index].ItemName,
                                    list_item[index].ItemType,
                                    list_item[index].amount, list_item[index].description, list_item[index].picture,
                                    1, true, list_item[index].amount);
                                box.put(list_item[index].ItemName, cartItem);
                              }
                              runCounterCheck();
                            },
                            child: addedToCart
                                ? Container(
                              width: double.infinity,
                              margin: EdgeInsets.all( 5),
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(vertical: 10),
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
                              width: double.infinity,
                              margin: EdgeInsets.all( 5),
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(vertical: 10),
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
                      )).animate().fadeIn(delay: delay.ms, duration: 1000.ms),
                  // Positioned(
                  //   right: 5.0,
                  //   top: 5.0,
                  //   child: IconButton(
                  //       onPressed: (){
                  //
                  //       },
                  //       icon: Icon(Icons.favorite_outlined, color: Colors.red,)),
                  // )

                ],
              ),
            );
          }
      ),
    );
  }

  void runCounterCheck() {

    counter = box.length;
    setState(() {

    });
  }

  void shuffleAllLists() {
    //shuffle all

    productList.shuffle();
    cake_productList.shuffle();
    choop_productList.shuffle();
    smoothiesproductList.shuffle();
  }

}
