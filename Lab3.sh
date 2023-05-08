#!/bin/bash

# 259199


# zadanie nr.1 - ZNAJDŹ W ACCESS LOG

# a. 10 unikalnych adresow IP w access_log
grep -E -o '([0-9]{1,3}\.){3}[0-9]{1,3}' access_log | sort -u | head -n 10

# b. zapytania, które mają frazę "denied" w linku
grep 'GET .*denied.*' access_log
grep 'POST .*denied.*' access_log

# c. zapytania wysłane z IP: 64.242.88.10 
grep '64.242.88.10\b' access_log

# d. unikalne zapytania typu DELETE
grep -E -o '"DELETE .* HTTP/.\.."' access_log | sort -u


# zadanie nr.2 - Z PLIKU YOLO.CSV WYPISZ 

# a. wypisz wszystkich, których id jest liczbą nieparzystą. wynik zapisz na standardowe wyjscie bledu.
grep -E '^[0-9]*[13579],' yolo.csv 1>&2

# b. imię kazdego kto jest wart dokładnie 2.99 lub 5.99 lub 9.99, wyniki zapisz na standardowe wyjście błędu.
cut -d "," -f3,7 yolo.csv | grep -E '$2\.99.|$5\.99.|9\.99.' 1>&2

# zadanie nr.3 WE WSZYSTKICH PLIKACH KATALOGU 'GROOVIES'


# a. zamień $HEADER$ na /temat/
for FILE in groovies/; do
  sed -i 's|$HEADER$|/temat/|g' "$FILE"
done

# b. usuń linijki zawierające frazę 'Help docs.'
for FILE in groovies/; do
  sed -i '/Help docs:/d' "$FILE"
done