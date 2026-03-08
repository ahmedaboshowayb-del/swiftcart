import 'package:hive/hive.dart';
import '../../domain/entities/cart_item_entity.dart';
import '../../domain/entities/product_entity.dart';

@HiveType(typeId: 1)
class CartItemModel extends HiveObject {
  CartItemModel({
    required this.productId,
    required this.productName,
    required this.price,
    required this.imageUrl,
    required this.quantity,
    this.discountPrice,
    this.selectedSize,
    this.selectedColor,
    this.categoryId = '',
    this.categoryName = '',
    this.brand = '',
  });

  @HiveField(0) final String  productId;
  @HiveField(1) final String  productName;
  @HiveField(2) final double  price;
  @HiveField(3) final double? discountPrice;
  @HiveField(4) final String  imageUrl;
  @HiveField(5)       int     quantity;
  @HiveField(6) final String? selectedSize;
  @HiveField(7) final String? selectedColor;
  @HiveField(8) final String  categoryId;
  @HiveField(9) final String  categoryName;
  @HiveField(10) final String brand;

  Map<String, dynamic> toMap() => {
        'productId':     productId,
        'productName':   productName,
        'price':         price,
        'discountPrice': discountPrice,
        'imageUrl':      imageUrl,
        'quantity':      quantity,
        'selectedSize':  selectedSize,
        'selectedColor': selectedColor,
        'categoryId':    categoryId,
        'categoryName':  categoryName,
        'brand':         brand,
      };

  factory CartItemModel.fromMap(Map<String, dynamic> m) => CartItemModel(
        productId:     m['productId']     as String,
        productName:   m['productName']   as String,
        price:         (m['price'] as num).toDouble(),
        discountPrice: (m['discountPrice'] as num?)?.toDouble(),
        imageUrl:      m['imageUrl']      as String? ?? '',
        quantity:      m['quantity']      as int,
        selectedSize:  m['selectedSize']  as String?,
        selectedColor: m['selectedColor'] as String?,
        categoryId:    m['categoryId']    as String? ?? '',
        categoryName:  m['categoryName']  as String? ?? '',
        brand:         m['brand']         as String? ?? '',
      );

  Map<String, dynamic> toOrderMap() => {
        'product_id':    productId,
        'product_name':  productName,
        'price':         discountPrice ?? price,
        'original_price': price,
        'image_url':     imageUrl,
        'quantity':      quantity,
        'selected_size':  selectedSize,
        'selected_color': selectedColor,
        'subtotal':      (discountPrice ?? price) * quantity,
      };

  CartItemEntity toEntity() => CartItemEntity(
        product: ProductEntity(
          id:            productId,
          name:          productName,
          description:   '',
          price:         price,
          discountPrice: discountPrice,
          images:        [imageUrl],
          categoryId:    categoryId,
          categoryName:  categoryName,
          brand:         brand,
          rating:        0,
          reviewCount:   0,
          stock:         999,
          tags:          [],
          isFeatured:    false,
          isNew:         false,
          createdAt:     DateTime.now(),
        ),
        quantity:      quantity,
        selectedSize:  selectedSize,
        selectedColor: selectedColor,
      );

  factory CartItemModel.fromEntity(CartItemEntity e) => CartItemModel(
        productId:     e.product.id,
        productName:   e.product.name,
        price:         e.product.price,
        discountPrice: e.product.discountPrice,
        imageUrl:      e.product.primaryImage,
        quantity:      e.quantity,
        selectedSize:  e.selectedSize,
        selectedColor: e.selectedColor,
        categoryId:    e.product.categoryId,
        categoryName:  e.product.categoryName,
        brand:         e.product.brand,
      );
}