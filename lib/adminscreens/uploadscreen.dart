import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prochef/adminscreens/adminhome.dart';
import 'package:prochef/functions/dbRecipe.dart';
import 'package:prochef/models/recipe.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  var mealCategory = [
    'Category',
    'Main Course',
    'Starter',
    'Refreshing',
    'Soup',
    'Side Dish',
    'Salad',
    'Chineese',
  ];
  var dropdownValue = 'Category';

  var mealType = ['Veg', 'Non-Veg'];
  late String typeMeal;

  var servingCount = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10+'];
  var countValue = 'Serving Count';

  var durationValue = ['<15 min', '<30 min', '< 1 hr', '>1 Hr'];
  var defaultDuration = 'Cooking time';

  late String meals;

  late Box recipeBox;

  final _nameController = TextEditingController();

  final _categoryController = TextEditingController();

  final _typeController = TextEditingController();

  final _servingsController = TextEditingController();

  final _ingrediantsController = TextEditingController();

  final _directionsController = TextEditingController();

  final _decscriptionController = TextEditingController();

  final _durationController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String? imagepath;

  @override
  void initState() {
    super.initState();
    Hive.openBox<RecipeModel>('recipe');
    createBox();
  }

  void createBox() async {
    recipeBox = await Hive.openBox<RecipeModel>('recipe');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(),
      child: Scaffold(
        backgroundColor: Color.fromRGBO(158, 158, 158, 1),
        appBar: AppBar(
          title: const Text('Upload Recipe'),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.01),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 35, right: 35),
                      child: Column(
                        children: [
                          Form(
                            child: Column(
                              key: _formKey,
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  controller: _nameController,
                                  style: const TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(
                                      Icons.food_bank_outlined,
                                      color: Colors.grey,
                                    ),
                                    fillColor: Colors.grey.shade100,
                                    filled: true,
                                    hintText: "Afgan Biriani",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Recipe name is mandatory';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  height: 49,
                                  width: 340,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: DropdownButtonFormField(
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.category_outlined),
                                    ),
                                    dropdownColor: Colors.grey[300],
                                    value: 'Category',
                                    items: mealCategory
                                        .map(
                                          (String mealCategory) =>
                                              DropdownMenuItem(
                                            value: mealCategory,
                                            child: Text(mealCategory),
                                          ),
                                        )
                                        .toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        dropdownValue = value!;
                                        meals = value;
                                        _categoryController.text = value;
                                      });
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  height: 49,
                                  width: 340,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: DropdownButtonFormField(
                                    decoration: InputDecoration(
                                        prefixIcon:
                                            Icon(Icons.dinner_dining_outlined)),
                                    dropdownColor: Colors.grey[300],
                                    value: 'Veg',
                                    items: mealType
                                        .map(
                                          (String mealType) => DropdownMenuItem(
                                            value: mealType,
                                            child: Text(mealType),
                                          ),
                                        )
                                        .toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        dropdownValue = value!;
                                        typeMeal = value;
                                        _typeController.text = value;
                                      });
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  height: 49,
                                  width: 340,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: DropdownButtonFormField(
                                    decoration: InputDecoration(
                                        prefixIcon:
                                            Icon(Icons.control_point_outlined)),
                                    dropdownColor: Colors.grey[300],
                                    value: '1',
                                    items: servingCount
                                        .map(
                                          (String servingCount) =>
                                              DropdownMenuItem(
                                            value: servingCount,
                                            child: Text(servingCount),
                                          ),
                                        )
                                        .toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        dropdownValue = value!;
                                        countValue = value;
                                        _servingsController.text = value;
                                      });
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  height: 49,
                                  width: 340,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: DropdownButtonFormField(
                                    decoration: InputDecoration(
                                        prefixIcon:
                                            Icon(Icons.control_point_outlined)),
                                    dropdownColor: Colors.grey[300],
                                    value: '<15 min',
                                    items: durationValue
                                        .map(
                                          (String durationValue) =>
                                              DropdownMenuItem(
                                            value: durationValue,
                                            child: Text(durationValue),
                                          ),
                                        )
                                        .toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        dropdownValue = value!;
                                        defaultDuration = value;
                                        _durationController.text = value;
                                      });
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  controller: _decscriptionController,
                                  style: const TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                      prefixIcon: const Icon(Icons.abc),
                                      fillColor: Colors.grey.shade100,
                                      filled: true,
                                      hintText: "Description",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      )),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Discription is mandatory';
                                    } else {
                                      return null;
                                    }
                                  },
                                  maxLines: 2,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  controller: _ingrediantsController,
                                  style: const TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.abc),
                                      fillColor: Colors.grey.shade100,
                                      filled: true,
                                      hintText: "Ingrediants",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      )),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Ingrediants is mandatory';
                                    } else {
                                      return null;
                                    }
                                  },
                                  maxLines: 5,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  controller: _directionsController,
                                  style: const TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.abc),
                                    fillColor: Colors.grey.shade100,
                                    filled: true,
                                    hintText: "Directions",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Directions is mandatory';
                                    } else {
                                      return null;
                                    }
                                  },
                                  maxLines: 5,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(0),
                                  child: Stack(children: [
                                    SizedBox(
                                      height: 300,
                                      width: 300,
                                      child: Container(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: imagepath == null
                                                  ? const AssetImage(
                                                      'assets/logo/noimage.png',
                                                    ) as ImageProvider
                                                  : FileImage(
                                                      File(imagepath!),
                                                    ),
                                            ),
                                          ),
                                        ),
                                        //color: Colors.white,
                                      ),
                                    ),
                                    Positioned(
                                      child: InkWell(
                                          child: Container(
                                            height: 300,
                                            width: 300,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                //<-- SEE HERE
                                                width: 2,
                                              ),
                                            ),
                                            child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: 295, top: 280),
                                                child: Text('')),
                                          ),
                                          onTap: () {
                                            takePhoto();
                                          }),
                                    ),
                                  ]),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Add Recipe',
                                      style: TextStyle(
                                          fontSize: 27,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.grey[700]),
                                    ),
                                    CircleAvatar(
                                      radius: 30,
                                      backgroundColor: Color(0xff4c505b),
                                      child: IconButton(
                                          color: Colors.white,
                                          onPressed: () {
                                            if (imagepath != null &&
                                                _categoryController
                                                    .text.isNotEmpty &&
                                                _decscriptionController
                                                    .text.isNotEmpty &&
                                                _directionsController
                                                    .text.isNotEmpty &&
                                                _ingrediantsController
                                                    .text.isNotEmpty &&
                                                _nameController
                                                    .text.isNotEmpty &&
                                                _typeController
                                                    .text.isNotEmpty &&
                                                _servingsController
                                                    .text.isNotEmpty) {
                                              recipeAddSnackBar();

                                              onAddRecipeButtonClicked(context);

                                              Navigator.of(context)
                                                  .pushAndRemoveUntil(
                                                      MaterialPageRoute(
                                                          builder: (ctx) =>
                                                              const AdminHome()),
                                                      (route) => false);
                                            } else {
                                              showSnackBar();
                                            }
                                          },
                                          icon: const Icon(
                                            Icons.arrow_forward,
                                          )),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> takePhoto() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        imagepath = pickedFile.path;
      });
    }
  }

  Future<void> onAddRecipeButtonClicked(BuildContext context) async {
    final name = _nameController.text.trim();
    final category = _categoryController.text.trim();
    final type = _typeController.text.trim();
    final servings = _servingsController.text.trim();
    final ingrediants = _ingrediantsController.text.trim();
    final directions = _directionsController.text.trim();
    final discription = _directionsController.text.trim();
    final duration = _durationController.text.trim();

    if (name.isEmpty ||
        category.isEmpty ||
        type.isEmpty ||
        servings.isEmpty ||
        ingrediants.isEmpty ||
        discription.isEmpty ||
        discription.isEmpty ||
        category.isEmpty) {
      return;
    }

    final recipe = RecipeModel(
        image: imagepath!,
        name: name,
        type: type,
        servings: servings,
        category: category,
        ingrediants: ingrediants,
        directions: directions,
        description: discription,
        duration: duration,
        isVisible: true);

    uploadRecipe(recipe);
  }

  showSnackBar() {
    var errMsg = "";

    if (imagepath == null &&
        _nameController.text.isEmpty &&
        _categoryController.text.isEmpty &&
        _typeController.text.isEmpty &&
        _servingsController.text.isEmpty &&
        _ingrediantsController.text.isEmpty &&
        _directionsController.text.isEmpty &&
        _decscriptionController.text.isEmpty) {
      errMsg = "Please Insert Valid Data In All Fields ";
    } else if (imagepath == null) {
      errMsg = "Please Select An Image to Continue";
    } else if (_nameController.text.isEmpty) {
      errMsg = "Recipe name  Must Be Filled";
    } else if (_categoryController.text.isEmpty) {
      errMsg = "Category  Must Be Selected";
    } else if (_typeController.text.isEmpty) {
      errMsg = "Type Must Be Selected";
    } else if (_ingrediantsController.text.isEmpty) {
      errMsg = "Ingrediants must be filled";
    } else if (_directionsController.text.isEmpty) {
      errMsg = "Directions Must Be Selected";
    } else if (_servingsController.text.isEmpty) {
      errMsg = "Servings count Must Be Selected";
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.red,
        margin: const EdgeInsets.all(10.0),
        content: Text(errMsg),
      ),
    );
  }

  void recipeAddSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.blueGrey,
        content: Text('Recipe Uploaded '),
      ),
    );
  }
}
