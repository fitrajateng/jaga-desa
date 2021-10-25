require 'csv'
require 'fileutils'
require 'net/http'

CSV.foreach("jateng.csv") do |row|
  puts "#{row[3]} #{row[6]}"
  uri = URI("https://jaga.id/api/v5/desa/detil_anggaran?kode=#{row[3]}&tahun=#{row[6]}")
  api = Net::HTTP.get_response(uri)
  FileUtils.mkdir_p "jateng/raw/#{row[3]}" unless File.exists? "jateng/raw/#{row[3]}"
  File.open("jateng/raw/#{row[3]}/#{row[6]}.json", "w") do |f|
    f.write api.body
  end
end