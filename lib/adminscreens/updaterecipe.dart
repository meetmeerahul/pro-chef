import 'dart:core';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prochef/adminscreens/adminhome.dart';

import 'package:prochef/models/recipe.dart';

class UpdateRecipe extends StatefulWidget {
  final int index;
  const UpdateRecipe({
    super.key,
    required this.index,
  });

  @override
  State<UpdateRecipe> createState() => _UpdateRecipeState();
}

class _UpdateRecipeState extends State<UpdateRecipe> {
  late TextEditingController _nameController;
  late TextEditingController _categoryController;
  late TextEditingController _typeController;
  late TextEditingController _servingsController;
  late TextEditingController _ingrediantController;
  late TextEditingController _directionsController;
  late TextEditingController _descriptionController;
  late TextEditingController _durationControler;

  String? name;
  String? category;
  String? type;
  String? serving;
  String? ingrediant;
  String? directions;
  String? description;
  String? duration;

  late Box<RecipeModel> recipeBox;
  late RecipeModel recipeList;

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

  final _formKey = GlobalKey<FormState>();

  String? imagepath;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    recipeBox = Hive.box('recipe');

    _durationControler = TextEditingController();
    _directionsController = TextEditingController();
    _ingrediantController = TextEditingController();
    _descriptionController = TextEditingController();
    _servingsController = TextEditingController();
    _typeController = TextEditingController();
    _categoryController = TextEditingController();
    _nameController = TextEditingController();

    recipeList = recipeBox.getAt(widget.index) as RecipeModel;

    _durationControler.text = recipeList.duration.toString();
    _directionsController.text = recipeList.directions.toString();
    _ingrediantController.text = recipeList.ingrediants.toString();
    _descriptionController.text = recipeList.description.toString();
    _servingsController.text = recipeList.servings.toString();
    _categoryController.text = recipeList.category.toString();
    _nameController.text = recipeList.name.toString();
    _typeController.text = recipeList.type.toString();

    //print(_categoryController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(158, 158, 158, 1),
      appBar: AppBar(title: Text('Edit Recipe')),
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
                                  value: _categoryController.text,
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
                                  value: _typeController.text,
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
                                  value: _servingsController.text,
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
                                  value: _durationControler.text,
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
                                      _durationControler.text = value;
                                    });
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                controller: _descriptionController,
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
                                controller: _ingrediantController,
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
                                    height: 200,
                                    width: 200,
                                    child: Container(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: imagepath == null
                                                ? FileImage(
                                                    File(recipeList.image))
                                                : FileImage(
                                                    File(imagepath ??
                                                        recipeList.image),
                                                  ),
                                          ),
                                        ),
                                      ),
                                      //color: Colors.white,
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 10,
                                    right: 10,
                                    width: 30,
                                    child: InkWell(
                                        child: const Icon(
                                          Icons.add_a_photo_sharp,
                                          size: 30,
                                          color: Colors.black,
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
                                              _descriptionController
                                                  .text.isNotEmpty &&
                                              _directionsController
                                                  .text.isNotEmpty &&
                                              _ingrediantController
                                                  .text.isNotEmpty &&
                                              _nameController.text.isNotEmpty &&
                                              _typeController.text.isNotEmpty &&
                                              _servingsController
                                                  .text.isNotEmpty) {
                                            recipeAddSnackBar();

                                            onRecipeUpdate(widget.index);

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

  showSnackBar() {
    var errMsg = "";

    if (_nameController.text.isEmpty &&
        _categoryController.text.isEmpty &&
        _typeController.text.isEmpty &&
        _servingsController.text.isEmpty &&
        _ingrediantController.text.isEmpty &&
        _directionsController.text.isEmpty &&
        _descriptionController.text.isEmpty) {
      errMsg = "Please Insert Valid Data In All Fields ";
    } else if (_nameController.text.isEmpty) {
      errMsg = "Recipe name  Must Be Filled";
    } else if (_categoryController.text.isEmpty) {
      errMsg = "Category  Must Be Selected";
    } else if (_typeController.text.isEmpty) {
      errMsg = "Type Must Be Selected";
    } else if (_ingrediantController.text.isEmpty) {
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

  Future<void> onRecipeUpdate(int index) async {
    final name = _nameController.text.trim();
    final category = _categoryController.text.trim();
    final ingrediant = _ingrediantController.text.trim();
    final direction = _directionsController.text.trim();
    final description = _descriptionController.text.trim();
    final type = _typeController.text.trim();
    final serving = _servingsController.text.trim();
    final cookingtime = _durationControler.text.trim();

    final recipeUpdate = RecipeModel(
      name: name,
      category: category,
      ingrediants: ingrediant,
      directions: direction,
      description: description,
      type: type,
      servings: serving,
      duration: cookingtime,
      isVisible: true,
      image: imagepath ?? recipeList.image,
    );
    final studentDataB = await Hive.openBox<RecipeModel>('recipe');
    studentDataB.putAt(index, recipeUpdate);
  }
}
