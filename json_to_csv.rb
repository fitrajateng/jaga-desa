require 'json'
require 'csv'

CSV.open('jateng/csv/dana_jateng.csv', 'w') do |csv|
  csv << [
    'kode_PUM', 'provinsi', 'kabupaten_kota', 'kecamatan', 'desa_kelurahan', 'tahun', 'pagu', 'total_penyaluran',
    'penyaluran_1_realisasi', 'penyaluran_1_tanggal_realisasi', 'penyaluran_2_realisasi', 'penyaluran_2_tanggal_realisasi',
    'penyaluran_3_realisasi', 'penyaluran_3_tanggal_realisasi', 'detail_penyerapan'
  ]
  Dir.glob('jateng/raw/**/*').each do |file|
    puts file
    if File.file?(file)
      result = JSON.parse(File.read(file), symbolize_names: true)
      if result[:success]
        records = result[:data][:result]
        records.each do |record|
          csv << [
            record[:kode_PUM], record[:provinsi], record[:kabupaten_kota], record[:kecamatan], record[:desa_kelurahan], file.split('/').last.gsub('.json', ''), record[:pagu], record[:total_penyaluran],
            record[:penyaluran][:'1'][:realisasi], record[:penyaluran][:'1'][:tanggal_realisasi], record[:penyaluran][:'2'][:realisasi], record[:penyaluran][:'2'][:tanggal_realisasi],
            record[:penyaluran][:'3'][:realisasi], record[:penyaluran][:'3'][:realisasi], file
          ]
        end
      end
    end
  end
end