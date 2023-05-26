import 'package:flutter/material.dart';
import 'package:prochef/commonscreens/categoryfeeds.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  int index1 = 0;
  List category = [
    'Starter',
    'Refreshing',
    'Soup',
    'Side Dish',
    'Salad',
    'Main Course',
    'Vegetarian'
  ];

  List type = ['Veg', 'Non-Veg'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      //drawer: showDrawer(context),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu),
        ),
        title: const Text('Categories'),
        centerTitle: true,
        actions: [],
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Container(
                      height: 10,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(255, 185, 185, 255),
                              offset: Offset(1, 1),
                              blurRadius: 7,
                            )
                          ],
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 50,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => CategoryFeeds(
                                  categoryChoosen: category[index],
                                ),
                              ));
                            },
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(2),
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(),
                                      color: Colors.black),
                                  child: Image.asset(
                                    'assets/categories/$index.jpg',
                                    width: 150,
                                  ),
                                )),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            category[index],
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ));
                },
                childCount: 7,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 270,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
