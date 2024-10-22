import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:glass/glass.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:peachypastries/pages/home.dart';
import 'package:peachypastries/provider/cart_provider.dart';
import 'package:peachypastries/utilities/alerts.dart';
import 'package:peachypastries/utilities/global_variable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';
import 'first_swipe_page.dart';

Future<void> main() async {
//  flutter pub run build_runner build --delete-conflicting-outputs

  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String username = prefs.getString('username') ?? '';

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //for hive
  await Hive.initFlutter();
  Hive.registerAdapter(CartProviderAdapter());
  await Hive.openBox<CartProvider>('cart_db');

  runApp(MyApp(username: username));
}

class MyApp extends StatelessWidget {
  final username;
  const MyApp({super.key, this.username,});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FoodWay',
     // debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
        theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: Colors.white,
        ),

      home: username != ''
        ? const HomePage()
      : const  FirstSwipe()
    );
  }

}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  TextEditingController textEditingController = TextEditingController();
  Duration input = 0.ms;

  saveSharedPref() async {
     if(textEditingController.text.trim().isEmpty) {
       showSpackSnackBar('Please enter your name!', context, Colors.orange, Icons.error_outline_sharp);
       setState(() {
         input = 500.ms;
       });

     }else{
       final SharedPreferences prefs = await SharedPreferences.getInstance();
       await prefs.setString('username', textEditingController.text);
       showSpackSnackBar('Yay! weldone', context, Colors.green, Icons.done);

       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
           HomePage()
       ));
     }
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: Container(
          decoration:  BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: MediaQuery.of(context).size.width > webScreenSize
              ? AssetImage('assets/images.jpeg-8.jpg', )
              : AssetImage('assets/images.jpeg-9.jpg', ),
            ),
          ),
          child: Center(
            child: Container(
              alignment: Alignment.center,
              margin: MediaQuery.of(context).size.width > webScreenSize
                  ?  EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width /4, vertical: 10)
                  :  EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: MediaQuery.of(context).size.width /3.5,),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.all(30),
                        child: Image.asset('assets/foodway.png', width: 100, height: 100,)),
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20),
                      child: Text('Hi there, please enter your name below!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold,// color: Colors.white,
                      shadows: [
                       // Shadow(color: Colors.black, blurRadius: 1)
                      ]),),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20, top: 5),
                      child: TextField(
                        controller: textEditingController,
                        maxLines: 1,
                          textAlign: TextAlign.center,
                          textCapitalization: TextCapitalization.sentences,
                          decoration: InputDecoration(
                            hintText: 'YOUR NAME',
                              hintStyle: TextStyle(fontWeight: FontWeight.bold),
                              helperText: 'to better customise your experience',

                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25)
                              )
                          )
                      ).animate().shakeX(duration: input,),
                    ),
                    InkWell(

                      onTap: () async {
                        saveSharedPref();
                      },
                      child: kIsWeb ? Container(
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text('Continue', style: TextStyle( color: Colors.white, fontWeight: FontWeight.bold),),
                              Icon(Icons.arrow_right_alt_outlined, size: 30, color: Colors.white,),
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
                          color: Colors.red,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(25),)
                          ),

                        ),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text('Proceed', style: TextStyle( color: Colors.white, fontWeight: FontWeight.bold),),
                              Icon(Icons.arrow_right_alt_outlined, size: 30, color: Colors.white,),
                            ].animate(interval: 1000.milliseconds).shakeX(duration: 500.milliseconds, delay: 2000.milliseconds),
                          ),
                        ),
                      ).animate().shimmer(duration: 500.ms, delay: 3000.ms),
                    ),
                  ].animate(interval: 100.ms).fadeIn(duration: 500.ms,),
                ).asGlass(
                  enabled: true,
                  tintColor: Colors.transparent,
                  clipBorderRadius: BorderRadius.circular(15.0),
                ),
              ),
            ) ,
          ),
        ),
      );
  }
}
