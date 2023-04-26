class UpdateOrderRequest {
  String? sttRec;
  String? image;
  List<UpdateOrderRequestDetail>? detail;
  CqDetail? cqDetail;

  UpdateOrderRequest({this.sttRec, this.image, this.detail, this.cqDetail});

  UpdateOrderRequest.fromJson(Map<String?, dynamic> json) {
    sttRec = json['stt_rec'];
    image = json['image'];
    if (json['detail'] != null) {
      detail =  <UpdateOrderRequestDetail>[];
      json['detail'].forEach((v) {
        detail?.add(new UpdateOrderRequestDetail.fromJson(v));
      });
    }
    cqDetail = json['cqDetail'] != null
        ? new CqDetail.fromJson(json['cqDetail'])
        : null;
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['stt_rec'] = this.sttRec;
    data['image'] = this.image;
    if (this.detail != null) {
      data['detail'] = this.detail?.map((v) => v.toJson()).toList();
    }
    if (this.cqDetail != null) {
      data['cqDetail'] = this.cqDetail?.toJson();
    }
    return data;
  }
}

class UpdateOrderRequestDetail {
  int? soLuong;
  num? giaNt2;
  num? tlCk;
  String? maVt;
  String? maKho;

  UpdateOrderRequestDetail({this.soLuong, this.giaNt2, this.tlCk, this.maVt, this.maKho});

  UpdateOrderRequestDetail.fromJson(Map<String?, dynamic> json) {
    soLuong = json['so_luong'];
    giaNt2 = json['gia_nt2'];
    tlCk = json['tl_ck'];
    maVt = json['ma_vt'];
    maKho = json['ma_kho'];
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['so_luong'] = this.soLuong;
    data['gia_nt2'] = this.giaNt2;
    data['tl_ck'] = this.tlCk;
    data['ma_vt'] = this.maVt;
    data['ma_kho'] = this.maKho;
    return data;
  }
}

class CqDetail {
  double? cqMpCau = 0;
  double? cqMpTru = 0;
  double? cqMpTruc = 0;
  double? cqMpCong = 0;
  double? cqMpTl = 0;
  double? cqMtCau = 0;
  double? cqMtTru = 0;
  double? cqMtTruc = 0;
  double? cqMtCong = 0;
  double? cqMtTl = 0;
  double? cqMpKcDt = 0;
  double? cqMtKcDt = 0;
  double? cqMpKcDtXa = 0;
  int? cqNx = 0;
  int? cqNg = 0;
  int? cqNt = 0;
  int? kg1t = 0;
  int? kgNt = 0;
  int? kgMd = 0;
  int? kgHm = 0;
  int? kgPla = 0;
  int? kgPc = 0;
  int? kgMau = 0;
  int? kgDm = 0;
  int? kgGlas = 0;
  int? kg2t = 0;

  CqDetail(
      {this.cqMpCau,
        this.cqMpTru,
        this.cqMpTruc,
        this.cqMpCong,
        this.cqMpTl,
        this.cqMtCau,
        this.cqMtTru,
        this.cqMtTruc,
        this.cqMtCong,
        this.cqMtTl,
        this.cqMpKcDt,
        this.cqMtKcDt,
        this.cqMpKcDtXa,
        this.cqNx,
        this.cqNg,
        this.cqNt,
        this.kg1t,
        this.kgNt,
        this.kgMd,
        this.kgHm,
        this.kgPla,
        this.kgPc,
        this.kgMau,
        this.kgDm,this.kgGlas,this.kg2t});

  CqDetail.fromJson(Map<String?, dynamic> json) {
    cqMpCau = json['cq_mp_cau'];
    cqMpTru = json['cq_mp_tru'];
    cqMpTruc = json['cq_mp_truc'];
    cqMpCong = json['cq_mp_cong'];
    cqMpTl = json['cq_mp_tl'];
    cqMtCau = json['cq_mt_cau'];
    cqMtTru = json['cq_mt_tru'];
    cqMtTruc = json['cq_mt_truc'];
    cqMtCong = json['cq_mt_cong'];
    cqMtTl = json['cq_mt_tl'];
    cqMpKcDt = json['cq_mp_kc_dt'];
    cqMtKcDt = json['cq_mt_kc_dt'];
    cqMpKcDtXa = json['cq_mp_kc_dt_xa'];
    cqNx = json['cq_nx'];
    cqNg = json['cq_ng'];
    cqNt = json['cq_nt'];
    kg1t = json['kg_1t'];
    kgNt = json['kg_nt'];
    kgMd = json['kg_md'];
    kgHm = json['kg_hm'];
    kgPla = json['kg_pla'];
    kgPc = json['kg_pc'];
    kgMau = json['kg_mau'];
    kgDm = json['kg_dm']; kgGlas = json['kg_glas'];kg2t = json['kg_2t'];
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['cq_mp_cau'] = this.cqMpCau;
    data['cq_mp_tru'] = this.cqMpTru;
    data['cq_mp_truc'] = this.cqMpTruc;
    data['cq_mp_cong'] = this.cqMpCong;
    data['cq_mp_tl'] = this.cqMpTl;
    data['cq_mt_cau'] = this.cqMtCau;
    data['cq_mt_tru'] = this.cqMtTru;
    data['cq_mt_truc'] = this.cqMtTruc;
    data['cq_mt_cong'] = this.cqMtCong;
    data['cq_mt_tl'] = this.cqMtTl;
    data['cq_mp_kc_dt'] = this.cqMpKcDt;
    data['cq_mt_kc_dt'] = this.cqMtKcDt;
    data['cq_mp_kc_dt_xa'] = this.cqMpKcDtXa;
    data['cq_nx'] = this.cqNx;
    data['cq_ng'] = this.cqNg;
    data['cq_nt'] = this.cqNt;
    data['kg_1t'] = this.kg1t;
    data['kg_nt'] = this.kgNt;
    data['kg_md'] = this.kgMd;
    data['kg_hm'] = this.kgHm;
    data['kg_pla'] = this.kgPla;
    data['kg_pc'] = this.kgPc;
    data['kg_mau'] = this.kgMau;
    data['kg_dm'] = this.kgDm;data['kg_glas'] = this.kgGlas;data['kg_2t'] = this.kg2t;
    return data;
  }
}