class DetailHistoryResponse {
  List<DetailHistoryResponseData>? data;
  int? statusCode;
  String? message;

  DetailHistoryResponse({this.data, this.statusCode, this.message});

  DetailHistoryResponse.fromJson(Map<String?, dynamic> json) {
    if (json['data'] != null) {
      data = <DetailHistoryResponseData>[];
      json['data'].forEach((v) {
        data?.add(new DetailHistoryResponseData.fromJson(v));
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

class DetailHistoryResponseData {
  double? cqMpCau;
  double? cqMpTru;
  double? cqMpTruc;
  double? cqMpCong;
  double? cqMpTl;
  double? cqMtCau;
  double? cqMtTru;
  double? cqMtTruc;
  double? cqMtCong;
  double? cqMtTl;
  double? cqMpKcDt;
  double? cqMtKcDt;
  double? cqMpKcDtXa;
  double? cqMpKcDtGan;
  bool? cqNx;
  bool? cqNg;
  bool? cqNt;
  bool? kg1t;
  bool? kg2t;
  bool? kgNt;
  bool? kgMd;
  bool? kgHm;
  bool? kgPla;
  bool? kgPc;
  bool? kgMau;
  bool? kgDm;
  double? ntMpCauBfr;
  double? ntMpTruBfr;
  double? ntMpTrucBfr;
  double? ntMpCongBfr;
  double? ntMpDeBfr;
  double? ntMpTlBfr;
  double? ntMtCauBfr;
  double? ntMtTruBfr;
  double? ntMtTrucBfr;
  double? ntMtCongBfr;
  double? ntMtDeBfr;
  double? ntMtTlBfr;
  bool? ntTtCyc;
  bool? ntTtAtr;
  bool? ntTtMyd;
  double? ntMpCau;
  double? ntMpTru;
  double? ntMpTruc;
  double? ntMpCong;
  double? ntMpDe;
  double? ntMpTl;
  double? ntMtCau;
  double? ntMtTru;
  double? ntMtTruc;
  double? ntMtCong;
  double? ntMtDe;
  double? ntMtTl;
  double? ntMpKcDt;
  double? ntMtKcDt;
  double? ntKcDtXa;
  double? ntKcDtGan;
  bool? ntNx;
  bool? ntNg;
  bool? ntNt;
  double? atMpCau;
  double? atMpTru;
  double? atMpTruc;
  double? atMpBc;
  double? atMpDia;
  double? atMpTl;
  double? atMtCau;
  double? atMtTru;
  double? atMtTruc;
  double? atMtBc;
  double? atMtDia;
  double? atMtTl;
  double? atMpKcDt;
  double? atMtKcDt;
  double? atKcDtXa;
  double? atKcDtGan;
  bool? atNx;
  bool? atNg;
  bool? atNt;
  bool? atKlMem;
  bool? atKlCung;
  bool? atMmKo;
  bool? atMmCo;
  double? lkMpCau;
  double? lkMpTru;
  double? lkMpTruc;
  double? lkMpCong;
  double? lkMpTl;
  double? lkMpNgang;
  String? lkMpDay1;
  double? lkMpDoc;
  String? lkMpDay2;
  double? lkMtCau;
  double? lkMtTru;
  double? lkMtTruc;
  double? lkMtCong;
  double? lkMtTl;
  double? lkMtNgang;
  String? lkMtDay1;
  double? lkMtDoc;
  String? lkMtDay2;
  double? lkMpKcDt;
  double? lkMtKcDt;
  double? lkKcDtXa;
  double? lkKcDtGan;
  bool? lkNx;
  bool? lkNg;
  bool? lkNt;
  bool? lkNhua;
  bool? lkKl;
  bool? lkGo;
  bool? lkSung;
  bool? lkKhoan;
  bool? lkVanh;
  bool? lkXeCuoc;
  String? lkFrom;
  String? lkBrand;
  String? lkColor;
  double? lmCs;
  String? lmMa;
  String? lmBrand;
  String? lmColor;

  DetailHistoryResponseData(
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
        this.cqMpKcDtGan,
        this.cqNx,
        this.cqNg,
        this.cqNt,
        this.kg1t,
        this.kg2t,
        this.kgNt,
        this.kgMd,
        this.kgHm,
        this.kgPla,
        this.kgPc,
        this.kgMau,
        this.kgDm,
        this.ntMpCauBfr,
        this.ntMpTruBfr,
        this.ntMpTrucBfr,
        this.ntMpCongBfr,
        this.ntMpDeBfr,
        this.ntMpTlBfr,
        this.ntMtCauBfr,
        this.ntMtTruBfr,
        this.ntMtTrucBfr,
        this.ntMtCongBfr,
        this.ntMtDeBfr,
        this.ntMtTlBfr,
        this.ntTtCyc,
        this.ntTtAtr,
        this.ntTtMyd,
        this.ntMpCau,
        this.ntMpTru,
        this.ntMpTruc,
        this.ntMpCong,
        this.ntMpDe,
        this.ntMpTl,
        this.ntMtCau,
        this.ntMtTru,
        this.ntMtTruc,
        this.ntMtCong,
        this.ntMtDe,
        this.ntMtTl,
        this.ntMpKcDt,
        this.ntMtKcDt,
        this.ntKcDtXa,
        this.ntKcDtGan,
        this.ntNx,
        this.ntNg,
        this.ntNt,
        this.atMpCau,
        this.atMpTru,
        this.atMpTruc,
        this.atMpBc,
        this.atMpDia,
        this.atMpTl,
        this.atMtCau,
        this.atMtTru,
        this.atMtTruc,
        this.atMtBc,
        this.atMtDia,
        this.atMtTl,
        this.atMpKcDt,
        this.atMtKcDt,
        this.atKcDtXa,
        this.atKcDtGan,
        this.atNx,
        this.atNg,
        this.atNt,
        this.atKlMem,
        this.atKlCung,
        this.atMmKo,
        this.atMmCo,
        this.lkMpCau,
        this.lkMpTru,
        this.lkMpTruc,
        this.lkMpCong,
        this.lkMpTl,
        this.lkMpNgang,
        this.lkMpDay1,
        this.lkMpDoc,
        this.lkMpDay2,
        this.lkMtCau,
        this.lkMtTru,
        this.lkMtTruc,
        this.lkMtCong,
        this.lkMtTl,
        this.lkMtNgang,
        this.lkMtDay1,
        this.lkMtDoc,
        this.lkMtDay2,
        this.lkMpKcDt,
        this.lkMtKcDt,
        this.lkKcDtXa,
        this.lkKcDtGan,
        this.lkNx,
        this.lkNg,
        this.lkNt,
        this.lkNhua,
        this.lkKl,
        this.lkGo,
        this.lkSung,
        this.lkKhoan,
        this.lkVanh,
        this.lkXeCuoc,
        this.lkFrom,
        this.lkBrand,
        this.lkColor,
        this.lmCs,
        this.lmMa,
        this.lmBrand,
        this.lmColor});

  DetailHistoryResponseData.fromJson(Map<String?, dynamic> json) {
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
    cqMpKcDtGan = json['cq_mp_kc_dt_gan'];
    cqNx = json['cq_nx'];
    cqNg = json['cq_ng'];
    cqNt = json['cq_nt'];
    kg1t = json['kg_1t'];
    kg2t = json['kg_2t'];
    kgNt = json['kg_nt'];
    kgMd = json['kg_md'];
    kgHm = json['kg_hm'];
    kgPla = json['kg_pla'];
    kgPc = json['kg_pc'];
    kgMau = json['kg_mau'];
    kgDm = json['kg_dm'];
    ntMpCauBfr = json['nt_mp_cau_bfr'];
    ntMpTruBfr = json['nt_mp_tru_bfr'];
    ntMpTrucBfr = json['nt_mp_truc_bfr'];
    ntMpCongBfr = json['nt_mp_cong_bfr'];
    ntMpDeBfr = json['nt_mp_de_bfr'];
    ntMpTlBfr = json['nt_mp_tl_bfr'];
    ntMtCauBfr = json['nt_mt_cau_bfr'];
    ntMtTruBfr = json['nt_mt_tru_bfr'];
    ntMtTrucBfr = json['nt_mt_truc_bfr'];
    ntMtCongBfr = json['nt_mt_cong_bfr'];
    ntMtDeBfr = json['nt_mt_de_bfr'];
    ntMtTlBfr = json['nt_mt_tl_bfr'];
    ntTtCyc = json['nt_tt_cyc'];
    ntTtAtr = json['nt_tt_atr'];
    ntTtMyd = json['nt_tt_myd'];
    ntMpCau = json['nt_mp_cau'];
    ntMpTru = json['nt_mp_tru'];
    ntMpTruc = json['nt_mp_truc'];
    ntMpCong = json['nt_mp_cong'];
    ntMpDe = json['nt_mp_de'];
    ntMpTl = json['nt_mp_tl'];
    ntMtCau = json['nt_mt_cau'];
    ntMtTru = json['nt_mt_tru'];
    ntMtTruc = json['nt_mt_truc'];
    ntMtCong = json['nt_mt_cong'];
    ntMtDe = json['nt_mt_de'];
    ntMtTl = json['nt_mt_tl'];
    ntMpKcDt = json['nt_mp_kc_dt'];
    ntMtKcDt = json['nt_mt_kc_dt'];
    ntKcDtXa = json['nt_kc_dt_xa'];
    ntKcDtGan = json['nt_kc_dt_gan'];
    ntNx = json['nt_nx'];
    ntNg = json['nt_ng'];
    ntNt = json['nt_nt'];
    atMpCau = json['at_mp_cau'];
    atMpTru = json['at_mp_tru'];
    atMpTruc = json['at_mp_truc'];
    atMpBc = json['at_mp_bc'];
    atMpDia = json['at_mp_dia'];
    atMpTl = json['at_mp_tl'];
    atMtCau = json['at_mt_cau'];
    atMtTru = json['at_mt_tru'];
    atMtTruc = json['at_mt_truc'];
    atMtBc = json['at_mt_bc'];
    atMtDia = json['at_mt_dia'];
    atMtTl = json['at_mt_tl'];
    atMpKcDt = json['at_mp_kc_dt'];
    atMtKcDt = json['at_mt_kc_dt'];
    atKcDtXa = json['at_kc_dt_xa'];
    atKcDtGan = json['at_kc_dt_gan'];
    atNx = json['at_nx'];
    atNg = json['at_ng'];
    atNt = json['at_nt'];
    atKlMem = json['at_kl_mem'];
    atKlCung = json['at_kl_cung'];
    atMmKo = json['at_mm_ko'];
    atMmCo = json['at_mm_co'];
    lkMpCau = json['lk_mp_cau'];
    lkMpTru = json['lk_mp_tru'];
    lkMpTruc = json['lk_mp_truc'];
    lkMpCong = json['lk_mp_cong'];
    lkMpTl = json['lk_mp_tl'];
    lkMpNgang = json['lk_mp_ngang'];
    lkMpDay1 = json['lk_mp_day1'];
    lkMpDoc = json['lk_mp_doc'];
    lkMpDay2 = json['lk_mp_day2'];
    lkMtCau = json['lk_mt_cau'];
    lkMtTru = json['lk_mt_tru'];
    lkMtTruc = json['lk_mt_truc'];
    lkMtCong = json['lk_mt_cong'];
    lkMtTl = json['lk_mt_tl'];
    lkMtNgang = json['lk_mt_ngang'];
    lkMtDay1 = json['lk_mt_day1'];
    lkMtDoc = json['lk_mt_doc'];
    lkMtDay2 = json['lk_mt_day2'];
    lkMpKcDt = json['lk_mp_kc_dt'];
    lkMtKcDt = json['lk_mt_kc_dt'];
    lkKcDtXa = json['lk_kc_dt_xa'];
    lkKcDtGan = json['lk_kc_dt_gan'];
    lkNx = json['lk_nx'];
    lkNg = json['lk_ng'];
    lkNt = json['lk_nt'];
    lkNhua = json['lk_nhua'];
    lkKl = json['lk_kl'];
    lkGo = json['lk_go'];
    lkSung = json['lk_sung'];
    lkKhoan = json['lk_khoan'];
    lkVanh = json['lk_vanh'];
    lkXeCuoc = json['lk_xe_cuoc'];
    lkFrom = json['lk_from'];
    lkBrand = json['lk_brand'];
    lkColor = json['lk_color'];
    lmCs = json['lm_cs'];
    lmMa = json['lm_ma'];
    lmBrand = json['lm_brand'];
    lmColor = json['lm_color'];
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
    data['cq_mp_kc_dt_gan'] = this.cqMpKcDtGan;
    data['cq_nx'] = this.cqNx;
    data['cq_ng'] = this.cqNg;
    data['cq_nt'] = this.cqNt;
    data['kg_1t'] = this.kg1t;
    data['kg_2t'] = this.kg2t;
    data['kg_nt'] = this.kgNt;
    data['kg_md'] = this.kgMd;
    data['kg_hm'] = this.kgHm;
    data['kg_pla'] = this.kgPla;
    data['kg_pc'] = this.kgPc;
    data['kg_mau'] = this.kgMau;
    data['kg_dm'] = this.kgDm;
    data['nt_mp_cau_bfr'] = this.ntMpCauBfr;
    data['nt_mp_tru_bfr'] = this.ntMpTruBfr;
    data['nt_mp_truc_bfr'] = this.ntMpTrucBfr;
    data['nt_mp_cong_bfr'] = this.ntMpCongBfr;
    data['nt_mp_de_bfr'] = this.ntMpDeBfr;
    data['nt_mp_tl_bfr'] = this.ntMpTlBfr;
    data['nt_mt_cau_bfr'] = this.ntMtCauBfr;
    data['nt_mt_tru_bfr'] = this.ntMtTruBfr;
    data['nt_mt_truc_bfr'] = this.ntMtTrucBfr;
    data['nt_mt_cong_bfr'] = this.ntMtCongBfr;
    data['nt_mt_de_bfr'] = this.ntMtDeBfr;
    data['nt_mt_tl_bfr'] = this.ntMtTlBfr;
    data['nt_tt_cyc'] = this.ntTtCyc;
    data['nt_tt_atr'] = this.ntTtAtr;
    data['nt_tt_myd'] = this.ntTtMyd;
    data['nt_mp_cau'] = this.ntMpCau;
    data['nt_mp_tru'] = this.ntMpTru;
    data['nt_mp_truc'] = this.ntMpTruc;
    data['nt_mp_cong'] = this.ntMpCong;
    data['nt_mp_de'] = this.ntMpDe;
    data['nt_mp_tl'] = this.ntMpTl;
    data['nt_mt_cau'] = this.ntMtCau;
    data['nt_mt_tru'] = this.ntMtTru;
    data['nt_mt_truc'] = this.ntMtTruc;
    data['nt_mt_cong'] = this.ntMtCong;
    data['nt_mt_de'] = this.ntMtDe;
    data['nt_mt_tl'] = this.ntMtTl;
    data['nt_mp_kc_dt'] = this.ntMpKcDt;
    data['nt_mt_kc_dt'] = this.ntMtKcDt;
    data['nt_kc_dt_xa'] = this.ntKcDtXa;
    data['nt_kc_dt_gan'] = this.ntKcDtGan;
    data['nt_nx'] = this.ntNx;
    data['nt_ng'] = this.ntNg;
    data['nt_nt'] = this.ntNt;
    data['at_mp_cau'] = this.atMpCau;
    data['at_mp_tru'] = this.atMpTru;
    data['at_mp_truc'] = this.atMpTruc;
    data['at_mp_bc'] = this.atMpBc;
    data['at_mp_dia'] = this.atMpDia;
    data['at_mp_tl'] = this.atMpTl;
    data['at_mt_cau'] = this.atMtCau;
    data['at_mt_tru'] = this.atMtTru;
    data['at_mt_truc'] = this.atMtTruc;
    data['at_mt_bc'] = this.atMtBc;
    data['at_mt_dia'] = this.atMtDia;
    data['at_mt_tl'] = this.atMtTl;
    data['at_mp_kc_dt'] = this.atMpKcDt;
    data['at_mt_kc_dt'] = this.atMtKcDt;
    data['at_kc_dt_xa'] = this.atKcDtXa;
    data['at_kc_dt_gan'] = this.atKcDtGan;
    data['at_nx'] = this.atNx;
    data['at_ng'] = this.atNg;
    data['at_nt'] = this.atNt;
    data['at_kl_mem'] = this.atKlMem;
    data['at_kl_cung'] = this.atKlCung;
    data['at_mm_ko'] = this.atMmKo;
    data['at_mm_co'] = this.atMmCo;
    data['lk_mp_cau'] = this.lkMpCau;
    data['lk_mp_tru'] = this.lkMpTru;
    data['lk_mp_truc'] = this.lkMpTruc;
    data['lk_mp_cong'] = this.lkMpCong;
    data['lk_mp_tl'] = this.lkMpTl;
    data['lk_mp_ngang'] = this.lkMpNgang;
    data['lk_mp_day1'] = this.lkMpDay1;
    data['lk_mp_doc'] = this.lkMpDoc;
    data['lk_mp_day2'] = this.lkMpDay2;
    data['lk_mt_cau'] = this.lkMtCau;
    data['lk_mt_tru'] = this.lkMtTru;
    data['lk_mt_truc'] = this.lkMtTruc;
    data['lk_mt_cong'] = this.lkMtCong;
    data['lk_mt_tl'] = this.lkMtTl;
    data['lk_mt_ngang'] = this.lkMtNgang;
    data['lk_mt_day1'] = this.lkMtDay1;
    data['lk_mt_doc'] = this.lkMtDoc;
    data['lk_mt_day2'] = this.lkMtDay2;
    data['lk_mp_kc_dt'] = this.lkMpKcDt;
    data['lk_mt_kc_dt'] = this.lkMtKcDt;
    data['lk_kc_dt_xa'] = this.lkKcDtXa;
    data['lk_kc_dt_gan'] = this.lkKcDtGan;
    data['lk_nx'] = this.lkNx;
    data['lk_ng'] = this.lkNg;
    data['lk_nt'] = this.lkNt;
    data['lk_nhua'] = this.lkNhua;
    data['lk_kl'] = this.lkKl;
    data['lk_go'] = this.lkGo;
    data['lk_sung'] = this.lkSung;
    data['lk_khoan'] = this.lkKhoan;
    data['lk_vanh'] = this.lkVanh;
    data['lk_xe_cuoc'] = this.lkXeCuoc;
    data['lk_from'] = this.lkFrom;
    data['lk_brand'] = this.lkBrand;
    data['lk_color'] = this.lkColor;
    data['lm_cs'] = this.lmCs;
    data['lm_ma'] = this.lmMa;
    data['lm_brand'] = this.lmBrand;
    data['lm_color'] = this.lmColor;
    return data;
  }
}

