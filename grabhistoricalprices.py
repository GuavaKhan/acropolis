import sys
import csv
import os
import numpy
import scipy
import matplotlib
from matplotlib.font_manager import FontProperties
import getopt
import ystockquote
from datetime import datetime
import time
from pprint import pprint
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# define a function that calculates trailing return
def TrailingReturn(firstClose, seconClose):
	numerator = float(firstClose) - float(seconClose) 
	total = numerator / float(seconClose)
	total = total*100
	return total
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#  1)  Downloading data on funds from Yahoo finance

print "#1: "
print "Get the stock prices from the past for selected company..."

with open('stockdata.txt', 'wt') as out:
	pprint(ystockquote.get_historical_prices('^GSPC', '1954-10-20', '2014-10-20'), stream = out)
print "Data stored in file stockdata.txt"
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# 2) Getting the closing prices only, and then putting them into another file for 
#	 calculations. Plotting trailing return as a function of time.

print
print "#2: "
print "Getting the closing prices only, and then putting them into another file for calculations..."
i = 0
with open("unsanitizedprices.txt",'w') as new:
	with open('stockdata.txt', 'r') as file:
		for line in file:
			data = line.split(":")
			new.write(data[2]);
			i = i + 1  
			file.next(); file.next(); file.next(); file.next(); file.next();
trailing = zeros(i, dtype=float);
trailing1 = zeros(i, dtype=float);
trailing3 = zeros(i, dtype=float);
trailing12 = zeros(i, dtype=float);
date_s = [];
date_s1 = [];
date_s3 = [];
date_s12 = [];
i = 0
print "Ok, now sanitizing the data..."
with open('unsanitizedprices.txt', 'r') as file:
	with open('closingprices.txt', 'w') as new:
		for line in file:
			data = line.split("'")
			new.write(data[1]); new.write("\n")
			trailing[i] = float(data[1])
			i = i + 1
print "Done. New file closingprices.txt made."
print
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
print "Obtaining the dates for which we are looking at..."
with open('stockdata.txt', 'r') as file:
	with open('unsanitizeddates.txt', 'w') as new:
		for line in file:
			data = line.split(":")
			new.write(data[0]);new.write("\n")
i =0
print "Ok, now sanitizing the data..."
with open('unsanitizeddates.txt', 'r') as file:
	with open('dates.txt', 'w') as new:
		for line in file:
			data = line.split("'")
			new.write(data[1]); new.write("\n"); 
			date_s.append(datetime.strptime(data[1], '%Y-%m-%d'))
			i = i + 1
			file.next(); file.next(); file.next(); file.next(); file.next()
print "Done. New file dates.txt made."
print
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

i =0
j =0 
for f in trailing1:
	if (i+1) < size(trailing):
		trailing1[j] = TrailingReturn(trailing[i], trailing[i+1])
		date_s1.append(date_s[i+1])

		i = i + 1
		j = j + 1
trailing1 = trailing1[0:j]
date_s1 = date_s1[0:j]
i =0
j =0 
for f in trailing3:
	if (i+(21*3)) < size(trailing):
		trailing3[j] = TrailingReturn(trailing[i], trailing[i+ (21*3)])
		date_s3.append(date_s[i+(21*3)])

		i = i + (21*3)
		j = j + 1
trailing3 = trailing3[0:j]
date_s3 = date_s3[0:j]
i =0
j =0 
for f in trailing12:
	if (i+(21*12)) < size(trailing):
		trailing12[j] = TrailingReturn(trailing[i], trailing[i+ (21*12)])
		date_s12.append(date_s[i+(21*12)])

		i = i + (21*12)
		j = j + 1
trailing12 = trailing12[0:j]
date_s12 = date_s12[0:j]

print "Creating plots now..."
print
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

figure(num=None, figsize = (14,8), dpi=80,facecolor='w',edgecolor='k')
dates = matplotlib.dates.date2num(date_s)
plot_date(dates, trailing,fmt='b-', xdate=True, ydate=False)
grid(color = "#3887CE")
ylabel('Closing Prices')
xlabel('Time')
title('Closing Prices for Standard & Poor Index (^GSPC) For Last 60 years')

figure(num=None, figsize = (14,8), dpi=80,facecolor='w',edgecolor='k')
dates = matplotlib.dates.date2num(date_s1)
plot_date(dates, trailing1,fmt='#347C17', xdate=True, ydate=False)
grid(color = "#3887CE")
ylabel('Daily Trailing Trailing Returns')
xlabel('Time')
title('Daily Trailing Returns for Standard & Poor Index (^GSPC) For Last 60 years')
print "Drawdown for Daily Interval ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
print min(trailing1)

figure(num=None, figsize = (14,8), dpi=80,facecolor='w',edgecolor='k')
dates = matplotlib.dates.date2num(date_s3)
plot_date(dates, trailing3,fmt='#347C17', xdate=True, ydate=False)
grid(color = "#3887CE")
ylabel('3 Month Trailing Returns')
xlabel('Time')
title('3 Month Trailing Returns for Standard & Poor Index (^GSPC) For Last 60 years')
show()
print "Drawdown for 3 Month Interval ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
print min(trailing3)

figure(num=None, figsize = (14,8), dpi=80,facecolor='w',edgecolor='k')
dates = matplotlib.dates.date2num(date_s12)
plot_date(dates, trailing12,fmt='#911966', xdate=True, ydate=False)
grid(color = "#3887CE")
ylabel('12 Month Trailing Returns')
xlabel('Time')
title('12 Month Trailing Returns for Standard & Poor Index (^GSPC) For Last 60 years')
show()
print "Drawdown for 12 Month Interval ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
print min(trailing12)
