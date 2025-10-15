import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/screens/auth/blocs/sing_in_bloc/sign_in_bloc.dart';
import 'package:food_app/screens/home/blocs/get_food_bloc/get_food_bloc.dart';
import 'package:food_app/screens/home/views/details_screen.dart';
import 'package:provider/provider.dart';
import '../../../providers/cart_provider.dart';
import '../../cart/cart_screen.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Row(
          children: [
            Image.asset('assets/logo1.png', scale: 6),
            const SizedBox(width: 8),
            const Text(
              'Buger Queen',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 27),
            )
          ],
        ),
        actions: [
          Consumer<CartProvider>(
            builder: (context, cart, child) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart_outlined),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const CartScreen()),
                      );
                    },
                  ),
                  if (cart.totalItems > 0)
                    Positioned(
                      right: 6,
                      top: 6,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          cart.totalItems.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),

          IconButton(
              onPressed: () {
                context.read<SignInBloc>().add(SignOutRequired());
              },
              icon: const Icon(CupertinoIcons.arrow_right_to_line)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<GetFoodBloc, GetFoodState>(
          builder: (context, state) {
            if(state is GetFoodSuccess) {
              return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 16, mainAxisSpacing: 16, childAspectRatio: 9 / 16),
                  itemCount: state.foods.length,
                  itemBuilder: (context, int i) {
                    return Material(
                      elevation: 3,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) => DetailsScreen(
                                  state.foods[i]
                              ),
                            ),
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 18,),
                            Image.asset(state.foods[i].picture),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12.0),
                              child: Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: state.foods[i].isVeg
                                            ? Colors.green
                                            : Colors.red,
                                        borderRadius: BorderRadius.circular(30)
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                                      child: Text(
                                        state.foods[i].isVeg
                                            ? "🥬 VEG"
                                            : "NON-VEG",
                                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10),
                                      ),
                                    ),
                                  ),
                                   SizedBox(width: 10,),
                                  Container(
                                    decoration: BoxDecoration(color: Colors.green.withOpacity(0.2), borderRadius: BorderRadius.circular(30)),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                                      child: Text(
                                        state.foods[i].spicy == 1
                                            ? "🌶️ BLAND"
                                            : state.foods[i].spicy == 2
                                            ? "🌶️ BALANCE"
                                            : "🌶️ SPICY",
                                        style: TextStyle(
                                            color: state.foods[i].spicy == 1
                                                ? Colors.green
                                                : state.foods[i].spicy == 2
                                                ? Colors.orange
                                                : Colors.redAccent,
                                            fontWeight: FontWeight.w800,
                                            fontSize: 10
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12.0),
                              child: Text(
                                state.foods[i].name,
                                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12.0),
                              child: Text(
                                state.foods[i].description,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "${state.foods[i].price - (state.foods[i].price * (state.foods[i].discount) / 100).round()}.000₫",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Theme.of(context).colorScheme.primary,
                                              fontWeight: FontWeight.w700
                                          ),
                                        ),
                                      ],
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        final item = {
                                          "name": state.foods[i].name,
                                          "price": (state.foods[i].price -
                                              (state.foods[i].price * (state.foods[i].discount / 100))).round(),
                                        };

                                        // Thêm vào giỏ hàng
                                        context.read<CartProvider>().addToCart(item);

                                      },
                                      icon: const Icon(CupertinoIcons.add_circled_solid),
                                    ),
                                  ],
                                )
                            ),
                            Padding(
                                padding: EdgeInsets.only(left: 10),
                              child: Row(
                                children: [
                                  Transform(
                                    alignment: Alignment.center,
                                    transform: Matrix4.rotationY(3.1416),
                                    child: Icon(
                                      Icons.local_offer_outlined,
                                      size: 20,
                                      color: Colors.blue.shade400,
                                    ),
                                  ),
                                  SizedBox(width: 5,),
                                  Text(
                                    "${state.foods[i].price}.000₫",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey.shade400,
                                      fontWeight: FontWeight.w700,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }
              );
            } else if(state is GetFoodLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return const Center(
                child: Text(
                    "An error has occured..."
                ),
              );
            }
          },
        ),
      ),
    );
  }
}