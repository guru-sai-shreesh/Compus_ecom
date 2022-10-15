import 'package:compos_interview/main.dart';
import 'package:compos_interview/screens/cart_screen.dart';
import 'package:compos_interview/services/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:badges/badges.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final ProductsController productsController = Get.put(ProductsController());
  final List categories = [
    "All",
    "Electronics",
    "Jewelery",
    "Men's clothing",
    "Women's clothing",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        // centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        title: Text(
          "Compus",
          style: TextStyle(color: Colors.black, fontSize: 30),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          IconButton(
              onPressed: () {}, icon: Icon(Icons.notifications_none_outlined)),
          Badge(
            position: BadgePosition.topEnd(top: 3, end: 18),
            animationDuration: Duration(milliseconds: 300),
            animationType: BadgeAnimationType.slide,
            badgeColor: Color.fromARGB(255, 245, 245, 245),
            badgeContent: Text(
              cart.length().toString(),
              style: TextStyle(color: Colors.black),
            ),
            child: IconButton(
                icon: Icon(
                  Icons.shopping_cart,
                  color: Colors.black,
                ),
                padding: EdgeInsets.only(right: 30.0),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => CartView()));
                }),
          ),
          // IconButton(
          //     onPressed: () {
          //       Navigator.of(context)
          //           .push(MaterialPageRoute(builder: (context) => CartView()));
          //     },
          //     icon: Icon(Icons.shopping_cart_outlined)),
        ],
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildCategoriesRow(),
            Expanded(
              child: Obx(
                () {
                  if (productsController.loading.value) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (productsController.products.isEmpty) {
                    return Center(child: Text("No products found"));
                  }
                  return GridView.builder(
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.only(top: 16),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.57,
                    ),
                    itemCount: productsController.products.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          Stack(
                            children: [
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Container(
                                    height: 120,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(productsController
                                            .products[index].image),
                                        // fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Center(
                                child: Container(
                                  height: 155,
                                  width: 145,
                                  decoration: BoxDecoration(
                                      color: Colors.black12,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                ),
                              ),
                              Align(
                                  alignment: Alignment.topRight,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        right: 20, top: 10),
                                    child: Icon(
                                      Icons.favorite_outline_rounded,
                                      color: Colors.black54,
                                    ),
                                  ))
                            ],
                          ),
                          SizedBox(
                            width: 8,
                            height: 3,
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    productsController.products[index].title,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star_half_rounded,
                                        color: Colors.black54,
                                      ),
                                      Text(
                                        productsController
                                                .products[index].rating.rate
                                                .toString() +
                                            " | ",
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Colors.grey[100],
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5))),
                                        child: Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: Text(
                                            productsController.products[index]
                                                    .rating.count
                                                    .toString() +
                                                " sold",
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "\$${productsController.products[index].price}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Center(
                                      child: FlatButton(
                                          height: 35,
                                          color: Colors.grey[300],
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          onPressed: () {
                                            cart.add_item(productsController
                                                .products[index]);
                                            setState(() {});
                                          },
                                          minWidth: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.5 -
                                              100,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text("Add to Cart",
                                                  style: GoogleFonts.openSans(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w600,
                                                  )),
                                              // Padding(padding: EdgeInsets.only(left: 5)),
                                              // Icon(Icons.camera_enhance)
                                            ],
                                          ))),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _buildCategoriesRow() {
    return Container(
      height: 35.0,
      margin: EdgeInsets.only(top: 5, bottom: 5),
      child: ListView.builder(
        itemCount: categories.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => Container(
          margin: EdgeInsets.only(right: 8),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
            ),
            borderRadius: BorderRadius.circular(20.0),
            color: index == 0 ? Colors.black87 : Colors.transparent,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 8.0,
          ),
          child: Text(
            categories[index],
            style: TextStyle(
              color: index == 0 ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
