class Product {
  String? productname;
  int? productprice;
  int? productstock;
  String? find;
  int? serachprice;
  Product(String productname, int productprice, int productstock) {
    this.productname = productname;
    this.productprice = productprice;
    this.productstock = productstock;
  }
  printproductnameandprice() {
    print('Product:$productname, Price:$productprice');
  }

  printproductlistforadmin() {
    print('Product:$productname, Price:$productprice,stock:$productstock');
  }

  printalphabetserach(serachalphabet) {
    this.find = serachalphabet;
    if (productname!.startsWith(serachalphabet)) {
      print('Product:$productname, Price:$productprice');
    }
  }

  admintoupdate(toupdateproduct) {
    String? newproductname;
    int? newproductprice;
    int? newproductstock;
    this.find = toupdateproduct;
    if (productname!.startsWith(toupdateproduct)) {
      this.productname = newproductname;
      this.productprice = newproductprice;
      this.productstock = newproductstock;
    }
  }

  printpriceserach(serachprice) {
    this.serachprice = serachprice;
    if (productprice! <= serachprice) {
      print('Product:$productname, Price:$productprice');
    }
  }

  minussaledquantity(int? quantity) {
    this.productstock = (this.productstock! - quantity!);
  }

  addingquantity(int? editgquantity) {
    this.productstock = editgquantity;
  }

  changename(String? name) {
    this.productname = name;
  }

  changeprice(int? price) {
    this.productprice = price;
  }

  changestock(int? stock) {
    this.productstock = stock;
  }
}
