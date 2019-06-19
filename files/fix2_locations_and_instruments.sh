#!/bin/bash

sudo service tessdb pause ; sleep 2

# Creating new sites
sudo tess location create  "Osservatorio Astronomico di San Benedetto Po" --owner "Fabio Falchi" --email "falchi@lightpollution.it" --longitude  10.9197606 --latitude 45.0510358 --elevation 403 --zipcode 46027 --location "Comuna di San Benedetto Po" --province Mantova --country Italy --tzone "Europe/Rome"
sudo tess location create  "Meadow Grove" --owner "Brian Espey" --longitude  -6.2479933  --latitude 53.2872217 --elevation 73 --zipcode 46027 --location "Dundrum, Dublin" --country Ireland --tzone "Europe/Dublin"
sudo tess location create  "Nevena Kokanova" --owner "Dessislav Gouzgounov"  --longitude 23.295422  --latitude 42.637673 --elevation 770 --location Sofia  --country Bulgary --tzone "Europe/Sofia"

# Renaming of sites
sudo tess location rename "ARPAV" "ARPAV Padova"
sudo tess location rename "Cape Verde Atmospheric Observatory" "Cape Verde Atmospheric Observatory (CVAO)"

# updating attributes with the new site name

# 'stars47'
sudo tess location update "ARPAV Padova" --elevation 11 --location "Bagnoli di Sopra" --province "Padova" --owner "Andrea Bertolo" --email "andrea.bertolo@arpa.veneto.it" --org ARPAV

# 'stars79' 
sudo tess location update "Cape Verde Atmospheric Observatory (CVAO)"  --elevation 9 --org CVAO

sudo tess instrument assign stars47 "ARPAV Padova"
sudo tess instrument assign stars64 "Osservatorio Astronomico di San Benedetto Po"
sudo tess instrument assign stars78 "Meadow Grove"
sudo tess instrument assign stars79 "Cape Verde Atmospheric Observatory (CVAO)"
sudo tess instrument assign stars92 "Nevena Kokanova"

sudo service tessdb resume