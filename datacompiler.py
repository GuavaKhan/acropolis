#!/usr/bin/python
import os, sys, re, scipy.io as sio, numpy as np
from os import listdir, walk
from os.path import isfile, join
from decimal import Decimal

data = '/Users/chris/Desktop/ECS 171/acropolis/companiesData'    
companynames = walk(data).next()[1]
featurelist = [['Company'],['3MonthTrailing'], ['12MonthTrailing'], ['Close'], ['DailyTrailing'], ['High'], ['Low'], ['Open'], ['Volume'], ['WeeklyTrailing'], ['CoStateFieldDate']]
objs = np.zeros((31, 11), dtype=np.object)
for i in range(len(featurelist)): objs[0, i] = featurelist[i]
i = 1

for company in companynames:
    objs[i, 0] = company
    directory = join(data, company) 
    onlyfiles = [f for f in listdir(directory) if isfile(join(directory, f))]
    absfiles = [join(directory, f) for f in onlyfiles]
    j = 1
    
    for file in absfiles:
        with open(file) as f:
            if not ".dontdelete" in file:
                content = f.readlines()
                content = [x.strip('\n') for x in content]
                objs[i, j] = content 
                j = j + 1
    i = i + 1
 
sio.savemat('/Users/chris/Desktop/ECS 171/acropolis/companies.mat', {'obj_arr':objs})