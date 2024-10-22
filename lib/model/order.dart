import 'package:cloud_firestore/cloud_firestore.dart';

class Orders{

  final String recipientName ;
  final String recipientPhone;
  final String recipientEmail;
  final String recipientAddress;
  final String recipientOtherInfo;
  final int orderTime;
  final String orderStatus;
  final orderNames;
  final orderQuantities;
  final orderAmounts;


  const Orders({                
    required this.recipientName,        
    required this.recipientPhone,       
    required this.recipientEmail,
    required this.recipientAddress,
    required this.recipientOtherInfo,
    required this.orderTime,
    required this.orderStatus,
    required this.orderNames,
    required this.orderQuantities,
    required this.orderAmounts,
  });

  Map<String, dynamic> toJson() => {

    "recipientName": recipientName,
    "recipientPhone": recipientPhone,
    "recipientEmail": recipientEmail,
    "recipientAddress": recipientAddress,
    "recipientOtherInfo": recipientOtherInfo,
    "orderTime": orderTime,
    "orderStatus": orderStatus,
    "orderNames": orderNames,
    "orderQuantities": orderQuantities,
    "orderAmounts": orderAmounts,
  };
  static Orders fromSnap(DocumentSnapshot snap){
    var snapshot = snap.data() as Map<String, dynamic>;

    return Orders(
      recipientName: snapshot['recipientName'],
      recipientPhone: snapshot['recipientPhone'],
      recipientEmail: snapshot['recipientEmail'],
      recipientAddress: snapshot['recipientAddress'],
      recipientOtherInfo: snapshot['recipientOtherInfo'],
      orderTime: snapshot['orderTime'],
      orderStatus: snapshot['orderStatus'],
      orderNames: snapshot['orderNames'],
      orderQuantities: snapshot['orderQuantities'],
      orderAmounts: snapshot['orderAmounts'],
    );
  }
}
