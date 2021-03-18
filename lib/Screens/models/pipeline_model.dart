class PipelineModel {
  String id;
  String tglPipeline;
  String tempatLahir;
  String tanggalLahir;
  String jenisKelamin;
  String noKtp;
  String npwp;
  String namaNasabah;
  String alamat;
  String telepon;
  String jenisProduk;
  String plafond;
  String cabang;
  String keterangan;
  String status;
  String statusKredit;
  String pengelolaPensiun;
  String bankTakeover;
  String tglPenyerahan;
  String namaPenerima;
  String teleponPenerima;
  String foto1;
  String foto2;

  //BUAT CONSTRUCTOR AGAR KETIKA CLASS INI DILOAD, MAKA DATA YANG DIMINTA HARUS DIPASSING SESUAI TIPE DATA YANG DITETAPKAN
  PipelineModel(
      {this.id,
      this.tglPipeline,
      this.tempatLahir,
      this.tanggalLahir,
      this.jenisKelamin,
      this.noKtp,
      this.npwp,
      this.namaNasabah,
      this.alamat,
      this.telepon,
      this.jenisProduk,
      this.plafond,
      this.cabang,
      this.keterangan,
      this.status,
      this.statusKredit,
      this.pengelolaPensiun,
      this.bankTakeover,
      this.tglPenyerahan,
      this.namaPenerima,
      this.teleponPenerima,
      this.foto1,
      this.foto2});

  //FUNGSI INI UNTUK MENGUBAH FORMAT DATA DARI JSON KE FORMAT YANG SESUAI DENGAN EMPLOYEE MODEL
  factory PipelineModel.fromJson(Map<String, dynamic> json) => PipelineModel(
      id: json['id'],
      tglPipeline: json['tgl_pipeline'],
      tempatLahir: json['tempat_lahir'],
      tanggalLahir: json['tgl_lahir'],
      jenisKelamin: json['jenis_kelamin'],
      noKtp: json['no_ktp'],
      npwp: json['npwp'],
      namaNasabah: json['cadeb'],
      alamat: json['alamat'],
      telepon: json['telepon'],
      jenisProduk: json['jenis_produk'],
      plafond: json['nominal'],
      cabang: json['cabang'],
      keterangan: json['keterangan'],
      status: json['status'],
      statusKredit: json['status_kredit'],
      pengelolaPensiun: json['pengelola_pensiun'],
      bankTakeover: json['bank_takeover'],
      tglPenyerahan: json['tgl_penyerahan'],
      namaPenerima: json['nama_penerima'],
      teleponPenerima: json['telepon_penerima'],
      foto1: json['foto1'],
      foto2: json['foto2']);
}
