// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nftModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NFT _$NFTFromJson(Map<String, dynamic> json) => NFT()
  ..PublicKey = json['public_key'] as String
  ..Name = json['Name'] as String
  ..Description = json['Description'] as String
  ..Attributes = json['Attributes'] as String
  ..url = json['url'] as String
  ..Price = json['Price'] as String;

Map<String, dynamic> _$NFTToJson(NFT instance) => <String, dynamic>{
      'public_key': instance.PublicKey,
      'Name': instance.Name,
      'Description': instance.Description,
      'Attributes': instance.Attributes,
      'url': instance.url,
      'Price': instance.Price,
    };
