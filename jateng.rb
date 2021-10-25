require 'csv'

CSV.open("jateng.csv", "w") do |csv|
  CSV.foreach("Desa.csv") do |row|
    if row[0] == 'Jawa Tengah'
      csv << [
        row[0],
        row[1],
        row[2],
        row[3],
        row[4],
        row[5],
        row[6],
        row[7],
        row[8],
      ]
    end
  end
end