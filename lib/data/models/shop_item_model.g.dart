// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ShopItemModel _$ShopItemModelFromJson(Map<String, dynamic> json) =>
    _ShopItemModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toInt(),
      type: $enumDecode(_$ItemTypeEnumMap, json['type']),
      isAvailable: json['isAvailable'] as bool? ?? true,
    );

Map<String, dynamic> _$ShopItemModelToJson(_ShopItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
      'type': _$ItemTypeEnumMap[instance.type]!,
      'isAvailable': instance.isAvailable,
    };

const _$ItemTypeEnumMap = {
  ItemType.swapOrder: 'swapOrder',
  ItemType.addBomb: 'addBomb',
  ItemType.enhancePenalty: 'enhancePenalty',
};
