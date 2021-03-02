#!/bin/python

import requests
import json
from bs4 import BeautifulSoup

alfa_url = 'https://www.alfabank.by/exchange/digital/'
html_text = requests.get(alfa_url).text
soup = BeautifulSoup(html_text, 'html.parser')
prices = soup.find_all("div", {"data-component": "ExchangePage"})
initial_data = prices[0]['data-initial']
initial_data_json = json.loads(initial_data)
print(initial_data_json["initialItems"][0]["currenciesData"][0]["value"]["exchangeRate"][0]["sell"]["value"])
