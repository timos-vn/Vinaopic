class ItemScan {
  ItemScanData? data;
  int? statusCode;
  String? message;

  ItemScan({this.data, this.statusCode, this.message});

  ItemScan.fromJson(Map<String?, dynamic> json) {
    data = json['data'] != null ? new ItemScanData.fromJson(json['data']) : null;
    statusCode = json['status_code'];
    message = json['message'];
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    if (this.data != null) {
      data['data'] = this.data?.toJson();
    }
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    return data;
  }
}

class ItemScanData {
  String? dvt;
  num? soLuong;
  String? maKho;
  int? heSo;
  num? gia;
  num? tlCk;
  num? stock;
  String? imageUrl;
  String? nuocSx;
  String? maVt;
  String? tenVt;
  String? nhVt1;
  String? nhVt2;
  String? nhVt3;
  int? status;
  String? brand;
  String? color;
  num? eyeSize;
  num? bridgeSize;

  ItemScanData(
      {this.dvt,
        this.soLuong,
        this.maKho,
        this.heSo,
        this.gia,
        this.tlCk,
        this.stock,
        this.imageUrl,
        this.nuocSx,
        this.maVt,
        this.tenVt,
        this.nhVt1,
        this.nhVt2,
        this.nhVt3,
        this.status,
        this.brand,
        this.color,
        this.eyeSize,
        this.bridgeSize});

  ItemScanData.fromJson(Map<String?, dynamic> json) {
    dvt = json['dvt'];
    soLuong = json['so_luong'];
    maKho = json['ma_kho'];
    heSo = json['he_so'];
    gia = json['gia'];
    tlCk = json['tl_ck'];
    stock = json['stock'];
    imageUrl = json['image_url'];
    nuocSx = json['nuoc_sx'];
    maVt = json['ma_vt'];
    tenVt = json['ten_vt'];
    nhVt1 = json['nh_vt1'];
    nhVt2 = json['nh_vt2'];
    nhVt3 = json['nh_vt3'];
    status = json['status'];
    brand = json['brand'];
    color = json['color'];
    eyeSize = json['eye_size'];
    bridgeSize = json['bridge_size'];
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['dvt'] = this.dvt;
    data['so_luong'] = this.soLuong;
    data['ma_kho'] = this.maKho;
    data['he_so'] = this.heSo;
    data['gia'] = this.gia;
    data['tl_ck'] = this.tlCk;
    data['stock'] = this.stock;
    data['image_url'] = this.imageUrl;
    data['nuoc_sx'] = this.nuocSx;
    data['ma_vt'] = this.maVt;
    data['ten_vt'] = this.tenVt;
    data['nh_vt1'] = this.nhVt1;
    data['nh_vt2'] = this.nhVt2;
    data['nh_vt3'] = this.nhVt3;
    data['status'] = this.status;
    data['brand'] = this.brand;
    data['color'] = this.color;
    data['eye_size'] = this.eyeSize;
    data['bridge_size'] = this.bridgeSize;
    return data;
  }
}