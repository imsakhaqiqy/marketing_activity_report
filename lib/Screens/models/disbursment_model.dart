class DisbursmentModel {
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
  String statusBayar;
  String approvalSl;
  String namaTl;
  String jabatanTl;
  String teleponTl;
  String namaSales;
  String statusKredit;
  String pengelolaPensiun;
  String idPipeline;

  //BUAT CONSTRUCTOR AGAR KETIKA CLASS INI DILOAD, MAKA DATA YANG DIMINTA HARUS DIPASSING SESUAI TIPE DATA YANG DITETAPKAN
  DisbursmentModel(
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
      this.statusBayar,
      this.approvalSl,
      this.namaTl,
      this.jabatanTl,
      this.teleponTl,
      this.namaSales,
      this.statusKredit,
      this.pengelolaPensiun,
      this.idPipeline});

  //FUNGSI INI UNTUK MENGUBAH FORMAT DATA DARI JSON KE FORMAT YANG SESUAI DENGAN EMPLOYEE MODEL
  factory DisbursmentModel.fromJson(Map<String, dynamic> json) =>
      DisbursmentModel(
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
          statusBayar: json['status_bayar'],
          approvalSl: json['approval_sl'],
          namaTl: json['nama_tl'],
          jabatanTl: json['jabatan_tl'],
          teleponTl: json['telepon_tl'],
          namaSales: json['namasales'],
          statusKredit: json['status_kredit'],
          pengelolaPensiun: json['pengelola_pensiun'],
          idPipeline: json['id_pipeline']);
}
