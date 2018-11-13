#Installs necessary package csvkit, and its dependencies for downstream processing
sudo apt install csvkit

#Input for user, defines where they want the files to be deposited
echo Where would you like to download the CABIN files? Possible format, mnt/c/Users/Timber\ Gillis/Desktop/
read var1
cd $var1

#Makes two directories, one for raw downloaded data, one for aligned data
#Put the location of your desired directory here. For example, /mnt/c/Users/yournamehere/Desktop
mkdir raw_CABIN_data
mkdir clean_CABIN_data
mkdir matched_CABIN_data

cd raw_CABIN_data

#Maritime Provinces Drainage Area
wget https://cabin-rcba.ec.gc.ca/Cabin/opendata/cabin_benthic_data_mda01_1987-present.csv

#St. Lawrence Drainage Area
wget https://cabin-rcba.ec.gc.ca/Cabin/opendata/cabin_benthic_data_mda02_1987-present.csv

#Northern Quebec and Labrador Drainage Area
wget https://cabin-rcba.ec.gc.ca/Cabin/opendata/cabin_benthic_data_mda03_1987-present.csv

#Southwestern Hudson Bay Drainage Area
wget https://cabin-rcba.ec.gc.ca/Cabin/opendata/cabin_benthic_data_mda04_1987-present.csv

#Nelson River Drainage Area
wget https://cabin-rcba.ec.gc.ca/Cabin/opendata/cabin_benthic_data_mda05_1987-present.csv

#Western and Northern Hudson Bay Drainage Area
wget https://cabin-rcba.ec.gc.ca/Cabin/opendata/cabin_benthic_data_mda06_1987-present.csv

#Great Slave Lake Drainage Area
wget https://cabin-rcba.ec.gc.ca/Cabin/opendata/cabin_benthic_data_mda07_1987-present.csv

#Pacific Drainage Area
wget https://cabin-rcba.ec.gc.ca/Cabin/opendata/cabin_benthic_data_mda08_1987-present.csv

#Yukon River Drainage Area
wget https://cabin-rcba.ec.gc.ca/Cabin/opendata/cabin_benthic_data_mda09_1987-present.csv

#Arctic Drainage Area
wget https://cabin-rcba.ec.gc.ca/Cabin/opendata/cabin_benthic_data_mda10_1987-present.csv

#Mississippi River Drainage Area
wget https://cabin-rcba.ec.gc.ca/Cabin/opendata/cabin_benthic_data_mda11_1987-present.csv

#Maritime Provinces Drainage Area
wget https://cabin-rcba.ec.gc.ca/Cabin/opendata/cabin_habitat_data_mda01_1987-present.csv

#St. Lawrence Drainage Area
wget https://cabin-rcba.ec.gc.ca/Cabin/opendata/cabin_habitat_data_mda02_1987-present.csv

#Northern Quebec and Labrador Drainage Area
wget https://cabin-rcba.ec.gc.ca/Cabin/opendata/cabin_habitat_data_mda03_1987-present.csv

#Southwestern Hudson Bay Drainage Area
wget https://cabin-rcba.ec.gc.ca/Cabin/opendata/cabin_habitat_data_mda04_1987-present.csv

#Nelson River Drainage Area
wget https://cabin-rcba.ec.gc.ca/Cabin/opendata/cabin_habitat_data_mda05_1987-present.csv

#Western and Northern Hudson Bay Drainage Area
wget https://cabin-rcba.ec.gc.ca/Cabin/opendata/cabin_habitat_data_mda06_1987-present.csv

#Great Slave Lake Drainage Area
wget https://cabin-rcba.ec.gc.ca/Cabin/opendata/cabin_habitat_data_mda07_1987-present.csv

#Pacific Drainage Area
wget https://cabin-rcba.ec.gc.ca/Cabin/opendata/cabin_habitat_data_mda08_1987-present.csv

#Yukon River Drainage Area
wget https://cabin-rcba.ec.gc.ca/Cabin/opendata/cabin_habitat_data_mda09_1987-present.csv

#Arctic Drainage Area
wget https://cabin-rcba.ec.gc.ca/Cabin/opendata/cabin_habitat_data_mda10_1987-present.csv

#Mississippi River Drainage Area
wget https://cabin-rcba.ec.gc.ca/Cabin/opendata/cabin_habitat_data_mda11_1987-present.csv

#Maritime Provinces Drainage Area
wget https://cabin-rcba.ec.gc.ca/Cabin/opendata/cabin_study_data_mda01_1987-present.csv

#St. Lawrence Drainage Area
wget https://cabin-rcba.ec.gc.ca/Cabin/opendata/cabin_study_data_mda02_1987-present.csv

#Northern Québec and Labrador Drainage Area
wget https://cabin-rcba.ec.gc.ca/Cabin/opendata/cabin_study_data_mda03_1987-present.csv

#Southwestern Hudson Bay Drainage Area
wget https://cabin-rcba.ec.gc.ca/Cabin/opendata/cabin_study_data_mda04_1987-present.csv

#Nelson River Drainage Area
wget https://cabin-rcba.ec.gc.ca/Cabin/opendata/cabin_study_data_mda05_1987-present.csv

#Western and Northern Hudson Bay Drainage Area
wget https://cabin-rcba.ec.gc.ca/Cabin/opendata/cabin_study_data_mda06_1987-present.csv

#Great Slave Lake Drainage Area
wget https://cabin-rcba.ec.gc.ca/Cabin/opendata/cabin_study_data_mda07_1987-present.csv

#Pacific Drainage Area
wget https://cabin-rcba.ec.gc.ca/Cabin/opendata/cabin_study_data_mda08_1987-present.csv

#Yukon River Drainage Area
wget https://cabin-rcba.ec.gc.ca/Cabin/opendata/cabin_study_data_mda09_1987-present.csv

#Arctic Drainage Area
wget https://cabin-rcba.ec.gc.ca/Cabin/opendata/cabin_study_data_mda10_1987-present.csv

#Mississippi River Drainage Area
wget https://cabin-rcba.ec.gc.ca/Cabin/opendata/cabin_study_data_mda11_1987-present.csv

#Converts files from UCS-2 encoding to UTF-8 encoding (easily loads into R and Excel)
for filename in *.csv; do iconv -f UCS2 -t UTF-8 $filename -o $filename --verbose; done

#Removes french variables and variable descriptions in the habitat files, due to the encoding, sometimes these columns mess with further pipeline commands
for filename in cabin_habitat_*; do csvcut -C 11,12 $filename > ../clean_CABIN_data/$filename; done

#Moves rest of the files into clean_CABIN_data folder 
cp *.csv ../clean_CABIN_data
cd ../clean_CABIN_data

#mda10
csvcut -c 3 cabin_benthic_data_mda10_1987-present.csv | csvgrep -f - -c 2 cabin_habitat_data_mda10_1987-present.csv > intermediate.csv
csvcut -c 1 cabin_benthic_data_mda10_1987-present.csv | csvgrep -f - -c 1 intermediate.csv > habitat_matched_mda10_data.csv

csvcut -c 2 cabin_habitat_data_mda10_1987-present.csv | csvgrep -f - -c 3 cabin_benthic_data_mda10_1987-present.csv > intermediate.csv
csvcut -c 1 cabin_habitat_data_mda10_1987-present.csv | csvgrep -f - -c 1 intermediate.csv > benthic_matched_mda10_data.csv

#mda01
csvcut -c 3 cabin_benthic_data_mda01_1987-present.csv | csvgrep -f - -c 2 cabin_habitat_data_mda01_1987-present.csv > intermediate.csv
csvcut -c 1 cabin_benthic_data_mda01_1987-present.csv | csvgrep -f - -c 1 intermediate.csv > habitat_matched_mda01_data.csv

csvcut -c 2 cabin_habitat_data_mda01_1987-present.csv | csvgrep -f - -c 3 cabin_benthic_data_mda01_1987-present.csv > intermediate.csv
csvcut -c 1 cabin_habitat_data_mda01_1987-present.csv | csvgrep -f - -c 1 intermediate.csv > benthic_matched_mda01_data.csv

#mda02
csvcut -c 3 cabin_benthic_data_mda02_1987-present.csv | csvgrep -f - -c 2 cabin_habitat_data_mda02_1987-present.csv > intermediate.csv
csvcut -c 1 cabin_benthic_data_mda02_1987-present.csv | csvgrep -f - -c 1 intermediate.csv > habitat_matched_mda02_data.csv

csvcut -c 2 cabin_habitat_data_mda02_1987-present.csv | csvgrep -f - -c 3 cabin_benthic_data_mda02_1987-present.csv > intermediate.csv
csvcut -c 1 cabin_habitat_data_mda02_1987-present.csv | csvgrep -f - -c 1 intermediate.csv > benthic_matched_mda02_data.csv

#mda03
csvcut -c 3 cabin_benthic_data_mda03_1987-present.csv | csvgrep -f - -c 2 cabin_habitat_data_mda03_1987-present.csv > intermediate.csv
csvcut -c 1 cabin_benthic_data_mda03_1987-present.csv | csvgrep -f - -c 1 intermediate.csv > habitat_matched_mda03_data.csv

csvcut -c 2 cabin_habitat_data_mda03_1987-present.csv | csvgrep -f - -c 3 cabin_benthic_data_mda03_1987-present.csv > intermediate.csv
csvcut -c 1 cabin_habitat_data_mda03_1987-present.csv | csvgrep -f - -c 1 intermediate.csv > benthic_matched_mda03_data.csv

#mda04
csvcut -c 3 cabin_benthic_data_mda04_1987-present.csv | csvgrep -f - -c 2 cabin_habitat_data_mda04_1987-present.csv > intermediate.csv
csvcut -c 1 cabin_benthic_data_mda04_1987-present.csv | csvgrep -f - -c 1 intermediate.csv > habitat_matched_mda04_data.csv

csvcut -c 2 cabin_habitat_data_mda04_1987-present.csv | csvgrep -f - -c 3 cabin_benthic_data_mda04_1987-present.csv > intermediate.csv
csvcut -c 1 cabin_habitat_data_mda04_1987-present.csv | csvgrep -f - -c 1 intermediate.csv > benthic_matched_mda04_data.csv

#mda05
csvcut -c 3 cabin_benthic_data_mda05_1987-present.csv | csvgrep -f - -c 2 cabin_habitat_data_mda05_1987-present.csv > intermediate.csv
csvcut -c 1 cabin_benthic_data_mda05_1987-present.csv | csvgrep -f - -c 1 intermediate.csv > habitat_matched_mda05_data.csv

csvcut -c 2 cabin_habitat_data_mda05_1987-present.csv | csvgrep -f - -c 3 cabin_benthic_data_mda05_1987-present.csv > intermediate.csv
csvcut -c 1 cabin_habitat_data_mda05_1987-present.csv | csvgrep -f - -c 1 intermediate.csv > benthic_matched_mda05_data.csv

#mda06
csvcut -c 3 cabin_benthic_data_mda06_1987-present.csv | csvgrep -f - -c 2 cabin_habitat_data_mda06_1987-present.csv > intermediate.csv
csvcut -c 1 cabin_benthic_data_mda06_1987-present.csv | csvgrep -f - -c 1 intermediate.csv > habitat_matched_mda06_data.csv

csvcut -c 2 cabin_habitat_data_mda06_1987-present.csv | csvgrep -f - -c 3 cabin_benthic_data_mda06_1987-present.csv > intermediate.csv
csvcut -c 1 cabin_habitat_data_mda06_1987-present.csv | csvgrep -f - -c 1 intermediate.csv > benthic_matched_mda06_data.csv

#mda07
csvcut -c 3 cabin_benthic_data_mda07_1987-present.csv | csvgrep -f - -c 2 cabin_habitat_data_mda07_1987-present.csv > intermediate.csv
csvcut -c 1 cabin_benthic_data_mda07_1987-present.csv | csvgrep -f - -c 1 intermediate.csv > habitat_matched_mda07_data.csv

csvcut -c 2 cabin_habitat_data_mda07_1987-present.csv | csvgrep -f - -c 3 cabin_benthic_data_mda07_1987-present.csv > intermediate.csv
csvcut -c 1 cabin_habitat_data_mda07_1987-present.csv | csvgrep -f - -c 1 intermediate.csv > benthic_matched_mda07_data.csv

#mda08
csvcut -c 3 cabin_benthic_data_mda08_1987-present.csv | csvgrep -f - -c 2 cabin_habitat_data_mda08_1987-present.csv > intermediate.csv
csvcut -c 1 cabin_benthic_data_mda08_1987-present.csv | csvgrep -f - -c 1 intermediate.csv > habitat_matched_mda08_data.csv

csvcut -c 2 cabin_habitat_data_mda08_1987-present.csv | csvgrep -f - -c 3 cabin_benthic_data_mda08_1987-present.csv > intermediate.csv
csvcut -c 1 cabin_habitat_data_mda08_1987-present.csv | csvgrep -f - -c 1 intermediate.csv > benthic_matched_mda08_data.csv

#mda09
csvcut -c 3 cabin_benthic_data_mda09_1987-present.csv | csvgrep -f - -c 2 cabin_habitat_data_mda09_1987-present.csv > intermediate.csv
csvcut -c 1 cabin_benthic_data_mda09_1987-present.csv | csvgrep -f - -c 1 intermediate.csv > habitat_matched_mda09_data.csv

csvcut -c 2 cabin_habitat_data_mda09_1987-present.csv | csvgrep -f - -c 3 cabin_benthic_data_mda09_1987-present.csv > intermediate.csv
csvcut -c 1 cabin_habitat_data_mda09_1987-present.csv | csvgrep -f - -c 1 intermediate.csv > benthic_matched_mda09_data.csv

rm intermediate.csv 
rm raw_CABIN_data

#Moves matched files into their own folder, point R and WEKA to this folder
mv clean_CABIN_data/*_matched_*  matched_CABIN_data/
