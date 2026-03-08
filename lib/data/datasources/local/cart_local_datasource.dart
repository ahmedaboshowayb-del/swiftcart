import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/constants/app_constants.dart';

part 'cart_local_datasource.g.dart';

@riverpod
CartLocalDataSource cartLocalDataSource(CartLocalDataSourceRef ref) =>
    CartLocalDataSource();

class HiveCartItem {
  HiveCartItem({
    required this.productId,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.quantity,
    this.discountPrice,
    this.selectedSize,
    this.selectedColor,
  });

  final String  productId;
  final String  name;
  final double  price;
  final double? discountPrice;
  final String  imageUrl;
  int           quantity;
  final String? selectedSize;
  final String? selectedColor;

  Map<String, dynamic> toMap() => {
    'productId':     productId,
    'name':          name,
    'price':         price,
    'discountPrice': discountPrice,
    'imageUrl':      imageUrl,
    'quantity':      quantity,
    'selectedSize':  selectedSize,
    'selectedColor': selectedColor,
  };

  factory HiveCartItem.fromMap(Map<String, dynamic> m) => HiveCartItem(
    productId:     m['productId']     as String,
    name:          m['name']          as String,
    price:         (m['price'] as num).toDouble(),
    discountPrice: (m['discountPrice'] as num?)?.toDouble(),
    imageUrl:      m['imageUrl']      as String? ?? '',
    quantity:      m['quantity']      as int,
    selectedSize:  m['selectedSize']  as String?,
    selectedColor: m['selectedColor'] as String?,
  );
}

class CartLocalDataSource {
  Box<Map>? _box;

  Future<Box<Map>> _open() async {
    if (_box != null && _box!.isOpen) return _box!;
    _box = await Hive.openBox<Map>(AppConstants.cartBox);
    return _box!;
  }

  Future<List<HiveCartItem>> getItems() async {
    final b = await _open();
    return b.values
        .map((e) => HiveCartItem.fromMap(Map<String, dynamic>.from(e)))
        .toList();
  }

  Future<void> save(HiveCartItem item) async {
    final b = await _open();
    await b.put(item.productId, item.toMap());
  }

  Future<void> remove(String productId) async {
    final b = await _open();
    await b.delete(productId);
  }

  Future<void> updateQty(String productId, int qty) async {
    final b = await _open();
    final raw = b.get(productId);
    if (raw == null) return;
    final item = HiveCartItem.fromMap(Map<String, dynamic>.from(raw));
    item.quantity = qty;
    await b.put(productId, item.toMap());
  }

  Future<void> clear() async {
    final b = await _open();
    await b.clear();
  }

  Stream<List<HiveCartItem>> watch() async* {
    final b = await _open();
    yield _parse(b);
    yield* b.watch().map((_) => _parse(b));
  }

  List<HiveCartItem> _parse(Box<Map> b) => b.values
      .map((e) => HiveCartItem.fromMap(Map<String, dynamic>.from(e)))
      .toList();
}