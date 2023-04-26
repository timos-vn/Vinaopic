class AppointmentSchedule {
  List<AppointmentScheduleData>? data;
  int? statusCode;
  String? message;

  AppointmentSchedule({this.data, this.statusCode, this.message});

  AppointmentSchedule.fromJson(Map<String?, dynamic> json) {
    if (json['data'] != null) {
      data = <AppointmentScheduleData>[];
      json['data'].forEach((v) {
        data?.add(new AppointmentScheduleData.fromJson(v));
      });
    }
    statusCode = json['status_code'];
    message = json['message'];
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    if (this.data != null) {
      data['data'] = this.data?.map((v) => v.toJson()).toList();
    }
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    return data;
  }
}

class AppointmentScheduleData {
  String? detail;
  String? tenKh;
  String? tenNvbh;
  String? tenBs;
  String? tenKtv;
  String? sttKham;
  String? soKham;
  String? diaChi;
  String? dienThoai;
  bool? khamYn;
  String? ngaySinh;
  int? age;
  int? gioiTinh;
  String? email;
  String? statusPrev;
  String? statusnamePrev;
  String? sttRec;
  String? maDvcs;
  String? soCt;
  String? ngayCt;
  String? maKh;
  String? maNvbh;
  String? dienGiai;
  int? tSoLuong;
  double? tCk;
  double? tTien;
  int? status;
  String? statusname;

  AppointmentScheduleData(
      {this.detail,
        this.tenKh,
        this.tenNvbh,
        this.tenBs,
        this.tenKtv,
        this.sttKham,
        this.soKham,
        this.diaChi,
        this.dienThoai,
        this.khamYn,
        this.ngaySinh,
        this.age,
        this.gioiTinh,
        this.email,
        this.statusPrev,
        this.statusnamePrev,
        this.sttRec,
        this.maDvcs,
        this.soCt,
        this.ngayCt,
        this.maKh,
        this.maNvbh,
        this.dienGiai,
        this.tSoLuong,
        this.tCk,
        this.tTien,
        this.status,
        this.statusname});

  AppointmentScheduleData.fromJson(Map<String?, dynamic> json) {
    detail = json['detail'];
    tenKh = json['ten_kh'];
    tenNvbh = json['ten_nvbh'];
    tenBs = json['ten_bs'];
    tenKtv = json['ten_ktv'];
    sttKham = json['stt_kham'];
    soKham = json['so_kham'];
    diaChi = json['dia_chi'];
    dienThoai = json['dien_thoai'];
    khamYn = json['kham_yn'];
    ngaySinh = json['ngay_sinh'];
    age = json['age'];
    gioiTinh = json['gioi_tinh'];
    email = json['email'];
    statusPrev = json['status_prev'];
    statusnamePrev = json['statusname_prev'];
    sttRec = json['stt_rec'];
    maDvcs = json['ma_dvcs'];
    soCt = json['so_ct'];
    ngayCt = json['ngay_ct'];
    maKh = json['ma_kh'];
    maNvbh = json['ma_nvbh'];
    dienGiai = json['dien_giai'];
    tSoLuong = json['t_so_luong'];
    tCk = json['t_ck'];
    tTien = json['t_tien'];
    status = json['status'];
    statusname = json['statusname'];
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['detail'] = this.detail;
    data['ten_kh'] = this.tenKh;
    data['ten_nvbh'] = this.tenNvbh;
    data['ten_bs'] = this.tenBs;
    data['ten_ktv'] = this.tenKtv;
    data['stt_kham'] = this.sttKham;
    data['so_kham'] = this.soKham;
    data['dia_chi'] = this.diaChi;
    data['dien_thoai'] = this.dienThoai;
    data['kham_yn'] = this.khamYn;
    data['ngay_sinh'] = this.ngaySinh;
    data['age'] = this.age;
    data['gioi_tinh'] = this.gioiTinh;
    data['email'] = this.email;
    data['status_prev'] = this.statusPrev;
    data['statusname_prev'] = this.statusnamePrev;
    data['stt_rec'] = this.sttRec;
    data['ma_dvcs'] = this.maDvcs;
    data['so_ct'] = this.soCt;
    data['ngay_ct'] = this.ngayCt;
    data['ma_kh'] = this.maKh;
    data['ma_nvbh'] = this.maNvbh;
    data['dien_giai'] = this.dienGiai;
    data['t_so_luong'] = this.tSoLuong;
    data['t_ck'] = this.tCk;
    data['t_tien'] = this.tTien;
    data['status'] = this.status;
    data['statusname'] = this.statusname;
    return data;
  }
}

