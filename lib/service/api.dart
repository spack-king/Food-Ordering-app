// import 'dart:convert';
//
// import 'package:flutter/cupertino.dart';
// import 'package:http/http.dart' as http;
// import 'package:peachypastries/model/product_model.dart';
// class Api{
//   static const baseUrl = "localhost:2000/";
//
//   //add to database
//   static addProduct(Map data) async {
//
//     var url = Uri.http("localhost:2000", "/api/add_product");
//     try{
//       final res = await http.post(url, body: data);
//
//       if(res.statusCode == 200){
//         var data = jsonDecode(res.body.toString());
//         print(data);
//       }else{
//         print('failed to get data');
//       }
//     }catch(e){
//       debugPrint(e.toString());
//     }
//   }
//
//   //get method
//   static getProduct() async{
//     List<Products> products = [];
//
//     var url = Uri.http("localhost:2000", "/api/get_product");
//
//     try{
//       final res = await http.get(url);
//
//       if(res.statusCode == 200){
//         var data = jsonDecode(res.body);
//         data['products'].forEach((value) =>{
//           products.add(Products(ItemName: value['pname'], ItemType: value['pdesc'], amount: 9.9, description: value['pdesc'], picture: '')),
//         });
//
//         return products;
//       }else{
//         return [];
//       }
//     }catch(e){
//       debugPrint('this ${e.toString()}');
//     }
//   }
//
//   //update method
//   static updateProduct(id, body) async{
//
//     var url = Uri.http("localhost:2000", "/api/update/$id");
//
//     try{
//       final res = await http.post(url, body: body);
//       if(res.statusCode == 200){
//         print(jsonDecode(res.body));
//       }
//     }catch(e){
//       print(e.toString());
//     }
//   }
//
//   //delete method
//   static deleteProduct(id) async {
//     var url = Uri.http("localhost:2000", "api/delete/$id");
//
//     try{
//       final res = await http.delete(url);
//
//       if(res.statusCode == 204){
//         print(jsonDecode(res.body));
//       }else{
//         print('failed to delete ${res.statusCode}');
//       }
//     }catch(e){
//       debugPrint('failed');
//     }
//   }
// }