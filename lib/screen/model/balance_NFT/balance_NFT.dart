class Item_NFT
{
  late final int id;
  late final String name;
  late final String imageUrl;
  late final double price;

  Item_NFT({
    required this.id,
    required this.name ,
    required this.imageUrl,
    required this.price
  });

  factory Item_NFT.fromJsone(Map<String,dynamic>json)
  {
    return Item_NFT(
        id: json[0],
        name: json[""],
        imageUrl: json[""],
        price: json[0.0],
    );
  }
}