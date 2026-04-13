import 'package:flutter/material.dart';

// 1. Lớp Model định nghĩa cấu trúc dữ liệu của một Sản phẩm
class Product {
  final String name;
  final String description;
  final double price;
  final String imageIcon;

  Product({
    required this.name,
    required this.description,
    required this.price,
    required this.imageIcon,
  });
}

void main() {
  runApp(const ShoppingApp());
}

class ShoppingApp extends StatelessWidget {
  const ShoppingApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shopping App - Named Routes',
      theme: ThemeData(primarySwatch: Colors.orange),
      // 2. Cấu hình Named Routes
      initialRoute: '/', // Tuyến đường khởi chạy đầu tiên
      routes: {
        '/': (context) => ProductListScreen(),
        '/detail': (context) => const ProductDetailScreen(),
      },
    );
  }
}

// 3. Màn hình 1: Danh sách Sản phẩm
class ProductListScreen extends StatelessWidget {
  // Dữ liệu mẫu giả lập lấy từ Database
  final List<Product> products = [
    Product(
      name: 'Hạt Điều Rang Muối',
      description:
          'Hạt điều nguyên hạt loại 1, rang củi thủ công đậm đà, giữ trọn vị bùi béo và giòn rụm.',
      price: 150000,
      imageIcon:
          '🥜', // Dùng Emoji thay cho hình ảnh để code chạy nhẹ nhàng không cần assets
    ),
    Product(
      name: 'Kẹo Hạt Điều Như Ý',
      description:
          'Kẹo hạt điều béo ngậy, ngọt thanh, giòn tan. Đóng gói đẹp mắt thích hợp làm quà biếu.',
      price: 85000,
      imageIcon: '🍬',
    ),
    Product(
      name: 'Hạt Điều Tỏi Ớt',
      description:
          'Hạt điều tẩm vị tỏi ớt cay cay mặn mặn, lớp vỏ đậm đà ăn là ghiền.',
      price: 160000,
      imageIcon: '🌶️',
    ),
  ];

  ProductListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Hiển thị thông tin theo yêu cầu bài tập
        title: const Text('Đỗ Nhật Minh - 2224802010354'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Card(
            elevation: 2,
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            child: ListTile(
              leading: Text(
                product.imageIcon,
                style: const TextStyle(fontSize: 32),
              ),
              title: Text(
                product.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                '${product.price.toStringAsFixed(0)} VNĐ',
                style: const TextStyle(color: Colors.red),
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // ĐIỀU HƯỚNG VÀ TRUYỀN DỮ LIỆU
                // Chuyển sang route '/detail' và gửi kèm Object 'product' qua tham số arguments
                Navigator.pushNamed(context, '/detail', arguments: product);
              },
            ),
          );
        },
      ),
    );
  }
}

// 4. Màn hình 2: Chi tiết Sản phẩm
class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // NHẬN DỮ LIỆU
    // Trích xuất arguments từ route hiện tại và ép kiểu về lớp Product
    final product = ModalRoute.of(context)!.settings.arguments as Product;

    return Scaffold(
      appBar: AppBar(
        title: Text('Chi tiết: ${product.name}'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            Text(product.imageIcon, style: const TextStyle(fontSize: 120)),
            const SizedBox(height: 30),
            Text(
              product.name,
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 15),
            Text(
              'Giá bán: ${product.price.toStringAsFixed(0)} VNĐ',
              style: const TextStyle(
                fontSize: 22,
                color: Colors.redAccent,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 25),
            Text(
              product.description,
              style: const TextStyle(fontSize: 16, height: 1.5),
              textAlign: TextAlign.center,
            ),
            const Spacer(), // Đẩy phần tử tiếp theo xuống cuối màn hình
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                icon: const Icon(Icons.shopping_cart),
                label: const Text(
                  'Thêm vào giỏ hàng',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  // Hiển thị thông báo nhỏ khi bấm nút
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Đã thêm ${product.name} vào giỏ hàng!'),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
