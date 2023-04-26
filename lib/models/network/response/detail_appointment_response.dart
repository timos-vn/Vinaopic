class DetailAppointmentResponse {
  List<DetailAppointmentResponseData>? data;
  int? statusCode;
  String? message;

  DetailAppointmentResponse({this.data, this.statusCode, this.message});

  DetailAppointmentResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <DetailAppointmentResponseData>[];
      json['data'].forEach((v) {
        data?.add(new DetailAppointmentResponseData.fromJson(v));
      });
    }
    statusCode = json['status_code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data?.map((v) => v.toJson()).toList();
    }
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    return data;
  }
}

class DetailAppointmentResponseData {
  String? ngayDatKham;
  String? ngayKham;
  String? sttRec;
  String? maKh;
  String? tenKh;
  String? tenBs;
  String? coSoKham;
  String? noiDung;

  DetailAppointmentResponseData(
      {this.ngayDatKham,
        this.ngayKham,
        this.sttRec,
        this.maKh,
        this.tenKh,
        this.tenBs,
        this.coSoKham,
        this.noiDung});

  DetailAppointmentResponseData.fromJson(Map<String, dynamic> json) {
    ngayDatKham = json['ngay_dat_kham'];
    ngayKham = json['ngay_kham'];
    sttRec = json['stt_rec'];
    maKh = json['ma_kh'];
    tenKh = json['ten_kh'];
    tenBs = json['ten_bs'];
    coSoKham = json['co_so_kham'];
    noiDung = json['noi_dung'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ngay_dat_kham'] = this.ngayDatKham;
    data['ngay_kham'] = this.ngayKham;
    data['stt_rec'] = this.sttRec;
    data['ma_kh'] = this.maKh;
    data['ten_kh'] = this.tenKh;
    data['ten_bs'] = this.tenBs;
    data['co_so_kham'] = this.coSoKham;
    data['noi_dung'] = this.noiDung;
    return data;
  }
}

