# Dependencies
import os
import numpy as np
from splinter import Browser
from bs4 import BeautifulSoup as bs
import requests
import pymongo
import pandas as pd
import csv
import time

def Scrape():
    executable_path = {'executable_path': 'chromedriver.exe'}
    browser = Browser('chrome', **executable_path, headless=False)
    hemi_dicts = []
# NEWS
# NEWS
# NEWS

    url = 'https://mars.nasa.gov/news/'
    response = requests.get(url)
    soup = bs(response.text, 'html.parser')

    # news titles
    title_results = soup.find_all('div', class_="content_title")
    # paragraph text
    text_results = soup.find_all('div', class_="rollover_description_inner")

    url = 'https://www.jpl.nasa.gov/spaceimages/?search=&category=Mars'
    base_url = 'https://www.jpl.nasa.gov'
    browser.visit(url)  

    # Navigate to the page with the full image
    browser.click_link_by_partial_text('FULL IMAGE')

    html = browser.html
    notsoup = bs(html, 'html.parser')

    #image = soup.find(class_="fancybox-image")["src"]
    image = notsoup.find(class_="fancybox-image")["src"]
    featured_image_url = f"{base_url}{image}"
    featured_image_url
    hemi_dicts.append({"Text_Results": text_results})
    hemi_dicts.append({"Title_Results": title_results})
    hemi_dicts.append({"Featured_Image": featured_image_url})



# TWITTER
# TWITTER
# TWITTER

    url = 'https://twitter.com/marswxreport?lang=en'
    twit_response = requests.get(url)
    soup = bs(twit_response.text, 'html.parser')
    #print(soup.prettify())

    # weather tweet from the page. Save the tweet text for the weather report as a variable called `mars_weather`.
    weather_results = soup.find_all('div', class_="js-tweet-text-container")
    weatherz = []
    for result in weather_results:
        blah = result.p.text
        weatherz.append(blah)

    mars_weather =  weatherz[0]
    #print(mars_weather)
    hemi_dicts.append({"Mars_Weather": mars_weather})


# MARS FACTS
# MARS FACTS
# MARS FACTS


# Visit the Mars Facts webpage [here](http://space-facts.com/mars/) and use Pandas to scrape the table 
# containing facts about the planet including Diameter, Mass, etc.
# Use Pandas to convert the data to a HTML table string.
    url = 'http://space-facts.com/mars/'
    table = pd.read_html(url)
    table_df = pd.DataFrame(table[0])
    table_df

    table_df.columns=['Index', 'Values']
    table_df = table_df.set_index('Index')
    hemi_dicts.append(table_df)

# turn df back into html
    #table_df = table_df.to_html()


# HEMISPHERE SECTION
# HEMISPHERE SECTION
# HEMISPHERE SECTION

# Visit the USGS Astrogeology site [here](https://astrogeology.usgs.gov/search/results?q=hemisphere+enhanced&k1=target&v1=Mars) 
# to obtain high resolution images for each of Mar's hemispheres.

    url = 'https://astrogeology.usgs.gov/search/results?q=hemisphere+enhanced&k1=target&v1=Mars'
    hemi_response = requests.get(url)
    soup = bs(hemi_response.text, 'html.parser')
    #print(soup.prettify())

# You will need to click each of the links to the hemispheres in order to find the image url to the full resolution image.
# Save both the image url string for the full resolution hemisphere image, and the Hemisphere title containing the hemisphere 
# name. Use a Python dictionary to store the data using the keys `img_url` and `title`.
# Append the dictionary with the image url string and the hemisphere title to a list. 
# This list will contain one dictionary for each hemisphere.
    mars_hemisphere_url = 'https://astrogeology.usgs.gov/search/results?q=hemisphere+enhanced&k1=target&v1=Mars'

    for i in range(1,9, 2):
        hemi_dict = {}
        
        browser.visit(mars_hemisphere_url)
        time.sleep(1)
        hemispheres_html = browser.html
        hemispheres_soup = bs(hemispheres_html, 'html.parser')
        hemi_name_links = hemispheres_soup.find_all('a', class_='product-item')
        hemi_name = hemi_name_links[i].text.strip('Enhanced')
        
        detail_links = browser.find_by_css('a.product-item')
        detail_links[i].click()
        time.sleep(1)
        browser.find_link_by_text('Sample').first.click()
        time.sleep(1)
        browser.windows.current = browser.windows[-1]
        hemi_img_html = browser.html
        browser.windows.current = browser.windows[0]
        browser.windows[-1].close()
        
        hemi_img_soup = bs(hemi_img_html, 'html.parser')
        hemi_img_path = hemi_img_soup.find('img')['src']

        print(hemi_name)
        hemi_dict['title'] = hemi_name.strip()
        
        print(hemi_img_path)
        hemi_dict['img_url'] = hemi_img_path

        hemi_dicts.append(hemi_dict)
    return hemi_dicts

Scrape()