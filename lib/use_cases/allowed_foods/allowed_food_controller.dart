import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heart_rate/use_cases/allowed_foods/food_model.dart';
import 'package:heart_rate/utils/app_constants.dart';
import 'package:heart_rate/utils/hive_repo.dart';


import '../../utils/custom_button.dart';
import '../../utils/custom_text_form_field.dart';

class AllowedFoodController extends GetxController {
  @override
  void onInit() {
    getAllAllowedFoods();
    super.onInit();
  }
  getAllAllowedFoods() async {
    allowedFood=  allowedFoodRepo.getAllEntities();
update();
  }
  final allowedFoodRepo =
      LocalEntityRepository(AppConstants.allowedFoodBoxName);
  final formKey=GlobalKey<FormState>();
  TextEditingController foodNameController=TextEditingController();
late List<Food> allowedFood;
  addFoodDialog(BuildContext context,double width,double height) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              content: Form(
            key: formKey,
            child: SizedBox(
              width: width,
              child: ListView(
                shrinkWrap: true,
                children: [
                  Text(
                    "Add new food",
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium!
                        .copyWith(color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                  CustomTextFormField(
                    context: context,
                    label: "Food",
                    labelColor: Colors.black,
                    color: Colors.grey.shade400,
                    controller: foodNameController,
                    validator: (value) {
                      if (foodNameController.text.isEmpty) {
                        return "this field cannot be empty";
                      }
                      return null;
                    },
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomButton(
                        useGradient: false,
                        height: height * 0.03,
                        width: width,
                        onPressed: () {
                          addFood(Food(key: Random().nextInt(9999999).toString(), name: foodNameController.text));

                        getAllAllowedFoods();
                        foodNameController.clear();
                        Get.back();
                        },
                        label: "Add new Food"),
                  ),
                ],
              ),
            ),
          ));
        });
  }
removeFood(String id) async {
await allowedFoodRepo.deleteData(id);
getAllAllowedFoods();
}
  addFood(Food food) async {
    await allowedFoodRepo.createOrUpdate(food);
  }
}
