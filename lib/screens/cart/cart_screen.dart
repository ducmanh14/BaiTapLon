import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:confetti/confetti.dart';
import '../../providers/cart_provider.dart';
import 'order_success_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late ConfettiController _confettiController;
  final TextEditingController _noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 3));
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Giỏ hàng"),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          cart.items.isEmpty
              ? const Center(child: Text("Hãy cho tôi thêm đồ ăn 🐧"))
              : Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cart.items.length,
                  itemBuilder: (context, index) {
                    final item = cart.items[index];
                    return ListTile(
                      title: Text(item["name"]),
                      subtitle: Text(
                          "${item["price"]}.000đ x ${item["quantity"]}"),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => cart.removeItem(index),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Tổng tiền: ${cart.totalPrice}.000đ",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Số lượng món: ${cart.totalItems}",
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 16),

                    // Ghi chú của khách hàng
                    TextField(
                      controller: _noteController,
                      decoration: InputDecoration(
                        labelText: "Ghi chú cho cửa hàng (tùy chọn)",
                        hintText: "Ví dụ: Ít cay, thêm sốt, giao giờ trưa...",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        prefixIcon: const Icon(Icons.note_alt_outlined),
                      ),
                      maxLines: 2,
                    ),
                    const SizedBox(height: 16),

                    // Nút thanh toán
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          if (cart.items.isEmpty) return;

                          showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: const Text("Xác nhận thanh toán"),
                              content: Text(
                                "Tổng tiền: ${cart.totalPrice}.000đ\n"
                                    "Ghi chú: ${_noteController.text.isEmpty ? "(Không có)" : _noteController.text}\n\n"
                                    "Bạn có chắc muốn thanh toán không?",
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(ctx),
                                  child: const Text("Hủy"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    final note = _noteController.text;
                                    final total = cart.totalPrice;
                                    final items = List<Map<String, dynamic>>.from(cart.items);

                                    cart.clearCart();
                                    _noteController.clear();

                                    Navigator.pop(ctx);
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => OrderSuccessScreen(
                                          totalPrice: total,
                                          note: note,
                                          items: items,
                                        ),
                                      ),
                                    );
                                  },
                                  child: const Text("Đồng ý"),
                                ),

                              ],
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 40),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        child: const Text(
                          "Thanh toán",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
