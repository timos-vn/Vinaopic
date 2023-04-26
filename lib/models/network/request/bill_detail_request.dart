class BillDetailRequest {
  String? itemCode;
  num? quantity;
  num? price;
  num? voucherPos;
  String? codeStore;

  BillDetailRequest({this.itemCode, this.quantity,this.price,this.voucherPos,this.codeStore});

  BillDetailRequest.fromJson(Map<String, dynamic> json) {
    itemCode = json['ma_vt'];
    quantity = json['so_luong'];
    price = json['gia'];
    voucherPos = json['tl_ck'];
    codeStore = json['ma_kho'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ma_vt'] = this.itemCode;
    data['so_luong'] = this.quantity;
    data['gia'] = this.price;
    data['tl_ck'] = this.voucherPos;
    data['ma_kho'] = this.codeStore;
    return data;
  }
}
