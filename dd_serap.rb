require 'json'
require 'csv'

CSV.open('jateng/csv/dd_serap_jateng.csv', 'w') do |csv|
  csv << [
    'kode_PUM', 'provinsi', 'kabupaten_kota', 'kecamatan', 'desa_kelurahan', 'tahun', 'tahap_serap',
    'nama_bidang', 'nama_kegiatan', 'sub_kegiatan', 'anggaran', 'realisasi'
  ]
  Dir.glob('jateng/raw/**/*').each do |file|
    if File.file?(file)
      result = JSON.parse(File.read(file), symbolize_names: true)
      if result[:success]
        records = result[:data][:result]
        records.each do |record|
          kode_PUM = record[:kode_PUM]
          provinsi = record[:provinsi]
          kabupaten_kota = record[:kabupaten_kota]
          kecamatan = record[:kecamatan]
          desa_kelurahan = record[:desa_kelurahan]
          penyerapan = record[:penyerapan]
          penyerapan.each do |tahap_serap, bidangs|
            # puts tahap_serap
            bidangs.each do |bidang|
              nama_bidang = bidang[:nama]
              kegiatans = bidang[:kegiatan]
              kegiatans.each do |kegiatan|
                nama_kegiatan = kegiatan[:nama]
                uraians = kegiatan[:uraian]
                uraians.each do |uraian|
                  sub_kegiatan = uraian[:nama]
                  anggaran = uraian[:anggaran]
                  realisasi = uraian[:realisasi]
                  csv << [
                    kode_PUM, provinsi, kabupaten_kota, kecamatan, desa_kelurahan, file.split('/').last.gsub('.json', ''),
                    tahap_serap, nama_bidang, nama_kegiatan, sub_kegiatan, anggaran, realisasi
                  ]                
                end
              end            
            end          
          end
        end      
      end    
    end  
  end
end