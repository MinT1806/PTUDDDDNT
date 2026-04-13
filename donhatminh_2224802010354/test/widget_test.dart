// This is a basic Flutter widget test for the Shopping App.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

// ignore: unused_import
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// Đảm bảo đường dẫn import này khớp với tên project của bạn
import 'package:donhatminh_2224802010354/main.dart';

void main() {
  testWidgets('Shopping App UI and Navigation smoke test', (
    WidgetTester tester,
  ) async {
    // 1. Build ứng dụng và trigger frame đầu tiên.
    // Lưu ý: Gọi đúng tên class gốc của ứng dụng là ShoppingApp thay vì MyApp
    await tester.pumpWidget(const ShoppingApp());

    // 2. Kiểm tra xem AppBar có hiển thị đúng thông tin sinh viên không.
    expect(find.text('Đỗ Nhật Minh - 2224802010354'), findsOneWidget);

    // 3. Kiểm tra xem sản phẩm đầu tiên có được hiển thị trên màn hình danh sách không.
    expect(find.text('Hạt Điều Rang Muối'), findsOneWidget);

    // Đảm bảo nút "Thêm vào giỏ hàng" chưa xuất hiện ở màn hình này
    expect(find.text('Thêm vào giỏ hàng'), findsNothing);

    // 4. Giả lập hành động nhấn (tap) vào sản phẩm 'Hạt Điều Rang Muối'.
    await tester.tap(find.text('Hạt Điều Rang Muối'));

    // Đợi cho hiệu ứng chuyển trang (navigation animation) hoàn tất.
    await tester.pumpAndSettle();

    // 5. Kiểm tra xem ứng dụng đã chuyển sang màn hình Chi tiết thành công chưa.
    // Tìm tiêu đề của trang chi tiết
    expect(find.text('Chi tiết: Hạt Điều Rang Muối'), findsOneWidget);

    // Nút "Thêm vào giỏ hàng" giờ đây phải xuất hiện
    expect(find.text('Thêm vào giỏ hàng'), findsOneWidget);
  });
}
