class PipelineModel {
  String id;
  String tglPipeline;
  String namaNasabah;
  String alamat;
  String telepon;
  String jenisProduk;
  String plafond;
  String cabang;
  String keterangan;
  String status;

  //BUAT CONSTRUCTOR AGAR KETIKA CLASS INI DILOAD, MAKA DATA YANG DIMINTA HARUS DIPASSING SESUAI TIPE DATA YANG DITETAPKAN
  PipelineModel(
      {this.id,
      this.tglPipeline,
      this.namaNasabah,
      this.alamat,
      this.telepon,
      this.jenisProduk,
      this.plafond,
      this.cabang,
      this.keterangan,
      this.status});

  //FUNGSI INI UNTUK MENGUBAH FORMAT DATA DARI JSON KE FORMAT YANG SESUAI DENGAN EMPLOYEE MODEL
  factory PipelineModel.fromJson(Map<String, dynamic> json) => PipelineModel(
      id: json['id'],
      tglPipeline: json['tgl_pipeline'],
      namaNasabah: json['cadeb'],
      alamat: json['alamat'],
      telepon: json['telepon'],
      jenisProduk: json['jenis_produk'],
      plafond: json['nominal'],
      cabang: json['cabang'],
      keterangan: json['keterangan'],
      status: json['status']);
}
