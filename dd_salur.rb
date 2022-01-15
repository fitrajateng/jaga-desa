require 'json'
require 'csv'


CSV.open('jateng/csv/dd_salur_jateng.csv', 'w') do |csv|
  csv << [
    'kode_PUM', 'provinsi', 'kabupaten_kota', 'kecamatan', 'desa_kelurahan', 'tahun', 'pagu', 'total_penyaluran',
    'tahap_salur', 'dd_salur_realisasi', 'dd_salur_tanggal'
  ]
  Dir.glob('jateng/raw/**/*').each do |file|
    puts file
    if File.file?(file)
      result = JSON.parse(File.read(file), symbolize_names: true)
      if result[:success]
        records = result[:data][:result]
        records.each do |record|
          penyaluran = record[:penyaluran]
          penyaluran.each do |tahap_salur, dd_salur|
            # puts tahap_salur
            dd_salur_realisasi = dd_salur[:realisasi]
            dd_salur_tanggal = dd_salur[:tanggal_realisasi]
            
            csv << [
              record[:kode_PUM], record[:provinsi], record[:kabupaten_kota], record[:kecamatan], record[:desa_kelurahan], file.split('/').last.gsub('.json', ''), record[:pagu], record[:total_penyaluran],
              tahap_salur, dd_salur_realisasi, dd_salur_tanggal
            ]          
          end        
        end
      end
    end
  end
end