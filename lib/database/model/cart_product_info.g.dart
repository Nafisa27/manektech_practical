// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_product_info.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CartProductInfoAdapter extends TypeAdapter<CartProductInfo> {
  @override
  final int typeId = 1;

  @override
  CartProductInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CartProductInfo(
      id: fields[0] as int?,
      title: fields[1] as String?,
      description: fields[2] as String?,
      price: fields[3] as int?,
      featuredImage: fields[4] as String?,
      quantity: fields[5] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, CartProductInfo obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.price)
      ..writeByte(4)
      ..write(obj.featuredImage)
      ..writeByte(5)
      ..write(obj.quantity);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartProductInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
