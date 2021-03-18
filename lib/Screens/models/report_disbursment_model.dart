class ReportDisbursmentModel {
  String id;
  String tanggalPencairan;
  String cabang;
  String nomorAkad;
  String debitur;
  String plafond;
  String alamat;
  String tanggalAkad;
  String telepon;
  String noJanji;
  String jenisPencairan;
  String jenisProduk;
  String infoSales;
  String foto1;
  String foto2;
  String foto3;
  String jamPencairan;
  String namaSales;
  String namaTl;
  String jabatanTl;
  String teleponTl;

  //BUAT CONSTRUCTOR AGAR KETIKA CLASS INI DILOAD, MAKA DATA YANG DIMINTA HARUS DIPASSING SESUAI TIPE DATA YANG DITETAPKAN
  ReportDisbursmentModel(
      {this.id,
      this.tanggalPencairan,
      this.cabang,
      this.nomorAkad,
      this.debitur,
      this.plafond,
      this.alamat,
      this.tanggalAkad,
      this.telepon,
      this.noJanji,
      this.jenisPencairan,
      this.jenisProduk,
      this.infoSales,
      this.foto1,
      this.foto2,
      this.foto3,
      this.jamPencairan,
      this.namaSales,
      this.namaTl,
      this.jabatanTl,
      this.teleponTl});

  //FUNGSI INI UNTUK MENGUBAH FORMAT DATA DARI JSON KE FORMAT YANG SESUAI DENGAN EMPLOYEE MODEL
  factory ReportDisbursmentModel.fromJson(Map<String, dynamic> json) =>
      ReportDisbursmentModel(
          id: json['id'],
          tanggalPencairan: json['tanggal_pencairan'],
          cabang: json['cabang'],
          nomorAkad: json['nomor_akad'],
          debitur: json['debitur'],
          plafond: json['plafond'],
          alamat: json['alamat'],
          tanggalAkad: json['tgl_akad'],
          telepon: json['telepon'],
          noJanji: json['no_janji'],
          jenisPencairan: json['jenis_pencairan'],
          jenisProduk: json['jenis_produk'],
          infoSales: json['info_sales'],
          foto1: json['foto1'],
          foto2: json['foto2'],
          foto3: json['foto3'],
          jamPencairan: json['jam_pencairan'],
          namaSales: json['namasales'],
          namaTl: json['nama_tl'],
          jabatanTl: json['jabatan_tl'],
          teleponTl: json['telepon_tl']);
}
