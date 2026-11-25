class Item {
  final int? id;
  final String name;
  final String sku;
  final int price;
  final int stock;
  final DateTime updatedAt;
  final String syncStatus;

  Item({
    required this.id,
    required this.name,
    required this.price,
    required this.sku,
    required this.stock,
    required this.syncStatus,
    DateTime? updatedAt,
  }) : updatedAt = updatedAt ?? DateTime.now();

  Item copywith({
    int? id,
    String? name,
    String? sku,
    int? price,
    int? stock,
    DateTime? updatedAt,
    String? syncStatus,
  }) {
    return Item(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      sku: sku ?? this.sku,
      stock: stock ?? this.stock,
      syncStatus: syncStatus ?? this.syncStatus,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> tomap() => {
    'id': id,
    'name': name,
    'sku': sku,
    'price': price,
    'stock': stock,
    'updatedAt': updatedAt.toIso8601String(),
    'syncStatus': syncStatus,
  };

  factory Item.frommap(Map<String, dynamic> map) => Item(
    id: map['id'],
    name: map['name'],
    sku: map['sku'],
    price: map['price'],
    stock: map['stock'],
    updatedAt: map['updatedAt'] != null
        ? DateTime.parse(map['updatedAt'])
        : DateTime.now(),
    syncStatus: map['syncStatus'],
  );
}
