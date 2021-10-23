#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Aug  4 17:40:42 2021

@author: BU RCS SA
"""

#####################################
# import three packages: requests, beautifulsoup, & csv (you have to install them before running codes)
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

job_elements = results.find_all("div", class_="card-content")

for job_element in job_elements:
    print(job_element, end="\n"*2)
    
# ls and l below are used to save the job information and can be exported as cvs later    
ls = []
    
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
    
f = open('jobs.csv', 'w')
writer = csv.writer(f)
for i in range(len(ls)):
    row = [s.encode('utf-8') for s in ls[i]]
    writer.writerow(row)
f.close()
