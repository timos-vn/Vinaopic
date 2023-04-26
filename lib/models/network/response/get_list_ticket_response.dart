class SearchListTicketResponse {
  List<ListTicket>? listTicket;
  List<TotalPage>? totalPage;
  int? statusCode;
  String? message;

  SearchListTicketResponse(
      {this.listTicket, this.totalPage, this.statusCode, this.message});

  SearchListTicketResponse.fromJson(Map<String, dynamic> json) {
    if (json['listTicket'] != null) {
      listTicket = <ListTicket>[];
      json['listTicket'].forEach((v) {
        listTicket!.add(new ListTicket.fromJson(v));
      });
    }
    if (json['totalPage'] != null) {
      totalPage = <TotalPage>[];
      json['totalPage'].forEach((v) {
        totalPage!.add(new TotalPage.fromJson(v));
      });
    }
    statusCode = json['status_code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.listTicket != null) {
      data['listTicket'] = this.listTicket!.map((v) => v.toJson()).toList();
    }
    if (this.totalPage != null) {
      data['totalPage'] = this.totalPage!.map((v) => v.toJson()).toList();
    }
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    return data;
  }
}

class ListTicket {
  String? sttRec;
  String? maDvcs;
  String? tenDvcs;
  String? deptId;
  String? tenBp;
  String? maKh;
  String? tenKh;
  String? dienThoai;
  String? ngaySinh;
  String? gioiTinh;
  String? gioitinh;
  String? diaChi;
  String? maPhuong;
  String? tenPhuong;
  String? maQuan;
  String? tenQuan;
  String? maTinh;
  String? tenTinh;
  String? status;
  String? statusname;
  String? maBs;
  String? tenBs;
  String? maTvv;
  String? tenTvv;
  String? maKtv;
  String? tenKtv;
  String? ngayCt;

  ListTicket(
      {this.sttRec,
        this.maDvcs,
        this.tenDvcs,
        this.deptId,
        this.tenBp,
        this.maKh,
        this.tenKh,
        this.dienThoai,
        this.ngaySinh,
        this.gioiTinh,
        this.gioitinh,
        this.diaChi,
        this.maPhuong,
        this.tenPhuong,
        this.maQuan,
        this.tenQuan,
        this.maTinh,
        this.tenTinh,
        this.status,
        this.statusname,
        this.maBs,
        this.tenBs,
        this.maTvv,
        this.tenTvv,
        this.maKtv,
        this.tenKtv,this.ngayCt});

  ListTicket.fromJson(Map<String, dynamic> json) {
    sttRec = json['stt_rec'];
    maDvcs = json['ma_dvcs'];
    tenDvcs = json['ten_dvcs'];
    deptId = json['dept_id'];
    tenBp = json['ten_bp'];
    maKh = json['ma_kh'];
    tenKh = json['ten_kh'];
    dienThoai = json['dien_thoai'];
    ngaySinh = json['ngay_sinh'];
    gioiTinh = json['gioi_tinh'];
    gioitinh = json['gioitinh'];
    diaChi = json['dia_chi'];
    maPhuong = json['ma_phuong'];
    tenPhuong = json['ten_phuong'];
    maQuan = json['ma_quan'];
    tenQuan = json['ten_quan'];
    maTinh = json['ma_tinh'];
    tenTinh = json['ten_tinh'];
    status = json['status'];
    statusname = json['statusname'];
    maBs = json['ma_bs'];
    tenBs = json['ten_bs'];
    maTvv = json['ma_tvv'];
    tenTvv = json['ten_tvv'];
    maKtv = json['ma_ktv'];
    tenKtv = json['ten_ktv'];    ngayCt = json['ngayCt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['stt_rec'] = this.sttRec;
    data['ma_dvcs'] = this.maDvcs;
    data['ten_dvcs'] = this.tenDvcs;
    data['dept_id'] = this.deptId;
    data['ten_bp'] = this.tenBp;
    data['ma_kh'] = this.maKh;
    data['ten_kh'] = this.tenKh;
    data['dien_thoai'] = this.dienThoai;
    data['ngay_sinh'] = this.ngaySinh;
    data['gioi_tinh'] = this.gioiTinh;
    data['gioitinh'] = this.gioitinh;
    data['dia_chi'] = this.diaChi;
    data['ma_phuong'] = this.maPhuong;
    data['ten_phuong'] = this.tenPhuong;
    data['ma_quan'] = this.maQuan;
    data['ten_quan'] = this.tenQuan;
    data['ma_tinh'] = this.maTinh;
    data['ten_tinh'] = this.tenTinh;
    data['status'] = this.status;
    data['statusname'] = this.statusname;
    data['ma_bs'] = this.maBs;
    data['ten_bs'] = this.tenBs;
    data['ma_tvv'] = this.maTvv;
    data['ten_tvv'] = this.tenTvv;
    data['ma_ktv'] = this.maKtv;
    data['ten_ktv'] = this.tenKtv;   data['ngayCt'] = this.ngayCt;
    return data;
  }
}

class TotalPage {
  int? pageIndex;
  int? pageSize;
  int? totalRecords;

  TotalPage({this.pageIndex, this.pageSize, this.totalRecords});

  TotalPage.fromJson(Map<String, dynamic> json) {
    pageIndex = json['pageIndex'];
    pageSize = json['PageSize'];
    totalRecords = json['TotalRecords'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pageIndex'] = this.pageIndex;
    data['PageSize'] = this.pageSize;
    data['TotalRecords'] = this.totalRecords;
    return data;
  }
}

