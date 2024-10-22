import '../model/product_model.dart';

class ProductList{
  final List<Products> productLists = [
    //add all sections here
    Products(ItemName: 'Cup Cake(Dozen)', ItemType: 'cake', amount: 14999, description: 'Cup cake by 12', picture: 'assets/Cupcakes_12.jpg'),
    Products(ItemName: 'Cup Cake(Half dozen)', ItemType: 'cake', amount: 7999, description: 'Cup cake by 6', picture: 'assets/cupcakes_5.jpg'),
    Products(ItemName: 'Bento cake', ItemType: 'cake', amount: 6999, description: 'Bento cake with icing', picture: 'assets/bento.jpg'),
    Products(ItemName: 'Vanilla cake', ItemType: 'cake', amount: 12999, description: 'Single layer vanilla cake, 10 inches', picture: 'assets/vanilla.jpg'),
    Products(ItemName: 'Chocolate cake', ItemType: 'cake', amount: 14999, description: 'Single layer chocolate cake, 10 inches', picture: 'assets/chocolate.jpg'),
    Products(ItemName: 'Red velvet cake', ItemType: 'cake', amount: 16999, description: 'Single layer red velvet cake, 10 inches', picture: 'assets/red_velvet.jpg'),

    Products(ItemName: 'Small chops', ItemType: 'chop', amount: 1199, description: 'A plate of small chops including samosa, puff puff and spring roll', picture: 'assets/small_chop_plate.jpg'),
    Products(ItemName: 'Donuts', ItemType: 'chop', amount: 999, description: 'Donut', picture: 'assets/donut.jpg'),
    Products(ItemName: 'Meat-pie', ItemType: 'chop', amount: 699, description: 'Meat-pie', picture: 'assets/meatpie.jpg'),
    Products(ItemName: 'Puff-puff', ItemType: 'chop', amount: 100, description: 'Puff-puff, small size', picture: 'assets/puff-puff.jpg'),
    Products(ItemName: 'Egg-roll', ItemType: 'chop', amount: 250, description: 'Egg-roll with half egg', picture: 'assets/egg_roll.JPG'),
    Products(ItemName: 'Egg-roll full', ItemType: 'chop', amount: 300, description: 'Egg-roll with full egg', picture: 'assets/egg_roll.JPG'),

    Products(ItemName: 'Smoothies', ItemType: 'smoothie', amount: 2500, description: 'Smoothies', picture: 'assets/smoothie.png'),
    Products(ItemName: 'Parfaits', ItemType: 'smoothie', amount: 3500, description: 'Parfaits', picture: 'assets/parfait.png'),
    Products(ItemName: 'Fruit drink', ItemType: 'smoothie', amount: 1000, description: 'Any fruit drink', picture: 'assets/fruit_juice.jpg'),
  ];
  final List<Products> cake_productLists = [
    Products(ItemName: 'Cup Cake(Dozen)', ItemType: 'cake', amount: 14999, description: 'Cup cake by 12', picture: 'assets/Cupcakes_12.jpg'),
    Products(ItemName: 'Cup Cake(Half dozen)', ItemType: 'cake', amount: 7999, description: 'Cup cake by 6', picture: 'assets/cupcakes_5.jpg'),
    Products(ItemName: 'Bento cake', ItemType: 'cake', amount: 6999, description: 'Bento cake with icing', picture: 'assets/bento.jpg'),
    Products(ItemName: 'Vanilla cake', ItemType: 'cake', amount: 12999, description: 'Single layer vanilla cake, 10 inches', picture: 'assets/vanilla.jpg'),
    Products(ItemName: 'Chocolate cake', ItemType: 'cake', amount: 14999, description: 'Single layer chocolate cake, 10 inches', picture: 'assets/chocolate.jpg'),
    Products(ItemName: 'Red velvet cake', ItemType: 'cake', amount: 16999, description: 'Single layer red velvet cake, 10 inches', picture: 'assets/red_velvet.jpg'),
  ];
  final List<Products> chops_productLists = [
    Products(ItemName: 'Small chops', ItemType: 'chop', amount: 1199, description: 'A plate of small chops including samosa, puff puff and spring roll', picture: 'assets/small_chop_plate.jpg'),
    Products(ItemName: 'Regular Donuts', ItemType: 'chop', amount: 400, description: 'Donut', picture: 'assets/donut.jpg'),
    Products(ItemName: 'Meat-pie', ItemType: 'chop', amount: 699, description: 'Meat-pie', picture: 'assets/meatpie.jpg'),
    Products(ItemName: 'Puff-puff', ItemType: 'chop', amount: 100, description: 'Puff-puff, small size', picture: 'assets/puff-puff.jpg'),
    Products(ItemName: 'Egg-roll', ItemType: 'chop', amount: 250, description: 'Egg-roll with half egg', picture: 'assets/egg_roll.JPG'),
    Products(ItemName: 'Egg-roll full', ItemType: 'chop', amount: 300, description: 'Egg-roll with full egg', picture: 'assets/egg_roll.JPG'),
  ];
  final List<Products> smoothies_productLists = [
    Products(ItemName: 'Smoothies', ItemType: 'smoothie', amount: 2500, description: 'Smoothies', picture: 'assets/smoothie.png'),
    Products(ItemName: 'Parfaits', ItemType: 'smoothie', amount: 3500, description: 'Parfaits', picture: 'assets/parfait.png'),
    Products(ItemName: 'Fruit drink', ItemType: 'smoothie', amount: 1000, description: 'Any fruit drink', picture: 'assets/fruit_juice.jpg'),
  ];

}