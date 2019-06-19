#!/bin/bash

service tessdb pause ; sleep 2

# Renaming of sites
sudo tess location rename "Laboratorio de Cristobal" "Laboratorio de Cristóbal"
sudo tess location rename "Facultad de Fisicas, UCM" "Facultad de Físicas UCM"
sudo tess location rename "Fundacion Monte Mediterraneo"  "Fundación Monte Mediterraneo"
sudo tess location rename "Albergue Tefia"  "Albergue Tefía"
sudo tess location rename "Observatorio de Jesus R. Sanchez" "Observatorio de Jesús R. Sánchez"
sudo tess location rename "Colegio Santo Domingo de Guzman" "Colegio Santo Domingo de Guzmán"
sudo tess location rename "Hospederia de Monfrague" "Hospedería de Monfragüe"
sudo tess location rename "OAJ" "Observatorio Astrofísico de Javalambre"
sudo tess location rename "Domicilio Nicolas" "Domicilio Nicolás"
sudo tess location rename "Domicilio Juan Jose Munoz" "Domicilio Juan José Muñoz"
sudo tess location rename "Museum am Scholerberg" "Museum am Schölerberg"
sudo tess location rename "Domicilio Semeli" "Domicilio Seméli"
sudo tess location rename "COU Montsec" "Centre d'Observació de l'Univers"
sudo tess location rename "Hestheimar, Guesthouse and horse farm" "Hestheimar, Guesthouse and Ásahreppur"

# 'stars7' = pamplona
# stars12 = El Pinillo
# stars56 = Observatorio Astronomico de Santana
# stars75 y stars76 = Domicilio Enric Marco

# updating attributes with the new site name

# 'pruebas' y 'stars1' DADOS POR BUENOS
sudo tess location update "Laboratorio de Cristóbal" --owner "Cristóbal García"

# 'stars2' DADOS POR BUENOS
sudo tess location update "Villaverde del Ducado"  --org UCM

# 'stars3' , 'stars5', 'stars17' DADOS POR BUENOS
sudo tess location update "Facultad de Físicas UCM"  --org UCM

# 'stars63' REVISADO
sudo tess location update "Observatorio del Teide" --owner "Miguel Rodríguez Alarcón" --email "miguelrguez.alarcon@gmail.com" --org IAC

# 'stars8' REVISADO
sudo tess location update "Observatorio Guirguillano" --owner "Fernando Jáuregui"

# 'stars11' REVISADO
sudo tess location update "Observatorio El Torcal" --owner "Alberto Castellón" --tzone "Europe/Madrid"

# 'stars70' REVISADO
sudo tess location update "Albergue Tefía" --owner "Miguel Rodríguez Alarcón" --email "miguelrguez.alarcon@gmail.com" --tzone "Atlantic/Canary"

# 'stars15' REVISADO
sudo tess location update "Observatorio de Jesús R. Sánchez" --owner "Jesús R. Sánchez"

# 'stars6' REVISADO
sudo tess location update "Hestheimar, Guesthouse and Ásahreppur" --owner "Miquel Serra" --email "mserra@ot-admin.net" --tzone "Atlantic/Reykjavik"

# 'stars4' REVISADO
sudo tess location update "Colegio Santo Domingo de Guzmán" --email "direcciontitular@lapalmita.es" --tzone "Atlantic/Canary"

# 'stars62' REVISADO
sudo tess location update "Centre d'Observació de l'Univers" --owner "Salvador Ribas" --email "sjribas@montsec.ca" --tzone "Europe/Madrid"

# 'stars19' REVISADO
sudo tess location update "IDA" --owner "John Barentine" --email "john@darksky.org"

# 'stars59' REVISADO
sudo tess location update "Hospedería de Monfragüe" --owner "Miguel Rodriguez Alarcón" --email "miguelrguez.alarcon@gmail.com" --location "Torrejón el Rubio" --province "Cáceres" --tzone "Europe/Madrid"

# 'stars18' REVISADO
sudo tess location update "Observatorio Astrofísico de Javalambre" --owner "Victor Tilve" --email "vtilve@cefca.es" --org "CEFCA" --tzone "Europe/Madrid"

# stars69 REVISADO
sudo tess location update "Observatorio de Forcadey" --owner "Salvador Bará" --email "salva.bara@usc.es" --tzone "Europe/Madrid"

# stars12 REVISADO
sudo tess location update "Miraflores de la Sierra" --owner "Javier" --org "meteomiraflores" --tzone "Europe/Madrid"

# 'stars32' REVISADO
sudo tess location update "Camino de Manzanares" --owner "Antonio Tenorio Manzano" --email "antonio.tenorio.matanzo@gmail.com" --tzone "Europe/Madrid"

# 'stars81' REVISADO
sudo tess location update "Domicilio Nicolás" --owner "Nicolás Cardiel"

# 'stars52' REVISADO
sudo tess location update "Domicilio Juan José Muñoz" --owner "Juan José Muñoz Padua" --location "Huércal de Almería" --province "Almería" --tzone "Europe/Madrid"

# 'stars83' REVISADO
sudo tess location update "Domicilio Seméli" --owner "Seméli Papadogiannakis" --tzone "Europe/Stockholm" --location "Skarpnäck"

# 'stars55' REVISADO
sudo tess location update "Museum am Schölerberg" --owner "Andreas Haenel" --location "Osnabrück" --tzone "Europe/Berlin"

#sudo tess location update "MOSS Observatory" --owner "<<>>" --tzone "Africa/Casablanca"
#sudo tess location update "Fundación Monte Mediterraneo" --owner "<<>>" --tzone "Europe/Madrid" --org "Fundación Monte Mediterraneo"

service tessdb resume