import 'package:json_annotation/json_annotation.dart';

part 'nftModel.g.dart';

@JsonSerializable()
class NFT {

  static final NFT _instance = NFT._internal();

  // ویژگی‌ها
  @JsonKey(name: "public_key")
  String PublicKey;
  @JsonKey(name: "Name")
  String Name;
  @JsonKey(name: "Description")
  String Description;
  @JsonKey(name: "Attributes")
  String Attributes;
  String url;
  String Price;

  // سازنده خصوصی
  NFT._internal({
    this.PublicKey = '',
    this.Name = '',
    this.Description = '',
    this.Attributes = '',
    this.url = '',
    this.Price = '',
  });

  // کارخانه (factory)
  factory NFT() {
    return _instance;
  }

  // متد برای تنظیم مقادیر
  void setup({
    required String publicKey,
    required String name,
    required String description,
    required String attributes,
    required String url,
    required String price,
  }) {
    this.PublicKey = publicKey;
    this.Name = name;
    this.Description = description;
    this.Attributes = attributes;
    this.url = url;
    this.Price = price;
  }

  factory NFT.fromJson(Map<String, dynamic> json) => _$NFTFromJson(json);
  Map<String, dynamic> toJson() => _$NFTToJson(this);
}
/*
نحوه استفاده:
با استفاده از روش setup،
 شما می‌توانید مقادیر را بعد از ایجاد نمونه Singleton تنظیم کنید:
 */
// void main() {
//   NFT nft = NFT(); // دریافت نمونه Singleton
//   try {
//     nft.setup(
//       publicKey: "your_public_key",
//       name: "NFT Name",
//       description: "Description of the NFT",
//       attributes: "Some attributes",
//       url: "http://example.com/nft",
//       price: "100.0",
//     );
//
//     print(nft.name); // دسترسی به نام NFT
//   } catch (e) {
//     print(e); // مدیریت خطاها
//   }
// }

