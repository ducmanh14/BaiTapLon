import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';

class OrderSuccessScreen extends StatefulWidget {
  final int totalPrice;
  final String note;
  final List<Map<String, dynamic>> items;

  const OrderSuccessScreen({
    super.key,
    required this.totalPrice,
    required this.note,
    required this.items,
  });

  @override
  State<OrderSuccessScreen> createState() => _OrderSuccessScreenState();
}

class _OrderSuccessScreenState extends State<OrderSuccessScreen> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 3));
    _confettiController.play();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.center,
        children: [
          // Hiệu ứng pháo hoa tung văn tóe
          ConfettiWidget(
            confettiController: _confettiController,
            blastDirectionality: BlastDirectionality.explosive,
            emissionFrequency: 0.02, // Tăng tần suất phun (mượt hơn)
            numberOfParticles: 40,   // Nhiều hạt hơn
            gravity: 0.1,            // Bay chậm và nhẹ hơn
            maxBlastForce: 40,       // Lực bắn mạnh hơn chút
            minBlastForce: 20,
            particleDrag: 0.05,      // Giúp chuyển động mượt hơn
            colors: [
              Colors.orange,
              Colors.pink,
              Colors.yellow,
              Colors.lightBlue,
              Colors.green,
            ],
            createParticlePath: (size) {
              // Hạt tròn mềm mại hơn
              final path = Path();
              path.addOval(Rect.fromCircle(center: Offset.zero, radius: 4));
              return path;
            },
          ),


          // Nội dung chính
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.check_circle,
                    color: Colors.green, size: 100),
                const SizedBox(height: 16),
                const Text(
                  "Đặt hàng thành công!",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Burger Queen cảm ơn bạn 💛",
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 24),

                //  Chi tiết đơn hàng
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Tổng tiền: ${widget.totalPrice}.000đ",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "Ghi chú: ${widget.note.isEmpty ? "(Không có)" : widget.note}",
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                //  Danh sách món
                Expanded(
                  child: ListView.builder(
                    itemCount: widget.items.length,
                    itemBuilder: (context, index) {
                      final item = widget.items[index];
                      return ListTile(
                        leading: const Icon(Icons.fastfood, color: Colors.orange),
                        title: Text(item["name"]),
                        subtitle: Text(
                            "${item["price"]}.000đ x ${item["quantity"]}"),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 24),

                // 🔘 Nút quay lại
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 40),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text("Về trang chủ",
                      style: TextStyle(fontSize: 18)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
