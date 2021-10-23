#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Aug  4 17:40:42 2021

@author: BU RCS SA
"""

#####################################
<<<<<<< HEAD
# import three packages: requests, beautifulsoup, & csv (you have to install them before running codes)
=======
# import three packages: requests, beautifulsoup, & csv 
#   (on your own computer you may have to install them before running codes)
#   (On the SCC any of the python3 modules have these libraries installed)
>>>>>>> 90aa07745da27992b616dee79b05abdfdf0a447e
#####################################
import requests
from bs4 import BeautifulSoup
import csv

URL = "https://realpython.github.io/fake-jobs/"

# requests is used to load the website 
page = requests.get(URL)

# print(page.text)
soup = BeautifulSoup(page.content, "html.parser")

results = soup.find(id="ResultsContainer")

<<<<<<< HEAD
job_elements = results.find_all("div", class_="card-content")

for job_element in job_elements:
    print(job_element, end="\n"*2)
=======
# Make a list of all of the jobs - they belong to the card-content div
job_elements = results.find_all("div", class_="card-content")
>>>>>>> 90aa07745da27992b616dee79b05abdfdf0a447e
    
# ls and l below are used to save the job information and can be exported as cvs later    
ls = []
    
<<<<<<< HEAD
=======

>>>>>>> 90aa07745da27992b616dee79b05abdfdf0a447e
for job_element in job_elements:
    title_element = job_element.find("h2", class_="title")
    company_element = job_element.find("h3", class_="company")
    location_element = job_element.find("p", class_="location")
    print(title_element.text.strip())
    print(company_element.text.strip())
    print(location_element.text.strip())
    print()
    l = [title_element.text.strip().split(' '), company_element.text.strip().split(' '), location_element.text.strip().split(' ')]
    ls.append(l)
<<<<<<< HEAD
    
f = open('jobs.csv', 'w')
writer = csv.writer(f)
for i in range(len(ls)):
    row = [s.encode('utf-8') for s in ls[i]]
    writer.writerow(row)
f.close()
=======
 
# Write out the scraped data as a CSV file
with open('jobs.csv', 'w',encoding='utf-8') as f:
    writer = csv.writer(f)
    for i in range(len(ls)):
        row = [' '.join(s) for s in ls[i]]
        writer.writerow(row)
 
>>>>>>> 90aa07745da27992b616dee79b05abdfdf0a447e
