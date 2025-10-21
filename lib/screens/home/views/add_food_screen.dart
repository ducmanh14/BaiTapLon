import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddFoodScreen extends StatefulWidget {
  const AddFoodScreen({super.key});

  @override
  State<AddFoodScreen> createState() => _AddFoodScreenState();
}

class _AddFoodScreenState extends State<AddFoodScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _discountController = TextEditingController();
  final _imageController = TextEditingController();
  final _descriptionController = TextEditingController();

  final _caloriesController = TextEditingController();
  final _proteinsController = TextEditingController();
  final _fatController = TextEditingController();
  final _carbsController = TextEditingController();

  bool _isVeg = true;
  int _spicy = 0; // 0 = không cay, 1 = vừa cay, 2 = cay nhiều

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      final docRef = FirebaseFirestore.instance.collection("foods").doc();

      await docRef.set({
        "foodId": docRef.id,
        "name": _nameController.text.trim(),
        "price": int.tryParse(_priceController.text) ?? 0,
        "discount": int.tryParse(_discountController.text) ?? 0,
        "picture": "assets/${_imageController.text.trim()}",
        "description": _descriptionController.text.trim(),
        "isVeg": _isVeg,
        "spicy": _spicy,
        "macros": {
          "calories": double.tryParse(_caloriesController.text) ?? 0,
          "proteins": double.tryParse(_proteinsController.text) ?? 0,
          "fat": double.tryParse(_fatController.text) ?? 0,
          "carbs": double.tryParse(_carbsController.text) ?? 0,
        },
        "createdAt": FieldValue.serverTimestamp(),
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("🎉 Đã thêm món ăn thành công!"),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(" Lỗi khi thêm món: $e"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Thêm món ăn mới"),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: "Tên món ăn",
                  border: OutlineInputBorder(),
                ),
                validator: (v) => v!.isEmpty ? "Nhập tên món" : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(
                  labelText: "Giá (VNĐ)",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (v) => v!.isEmpty ? "Nhập giá" : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _discountController,
                decoration: const InputDecoration(
                  labelText: "Giảm giá (%)",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _imageController,
                decoration: const InputDecoration(
                  labelText: "Ảnh (vd: bul.png)",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: "Mô tả món ăn",
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              SwitchListTile(
                title: const Text("Rau"),
                value: _isVeg,
                onChanged: (v) => setState(() => _isVeg = v),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<int>(
                value: _spicy,
                decoration: const InputDecoration(
                  labelText: "Độ cay",
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: 0, child: Text("Không cay")),
                  DropdownMenuItem(value: 1, child: Text("Vừa cay")),
                  DropdownMenuItem(value: 2, child: Text("Cay nhiều")),
                ],
                onChanged: (v) => setState(() => _spicy = v!),
              ),
              const SizedBox(height: 16),
              const Text(
                "Thông tin dinh dưỡng (Macros)",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _caloriesController,
                      decoration: const InputDecoration(
                        labelText: "Calories",
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextFormField(
                      controller: _proteinsController,
                      decoration: const InputDecoration(
                        labelText: "Protein (g)",
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _fatController,
                      decoration: const InputDecoration(
                        labelText: "Fat (g)",
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextFormField(
                      controller: _carbsController,
                      decoration: const InputDecoration(
                        labelText: "Carbs (g)",
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Center(
                child: ElevatedButton.icon(
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.symmetric(
                      vertical: 14,
                      horizontal: 40,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: const Icon(Icons.add, color: Colors.white),
                  label: const Text(
                    "Thêm món ăn",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
