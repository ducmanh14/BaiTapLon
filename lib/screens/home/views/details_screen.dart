import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_app/components/macro.dart';
import 'package:food_repository/food_repository.dart';
class DetailsScreen extends StatelessWidget {
  final Food food;
  const DetailsScreen(this.food, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width - (40),
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(3, 3),
                    blurRadius: 5,
                  )
                ],
                image: DecorationImage(
                    image:AssetImage(
                      food.picture
                    ),
                )
              ),
            ),
            SizedBox(height: 30,),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(3, 3),
                    blurRadius: 5,
                  )
                ]
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            food.name,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "${food.price - (food.price * (food.discount) / 100).round()}.000₫",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).colorScheme.primary
                                  ),
                                ),
                                Text(
                                  "${food.price}.000₫",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.grey.shade400,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12,),
                    Row(
                      children: [
                        MyMacroWidget(
                          title: 'Calories',
                          value: food.macros.calories.toInt(),
                          icon: FontAwesomeIcons.fire,
                        ),
                        SizedBox(width: 10,),
                        MyMacroWidget(
                          title: 'Protein',
                          value: food.macros.proteins.toInt(),
                          icon: FontAwesomeIcons.dumbbell,
                        ),
                        SizedBox(width: 10,),
                        MyMacroWidget(
                          title: 'Fat',
                          value: food.macros.fat.toInt(),
                          icon: FontAwesomeIcons.oilWell,
                        ),
                        SizedBox(width: 10,),
                        MyMacroWidget(
                          title: 'Carbs',
                          value: food.macros.carbs.toInt(),
                          icon: FontAwesomeIcons.breadSlice,
                        ),
                      ],
                    ),
                    SizedBox(height: 15,),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: TextButton(
                          onPressed:(){

                          },
                          style: TextButton.styleFrom(
                              elevation: 3.0,
                              backgroundColor: Colors.orange[600],
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)
                              )
                          ),
                          child: Text(
                            'Buy Now',
                            style:TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
