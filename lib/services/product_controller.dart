import 'package:compos_interview/model/welcome.dart';
import 'package:get/get.dart';

import 'products_rep.dart';

class ProductsController extends GetxController {
  ProductsRepository productsRepository = ProductsRepository();
  RxBool loading = false.obs;
  late List<Welcome> products;

  ProductsController() {
    loadProductsFromRepo();
  }

  loadProductsFromRepo() async {
    loading(true);
    products =
        welcomeFromJson(await ProductsRepository().loadProductsFromApi());
    print("1");
    loading(false);
  }
}
