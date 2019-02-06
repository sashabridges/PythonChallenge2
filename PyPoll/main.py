import os
import csv

khan_votes = 0
li_votes = 0
correy_votes = 0
otooley_votes = 0
sum_votes = 0


csvpath = "C:\\Users\\Sasha\\Documents\\PythonJazz\\PythonChallenge2\\PyPoll\\Resources\\election_data.csv"
with open(csvpath, 'r', newline='') as csvfile:
    csvreader = csv.reader(csvfile, delimiter=',')
    next(csvreader)
    for row in csvreader:
        if row[2] == "Khan":
            khan_votes = 1 + khan_votes
        elif row[2] == "Li":
            li_votes = 1 + li_votes
        elif row[2] == "Correy":
            correy_votes = 1 + correy_votes
        elif row[2] == "O'Tooley":
            otooley_votes = 1 + otooley_votes
        sum_votes = 1 + sum_votes
        
khan_percent = (khan_votes / sum_votes) * 100
li_percent = (li_votes / sum_votes) * 100
correy_percent = (correy_votes / sum_votes) * 100
otooley_percent = (otooley_votes / sum_votes) * 100

    # compares the votes from total_votes() and tells which candidate has the highest votes
the_winner = ""
if (khan_votes > li_votes) and (khan_votes > correy_votes) and (khan_votes > otooley_votes):
    the_winner = "Khan"
elif (li_votes > khan_votes) and (li_votes > correy_votes) and (li_votes > otooley_votes):
    the_winner = "Li"
elif (correy_votes > khan_votes) and (correy_votes > li_votes) and (correy_votes > otooley_votes):
    the_winner = "Correy"
elif (otooley_votes > khan_votes) and (otooley_votes > li_votes) and (otooley_votes > correy_votes):
    the_winner = "O'tooly"

    # prints out the results of the election
print("Election Results:")
print("-------------------------")
print(f"Total Votes: {sum_votes}")
print("-------------------------")
print("Khan: " + str(khan_percent) + " (" + str(khan_votes) + ")")
print("Li: " + str(li_percent) + " (" + str(li_votes) + ")")
print("Correy: " + str(correy_percent) + " (" + str(correy_votes) + ")")
print("O'Tooley: " + str(otooley_percent) + " (" + str(otooley_votes) + ")")
print("-------------------------")
print(f"Winner: {the_winner}")
print("-------------------------")

output_path = "C:\\Users\\Sasha\\Documents\\PythonJazz\\PythonChallenge2\\PyPoll\\output"
with open(output_path, 'w', newline='') as csvfile:
    csvwriter = csv.writer(csvfile, delimiter=',')
    csvwriter = csv.writer(csvfile, delimiter=',')
    csvwriter.writerow(['Election Results: '])
    csvwriter.writerow(['-------------------------'])
    csvwriter.writerow(['Total Votes: ', sum_votes])
    csvwriter.writerow(['-------------------------'])
    csvwriter.writerow(["Khan: ", khan_percent, khan_votes])
    csvwriter.writerow(["Li: ", li_percent, li_votes])
    csvwriter.writerow(["Correy: ", correy_percent, correy_votes])
    csvwriter.writerow(["O'Tooley: ", otooley_percent, otooley_votes])
    csvwriter.writerow(['-------------------------'])
    csvwriter.writerow(['Winner: ', the_winner])
    csvwriter.writerow(['-------------------------'])
csvfile.close()

