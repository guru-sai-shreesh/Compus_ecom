import 'package:compos_interview/main.dart';
import 'package:compos_interview/model/cart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:toast/toast.dart';

class CartView extends StatefulWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  bool isLoading = false;

  late TextEditingController controller = TextEditingController();

  late Razorpay razorpay;

  @override
  void initState() {
    super.initState();

    razorpay = new Razorpay();

    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    razorpay.clear();
  }

  void openCheckout() {
    var options = {
      "key": "[YOUR_API_KEY]",
      "amount": num.parse(cart.total.toString()) * 100,
      "name": "Sample App",
      "description": "Payment for the some random product",
      "prefill": {"contact": "2323232323", "email": "shdjsdh@gmail.com"},
      "external": {
        "wallets": ["paytm"]
      }
    };

    try {
      razorpay.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

  void handlerPaymentSuccess() {
    print("Pament success");
    Toast.show("Pament success");
  }

  void handlerErrorFailure() {
    print("Pament error");
    Toast.show("Pament error");
  }

  void handlerExternalWallet() {
    print("External Wallet");
    Toast.show("External wallet");
  }

  @override
  Widget build(BuildContext context) {
    double sum = 0;
    return Container(
      color: Colors.grey[300],
      child: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.black),
            title: Text(
              "Compous",
              style: TextStyle(color: Colors.black),
            ),
            elevation: 0.0,
            backgroundColor: Colors.transparent,
          ),
          bottomNavigationBar: Container(
              margin: EdgeInsets.only(left: 15, right: 15, bottom: 14),
              height: 42,
              color: Colors.transparent,
              child: FlatButton(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  onPressed: (() {
                    // Navigator.of(context).push(
                    //     MaterialPageRoute(builder: (context) => Payment()));
                    openCheckout();
                  }),
                  minWidth: MediaQuery.of(context).size.width - 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                          "Proceed to Buy (" +
                              cart.length().toString() +
                              " items)",
                          style: GoogleFonts.openSans(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          )),
                      // Padding(padding: EdgeInsets.only(left: 5)),
                      // Icon(Icons.camera_enhance)
                    ],
                  ))),
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: 20, right: 15, bottom: 5),
                  child: Text("Shopping Cart",
                      style: GoogleFonts.openSans(
                          fontSize: 22,
                          color: Colors.black,
                          fontWeight: FontWeight.w600)),
                ),
                Container(
                  margin:
                      EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 15),
                  height: MediaQuery.of(context).size.height * 0.6,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SingleChildScrollView(
                      child: ListView.builder(
                          // padding:
                          //     EdgeInsets.only(top: 15, left: 15, right: 15),
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: cart.length(),
                          itemBuilder: (context, index) {
                            return Container(
                              height: 90,
                              child: Stack(
                                alignment: Alignment.bottomLeft,
                                children: [
                                  Positioned(
                                    child: Card(
                                      color: Colors.grey,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Container(
                                        margin: EdgeInsets.only(right: 10),
                                        height: 80,
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              height: 80,
                                              width: 70,
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  200,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    cart.get_item(index).title,
                                                    style: GoogleFonts.openSans(
                                                      fontSize: 13,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Text(
                                                    cart
                                                            .get_item(index)
                                                            .price
                                                            .toString() +
                                                        "\$ Elgible for Free delivery",
                                                    style: GoogleFonts.openSans(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.white70,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const Spacer(),
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  if (cart.contains(
                                                      cart.get_item(index))) {
                                                    cart.remove(
                                                        cart.get_item(index));
                                                  } else {
                                                    cart.add_item(
                                                        cart.get_item(index));
                                                  }
                                                });
                                              },
                                              child: Icon(
                                                cart.contains(
                                                        cart.get_item(index))
                                                    ? Icons.remove_circle
                                                    : Icons.remove_circle,
                                                color: cart.contains(
                                                        cart.get_item(index))
                                                    ? Colors.white
                                                    : null,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10)),
                                      ),
                                      elevation: 0,
                                      child: Container(
                                        height: 80,
                                        width: 60,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10),
                                                bottomLeft:
                                                    Radius.circular(10)),
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                  cart.get_item(index).image),
                                              fit: BoxFit.fill,
                                            )),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Row(
                    children: [
                      Text("Subtotal ",
                          style: GoogleFonts.openSans(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w600)),
                      Text(cart.total.toStringAsFixed(2).toString() + "\$",
                          style: GoogleFonts.openSans(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w700)),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
