import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:peachypastries/model/order.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> sendOrder({required String recipientName,required String recipientPhone,
    required String recipientEmail, required String recipientAddress, required String recipientOtherInfo,
    required int orderTime, required String orderStatus, required List<String> orderNames ,
    required List<int> orderQuantities , required List<double> orderAmounts }) async {
    String res = "Some error occurred!";
    try {

      String postid = '$orderTime';//'${Timestamp.now().millisecondsSinceEpoch}'; //const Uuid().v1();

      Orders orders = Orders(
          recipientName: recipientName,
          recipientPhone: recipientPhone,
          recipientEmail: recipientEmail,
          recipientAddress: recipientAddress,
          recipientOtherInfo: recipientOtherInfo,
          orderTime: orderTime,
          orderStatus: orderStatus,
          orderNames: orderNames,
          orderQuantities: orderQuantities,
          orderAmounts: orderAmounts);

      _firestore.collection('order').doc(postid).set(
        orders.toJson(),
      );
      res = "Order sent successfully!";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> sendSpecialOrder({required String recipientOrder,required String recipientPhone,
    required int budget,
    }) async {
    String res = "Some error occurred!";
    try {

      String postid = '${DateTime.timestamp().millisecondsSinceEpoch}';//'${Timestamp.now().millisecondsSinceEpoch}'; //const Uuid().v1();


      _firestore.collection('special').doc(postid).set({
        'recipientOrder': recipientOrder,
        'recipientPhone': recipientPhone,
        'orderTime':  DateTime.timestamp().millisecondsSinceEpoch,
        'orderStatus': 'Pending',
        'budget': budget,
       }
      );
      res = "Order sent successfully!";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

}

