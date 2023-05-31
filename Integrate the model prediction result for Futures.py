import xlrd
import xlwt
from numpy import *
lat_list = [17.6, 18.1, 18.6, 19.1]
lon_list = [30.8, 31.3, 31.8, 32.3, 32.8]

result = list()

for i in range(4):
    result.append(list())
    lat = lat_list[i]
    for j in range(5):
        lon = lon_list[j]
        filename = "~/Desktop/SoybeanRCP85/Soybean-latlon_m" + str(lat) + "_" + str(lon) + ".xlsx"
        workbook = xlrd.open_workbook(filename)
        print(filename)
        # Open the worksheet
        worksheet = workbook.sheet_by_index(0)
        ls1 = list()
        ls2 = list()
        ls3 = list()
        # Iterate the rows and columns
        for row in range(1, worksheet.nrows):
            cell_value = worksheet.cell_value(row, 5)
            date_value = xlrd.xldate_as_datetime(cell_value, workbook.datemode)
            # Convert the datetime object to a string
            date_string = date_value.strftime('%Y-%m-%d')
            year = int(date_string[:4])
            print(date_string)
            value = int(worksheet.cell_value(row, 9))
            if value == 0:
                continue
            if year < 2041:
                ls1.append(value)
            elif year < 2071:
                ls2.append(value)
            else:
                ls3.append(value)
        value = [mean(ls1), mean(ls2), mean(ls3)]
        result[i].append(value)

print(result)

filename = "RCP85-Soybean.xls"
workbook = xlwt.Workbook()
sheet = workbook.add_sheet('Sheet1')
for i in range(4):
    for j in range(5):
        print(i*5+j + 3)
        sheet.write(i*5+j + 3, 0, str(-lat_list[i]) + ", " + str(lon_list[j]))

sheet.write(1, 1, "temp-4.5")
sheet.write(2, 1, "2011-2040")
sheet.write(2, 2, "2041-2070")
sheet.write(2, 3, "2071-2100")


for i in range(0, 4):
    for j in range(0, 5):
        sheet.write(i * 5 + j + 3, 1, result[i][j][0])
        sheet.write(i * 5 + j + 3, 2, result[i][j][1])
        sheet.write(i * 5 + j + 3, 3, result[i][j][2])
workbook.save(filename)
