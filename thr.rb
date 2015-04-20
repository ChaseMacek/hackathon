require "csv"
def my_replace column, old_value, new_value
   return column.gsub!(old_value, new_value) if column
end

old_file = CSV.open("texas_health.csv")
new_file = CSV.open("thr_corrected.csv", "w")
line = old_file.readline
newline = Array.new
line.each do |item|
  newline.push (item.downcase)
end
new_file << newline
new_file.close
old_file.close

contents = CSV.open "texas_health.csv", headers: true, header_converters: :symbol
contents.each do |row|

  specialty = row[:specialty_1]
  specialty2 = row[:specialty_2] || " "
  specialty3 = row[:specialty_3] || " "
  specialty4 = row[:specialty_4] || " "
  specialty5 = row[:specialty_5] || " "

if row[:sponsor_specialty_1] && row[:sponsor_specialty_1].length > 0
  row[:specialty_1] = row[:sponsor_specialty_1]
  row[:specialty_2] = row[:sponsor_specialty_2]
  row[:specialty_3] = row[:sponsor_specialty_3]
  row[:specialty_4] = row[:sponsor_specialty_4]
  row[:sponsor_specialty_1] = ""
  row[:sponsor_specialty_2] = ""
  row[:sponsor_specialty_3] = ""
  row[:sponsor_specialty_4] = ""
  row[:sponsor_specialty_5] = ""
end

  specialty_correction = specialty
  specialty_correction2 = specialty2
  specialty_correction3 = specialty3
  specialty_correction4 = specialty4
  specialty_correction5 = " "

  [ row[:specialty_1], row[:specialty_2], row[:specialty_3], row[:specialty_4]].each do |obj|
   my_replace obj, /Cardiovascular Disease/, "Cardiology"
   my_replace obj, /Orthopaedic Surgery/, "Orthopedic Surgery"
   my_replace obj, /Neurological Surgery/, "Neurology"
   my_replace obj, /Gynecology\/ Oncology/, "Obstetrician and Gynecology "
   my_replace obj, /Hospice & Palliative Medicine/, "Hospice Care and Palliative Medicine "
   my_replace obj, /Cardiac Electrophysiology/, "Clinical Cardiac Electrophysiology "
   my_replace obj, /Clinical Clinical Cardiac Electrophysiology/, "Clinical Cardiac Electrophysiology "
   my_replace obj, /Breast Care\/Surgical Oncologist/, "Gynecologic Oncology"
   my_replace obj, /Pulmonary\/Critical Care/, "Pulmonology"
   my_replace obj, /Endocrinology \/ Metabolism, Internal Medicine/, "Diabetes, Endocrinology and Metabolism"
   my_replace obj, /Thoracic and Cardiovascular Surgery/, "Cardiothoracic Surgery"
   my_replace obj, /Pain Management Medicine/, "Pain Medicine"
   my_replace obj, /Podiatric Surgery/, "Podiatry"
   my_replace obj, /Surgery of the Hand/, "Hand Surgery"
   my_replace obj, /Reproductive Endocrinology\/Infertility/, "Infertility and Reproductive Endocrinology"
   my_replace obj, /Family Medicine and OMT/, "Family Medicine"
   my_replace obj, /Joint Replacement/, "Joint Replacement Surgery"
   my_replace obj, /Joint Replacement Surgery Surgery/, "Joint Replacement Surgery"
  end

 row.delete(:sponsor_specialty_5)
 row.delete(:sponsor_specialty_4)
 row.delete(:sponsor_specialty_3)
 row.delete(:sponsor_specialty_2)
 row.delete(:sponsor_specialty_1)

  CSV.open("thr_corrected.csv", "a+") do |csv|
    csv << row
  end
end
