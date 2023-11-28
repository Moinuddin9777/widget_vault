// import 'dart:convert';
// import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:widget_vault/UI/views/products_screen.dart';
import 'package:widget_vault/UI/widgets/brand_button.dart';
import 'package:widget_vault/UI/widgets/image_selector.dart';
import 'package:widget_vault/controllers/form_controller.dart';
// import 'package:widget_vault/UI/widgets/brand_button.dart';
// import 'package:widget_vault/UI/widgets/brand_card.dart';
import 'package:widget_vault/controllers/home_controller.dart';
// import 'package:widget_vault/brand_model.dart';
import 'package:widget_vault/placeholder_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static HomeController get homeController => Get.find();
  @override
  void initState() {
    homeController.fetchPosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          homeController.fetchPosts();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: GetBuilder<HomeController>(
            init: HomeController(),
            builder: (homeInstance) {
              return ListView.builder(
                  itemCount: homeInstance.postsData.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading:
                          Text(homeInstance.postsData[index].id.toString()),
                      title:
                          Text(homeInstance.postsData[index].title ?? "Null"),
                      subtitle:
                          Text(homeInstance.postsData[index].body ?? "No data"),
                    );
                  });
            },
          ),
        ),
      ),
    );
  }
}

class TabGrid extends StatelessWidget {
  const TabGrid({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    return Column(
      children: [
        GetBuilder<HomeController>(
          builder: (homeInstance) {
            return Row(
              children: [
                TextFormField(
                  controller: nameController,
                  onSaved: (newValue) {
                    homeInstance.addNameToList(newValue ?? "nullName");
                  },
                ),
                Text(
                  nameController.text,
                  style: const TextStyle(fontSize: 24),
                ),
                // Text(
                //     "This is some text that goes along with the, This is some text that goes along with the , This is some text that goes along with the  ")
              ],
            );
          },
        ),
        // Expanded(
        //   child: GridView.builder(
        //       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        //           crossAxisCount: 6),
        //       itemCount: brandList.length,
        //       itemBuilder: (context, index) {
        //         return BrandCard(
        //             // brandName: brandList[index].title,
        //             assetLink: brandList[index].imageUrl);
        //       }),
        // ),
      ],
    );
  }
}

class MobileGrid extends StatelessWidget {
  const MobileGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverAppBar(title: Text('SaiLakshmis First App')),
        SliverToBoxAdapter(
          child: SizedBox(
            width: 200,
            height: 100,
            child: Card(
              elevation: 7,
              color: Colors.amber,
              child: Column(
                children: [
                  const Text('Latest Products Available'),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const ProductsPage(
                                  pageName: "Products",
                                )));
                      },
                      child: const Text('Explore'))
                ],
              ),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: brandsData.length,
            (context, index) =>
                // Container(
                //           color: Colors.blueGrey,
                //           width: 30,
                //           height: 30,
                //         )
                BrandButton(
                    brandName: brandsData[index].title,
                    imageUrl: brandsData[index].imageUrl),
          ),
        )
      ],
    );
  }
}

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<HomeController>(HomeController());
  }
}

class FormsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<FormController>(FormController());
  }
}

// class MyFormValidation {
//   static nameValidation(String? value) {
//     if (value == null || value.isEmpty) {
//       return "This field cannot be empty";
//     }
//   }
// }

class FormWithValidation extends StatefulWidget {
  const FormWithValidation({Key? key}) : super(key: key);

  @override
  _FormWithValidationState createState() => _FormWithValidationState();
}

class _FormWithValidationState extends State<FormWithValidation> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  String selectedGender = 'Male';
  List<String> selectedHobbies = <String>[];
  DateTime selectedDate = DateTime.now();
  // XFile? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form with Validation'),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              DropdownButtonFormField<String>(
                value: selectedGender,
                items: const [
                  DropdownMenuItem(child: Text('Male'), value: 'Male'),
                  DropdownMenuItem(child: Text('Female'), value: 'Female'),
                  DropdownMenuItem(child: Text('Other'), value: 'Other'),
                ],
                onChanged: (value) {
                  setState(() {
                    selectedGender = value!;
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Gender',
                ),
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: selectedHobbies.contains('Reading'),
                        onChanged: (value) {
                          setState(() {
                            if (value!) {
                              selectedHobbies.add('Reading');
                            } else {
                              selectedHobbies.remove('Reading');
                            }
                          });
                        },
                      ),
                      const Text('Reading'),
                    ],
                  ),
                  const SizedBox(width: 16.0),
                  Row(
                    children: [
                      Checkbox(
                        value: selectedHobbies.contains('Sports'),
                        onChanged: (value) {
                          setState(() {
                            if (value!) {
                              selectedHobbies.add('Sports');
                            } else {
                              selectedHobbies.remove('Sports');
                            }
                          });
                        },
                      ),
                      const Text('Sports'),
                    ],
                  ),
                  const SizedBox(width: 16.0),
                  Row(
                    children: [
                      Checkbox(
                        value: selectedHobbies.contains('Music'),
                        onChanged: (value) {
                          setState(() {
                            if (value!) {
                              selectedHobbies.add('Music');
                            } else {
                              selectedHobbies.remove('Music');
                            }
                          });
                        },
                      ),
                      const Text('Music'),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              ImageSelectorField(
                  question: "Take A selfie",
                  isRequired: true,
                  onSaved: (val) {
                    print(val);
                  }),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    print('Form submitted successfully!');
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
