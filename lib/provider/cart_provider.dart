import 'package:hive/hive.dart';
part 'cart_provider.g.dart';

@HiveType(typeId: 0)
class CartProvider{

  @HiveField(0)
  final String ItemName;
  @HiveField(1)
  final String ItemType;
  @HiveField(2)
  final double amount;
  @HiveField(3)
  final String description;
  @HiveField(4)
  final String picture;
  @HiveField(5)
  final int quantity;
  @HiveField(6)
  final bool inCart;
  @HiveField(7)
  final double initialAmount;
  
   CartProvider(this.ItemName,this.ItemType,this.amount,this.description,this.picture,this.quantity,this.inCart, this.initialAmount,);
}