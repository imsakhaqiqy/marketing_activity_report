class ApprovalDisbursmentModel {
  String id;
  String debitur;
  String nomorAkad;
  String plafond;
  String cabang;
  String tanggalAkad;
  String alamat;
  String telepon;
  String noJanji;
  String jenisPencairan;
  String jenisProduk;
  String infoSales;
  String foto1;
  String foto2;
  String foto3;
  String tanggalPencairan;
  String jamPencairan;
  String statusPencairan;
  String namaSales;

  //BUAT CONSTRUCTOR AGAR KETIKA CLASS INI DILOAD, MAKA DATA YANG DIMINTA HARUS DIPASSING SESUAI TIPE DATA YANG DITETAPKAN
  ApprovalDisbursmentModel(
      {this.id,
      this.debitur,
      this.nomorAkad,
      this.plafond,
      this.cabang,
      this.tanggalAkad,
      this.alamat,
      this.telepon,
      this.noJanji,
      this.jenisPencairan,
      this.jenisProduk,
      this.infoSales,
      this.foto1,
      this.foto2,
      this.foto3,
      this.tanggalPencairan,
      this.jamPencairan,
      this.statusPencairan,
      this.namaSales});

  //FUNGSI INI UNTUK MENGUBAH FORMAT DATA DARI JSON KE FORMAT YANG SESUAI DENGAN EMPLOYEE MODEL
  factory ApprovalDisbursmentModel.fromJson(Map<String, dynamic> json) =>
      ApprovalDisbursmentModel(
          id: json['id'],
          debitur: json['debitur'],
          nomorAkad: json['nomor_akad'],
          plafond: json['plafond'],
          cabang: json['cabang'],
          tanggalAkad: json['tanggal_akad'],
          alamat: json['alamat'],
          telepon: json['telepon'],
          noJanji: json['no_janji'],
          jenisPencairan: json['jenis_pencairan'],
          jenisProduk: json['jenis_produk'],
          infoSales: json['info_sales'],
          foto1: json['foto1'],
          foto2: json['foto2'],
          foto3: json['foto3'],
          tanggalPencairan: json['tgl_pencairan'],
          jamPencairan: json['jam_pencairan'],
          statusPencairan: json['status_pencairan'],
          namaSales: json['nama_sales']);
}
