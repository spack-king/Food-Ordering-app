// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_provider.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CartProviderAdapter extends TypeAdapter<CartProvider> {
  @override
  final int typeId = 0;

  @override
  CartProvider read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CartProvider(
      fields[0] as String,
      fields[1] as String,
      fields[2] as double,
      fields[3] as String,
      fields[4] as String,
      fields[5] as int,
      fields[6] as bool,
      fields[7] as double,
    );
  }

  @override
  void write(BinaryWriter writer, CartProvider obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.ItemName)
      ..writeByte(1)
      ..write(obj.ItemType)
      ..writeByte(2)
      ..write(obj.amount)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.picture)
      ..writeByte(5)
      ..write(obj.quantity)
      ..writeByte(6)
      ..write(obj.inCart)
      ..writeByte(7)
      ..write(obj.initialAmount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartProviderAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
