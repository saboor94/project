class Order {
  String? orderproduct;
  int? orderquantity;
  int? productpriceperpack;
  int? productbill;
  Order(orderedproduct, orderedquantity) {
    this.orderproduct = orderedproduct;
    this.orderquantity = orderedquantity;
    this.productpriceperpack;
    this.productbill;
  }
  printorder() {
    print(
        'Ordered Product:"$orderproduct"\nOrdered Quantity "$orderquantity"\nTOTAL:"$orderquantity X $productpriceperpack"="$productbill"');
  }

  changingoldquantity(int? changequantity) {
    this.orderquantity = changequantity;
  }
}
