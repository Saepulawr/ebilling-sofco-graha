class ModelCustomerAll {
  bool? status;
  String? message;
  Data? data;
  int? total;

  ModelCustomerAll({this.status, this.message, this.data, this.total});

  ModelCustomerAll.fromJson(Map<String, dynamic> json) {
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
  List<TCustomer>? tCustomer;

  Data({this.tCustomer});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['t_customer'] != null) {
      tCustomer = [];
      json['t_customer'].forEach((v) {
        tCustomer!.add(new TCustomer.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.tCustomer != null) {
      data['t_customer'] = this.tCustomer!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TCustomer {
  String? id;
  String? nama;
  String? alamat;
  String? pic;
  String? email;
  String? telp;

  TCustomer({this.id, this.nama, this.alamat, this.pic, this.email, this.telp});

  TCustomer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
    alamat = json['alamat'];
    pic = json['pic'];
    email = json['email'];
    telp = json['telp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama'] = this.nama;
    data['alamat'] = this.alamat;
    data['pic'] = this.pic;
    data['email'] = this.email;
    data['telp'] = this.telp;
    return data;
  }
}
