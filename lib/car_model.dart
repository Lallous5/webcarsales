class CarModel {
  String nameCar;
  String desc;
  String phoneNumber;
  List images;
  // TimeStamp createdAt;
  // DateTime sellAt;
  bool isFeatured;
  bool isDeleted;
  bool isHidden;
  bool isCancelled;
  int price;
  int amountPrice;

  CarModel.assign({
    required this.amountPrice,
    // required this.createdAt,
    required this.desc,
    required this.images,
    required this.isCancelled,
    required this.isFeatured,
    required this.isHidden,
    required this.isDeleted,
    required this.nameCar,
    required this.phoneNumber,
    required this.price,
    // required this.sellAt,
  });

  factory CarModel.fromJson(Map<String, dynamic> json) {
    return CarModel.assign(
      amountPrice: json['amountPrice'],
      // createdAt: json['createdAt'],
      desc: json['desc'],
      images: json['images'],
      isCancelled: json['isCancelled'],
      isFeatured: json['isFeatured'],
      isHidden: json['isHidden'],
      isDeleted: json['isDeleted'],
      nameCar: json['nameCar'],
      phoneNumber: json['phoneNumber'],
      price: json['price'],
      // sellAt: json['sellAt'],
    );
  }

  Map<String, dynamic> toJson() => {
        'amountPrice': amountPrice,
        // 'createdAt': createdAt,
        'desc': desc,
        'images': images,
        'isCancelled': isCancelled,
        'isDeleted': isDeleted,
        'isFeatured': isFeatured,
        'isHidden': isHidden,
        'nameCar': nameCar,
        'phoneNumber': phoneNumber,
        'price': price,
        // 'sellAt': sellAt,
      };
}
