# so the code provided on the website doesn't really work out on my computer very well...
# because there were many errors each time I downloaded the necessary libraries...anyways~~
# so the code below was written up instead. seems to work fine.
import sys
import csv
import os
import getopt
import ystockquote
# define a function that calculates trailing return ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def TrailingReturn(firstClose, seconClose):
	numerator = float(firstClose) - float(seconClose) 
	total = numerator / float(seconClose)
	total = total*100
	return total
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
print "Get the stock prices from the past for selected company..."
with open('stockdata.txt', 'wt') as out:
	pprint(ystockquote.get_historical_prices('VZ', '2000-01-02', '2014-11-20'), stream = out)
print "Raw data stored in file stockdata.txt. "
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
with open("unsanitizedprices.txt",'w') as new:
	with open('stockdata.txt', 'r') as file:
		for line in file:
			data = line.split("'")
			new.write(data[3]); new.write("\n")
trailing = []; i = 0; close = 1; high = 1; low = 1; ope_n = 1; volume = 1
print "Ok, now sanitizing the data..."
with open('unsanitizedprices.txt', 'r') as file:
	with open('VZ_close.txt', 'w') as new1:
		with open('VZ_high.txt', 'w') as new2:
			with open('VZ_low.txt', 'w') as new3:
				with open('VZ_open.txt', 'w') as new4:
					with open('VZ_volume.txt', 'w') as new5:
						for line in file:
							i = i + 1
							if (6*close) - 4 == i: 
								new1.write(line)
								data  = line.split("\n")
								trailing.append(float(data[0]))
								close = close + 1
							if (6*high) - 3 == i:
								new2.write(line)
								high = high + 1
							if (6*low) - 2 == i:
								new3.write(line)
								low = low + 1
							if (6*ope_n) - 1 == i:
								new4.write(line)
								ope_n = ope_n + 1
							if (6*volume) - 0 == i:
								new5.write(line)
								volume = volume + 1
print "Ok, and we're done sanitzing Close, High, Low, Open and Volume!"
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
print "Writing trailing returns...."
i =0; j = 0; k = 0; l = 0
with open('VZ_close.txt', 'r') as file:
	with open('VZ_dailyTrailing.txt', 'w') as new1:
		with open('VZ_weeklyTrailing.txt', 'w') as new2:
			with open('VZ_3monthTrailing.txt', 'w') as new3:
				with open('VZ_12monthTrailing.txt', 'w') as new4:
					with open('percentyield.txt', 'w') as new4:
						for line in file:
							if (i+1) < size(trailing):
								new1.write(str(TrailingReturn(trailing[i], trailing[i+1])) ) ;new1.write("\n")
								i = i + 1
							if (j+(21*3)) < size(trailing):
								new2.write(str(TrailingReturn(trailing[j], trailing[j+ (21*3)])) ) ;new2.write("\n")
								j = j + (21*3)
							if (k + 5) < size(trailing):
								new3.write(str(TrailingReturn(trailing[k], trailing[k + 5])) ) ;new3.write("\n")
								k = k + 1
							if (l + (21*12)) < size(trailing):
								new4.write(str(TrailingReturn(trailing[j], trailing[j+ (21*12)])) ) ;new4.write("\n")
								l = l + 21*12
print "Done! 9 files created"
