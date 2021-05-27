import 'package:e_billing/module/login/model/ModelLogin.dart' as modelLogin;
import 'package:e_billing/module/customer/model/ModelCustomerAll.dart'
    as modelCustomer;

class ModelQuotationAll {
  bool? status;
  String? message;
  Data? data;
  int? total;

  ModelQuotationAll({this.status, this.message, this.data, this.total});

  ModelQuotationAll.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['total'] = this.total;
    return data;
  }
}

class Data {
  List<TQuotation>? tQuotation;

  Data({this.tQuotation});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['t_quotation'] != null) {
      tQuotation = [];
      json['t_quotation'].forEach((v) {
        tQuotation!.add(new TQuotation.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.tQuotation != null) {
      data['t_quotation'] = this.tQuotation!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TQuotation {
  String? id;
  String? tanggal;
  String? nomor;
  modelLogin.Data? idUser;
  modelCustomer.TCustomer? idCustomer;
  String? karyawan;
  String? training;
  String? implementasi;
  String? modifikasi;
  String? hashid;
  String? sign;
  String? signdate;
  TQuotation(
      {this.id,
      this.tanggal,
      this.nomor,
      this.idUser,
      this.idCustomer,
      this.karyawan,
      this.training,
      this.implementasi,
      this.modifikasi});

  TQuotation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tanggal = json['tanggal'];
    nomor = json['nomor'];
    idUser = json['id_user'] != null
        ? new modelLogin.Data.fromJson(json['id_user'])
        : null;
    idCustomer = json['id_customer'] != null
        ? new modelCustomer.TCustomer.fromJson(json['id_customer'])
        : null;
    karyawan = json['karyawan'];
    training = json['training'];
    implementasi = json['implementasi'];
    modifikasi = json['modifikasi'];
    hashid = json['hashid'];
    sign = json['sign'];
    signdate = json['signdate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tanggal'] = this.tanggal;
    data['nomor'] = this.nomor;
    if (this.idUser != null) {
      data['id_user'] = this.idUser!.toJson();
    }
    if (this.idCustomer != null) {
      data['id_customer'] = this.idCustomer!.toJson();
    }
    data['karyawan'] = this.karyawan;
    data['training'] = this.training;
    data['implementasi'] = this.implementasi;
    data['modifikasi'] = this.modifikasi;
    return data;
  }
}
