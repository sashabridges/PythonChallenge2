#text
 # Financial Analysis
 # ----------------------------
 # Total Months: 86
  #Total: $38382578
 # Average  Change: $-2315.12
 # Greatest Increase in Profits: Feb-2012 ($1926159)
  #Greatest Decrease in Profits: Sep-2013 ($-2196167)

# Summon the imports
import os
import csv

# initialize the variables
total_months = 0
average_change = 0
total = 0
greatest_increase = 0
greatest_decrease = 0
great_date = ""
worst_date = ""

# absolute path bc vs code is DUMB
csvpath = "C:\\Users\\Sasha\\Documents\\PythonJazz\\PythonChallenge2\\PyBank\\Resources\\budget_data.csv"
with open(csvpath, 'r', newline='') as csvfile:
    csvreader = csv.reader(csvfile, delimiter=',')
    next(csvreader)         # skips header row bc for statement cant do anything with header row
    for row in csvreader:
        # sum the total num of months and th grand total
        total_months = total_months + 1
        total = total + int(row[1])
        # find the greatest increase/decrease & store that value along with the date
        if (int(row[1]) > greatest_increase):
            great_date = row[0]
            greatest_increase = int(row[1])
        if (int(row[1]) < greatest_decrease):
            worst_date = row[0]
            greatest_decrease = int(row[1])

# find the average change per month....but its going to be negative bc ur not using abs()
average_change = total / total_months

# print everything out
print('Financial Analysis')
print('-------------------------')
print('Total Months: ' + str(total_months))
print('Total: $' + str(total))
print('Average Change: $' + str(average_change))
print('Greatest Increase in Profits: ' + str(great_date) + ' ($' + str(greatest_increase) + ')')
print('Greatest Decrease in Profits: ' + str(worst_date) + ' ($' + str(greatest_decrease) + ')')
print('-------------------------')

# print everything out to a file
output_path = "C:\\Users\\Sasha\\Documents\\PythonJazz\\PythonChallenge2\\PyBank\\output"
with open(output_path, 'w', newline='') as csvfile:
    # set something to tell the program to call when writing to csvfile
    csvwriter = csv.writer(csvfile, delimiter=',')
    csvwriter.writerow(['Financial Analysis'])
    csvwriter.writerow(['-------------------------'])
    csvwriter.writerow(['Total Months: ' + str(total_months)])
    csvwriter.writerow(['Total: $' + str(total)])
    csvwriter.writerow(['Average Change: $' + str(average_change)])
    csvwriter.writerow(['Greatest Increase in Profits: ' + str(great_date) + ' ($' + str(greatest_increase) + ')'])
    csvwriter.writerow(['Greatest Decrease in Profits: ' + str(worst_date) + ' ($' + str(greatest_decrease) + ')'])
    csvwriter.writerow(['-------------------------'])
csvfile.close()