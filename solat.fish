#!/usr/bin/env fish

# Set location code
set location jhr-2

# Get the current date in DD-MM-YYYY format
set today (date "+%d-%m-%Y")

# Make a GET request to the API with the date as a query parameter
set response (curl -s -X GET "https://api.aladhan.com/v1/gToH/$today?calendarMethod=UAQ" -H 'accept: application/json')

# Parse the JSON response and extract the Hijri date, month, and year
set hijri_date (echo "$response" | jq -r '.data.hijri.day')
set hijri_month (echo "$response" | jq -r '.data.hijri.month.en')
set hijri_year (echo "$response" | jq -r '.data.hijri.year')

# Print the results
echo -n "$location solat times for today $hijri_date $hijri_month $hijri_year or "
date "+%d %B %Y"

# Define prayer names
set prayers "Fajr" "Shurooq" "Dhuhr" "Asr" "Maghrib" "Isha"

# Fetch the JSON data and process it silently
set times (curl -s "https://mpt.i906.my/mpt.json?code=$location&filter=1" | jq -r '.response.times[] | (.+28800) | strftime("%H:%M")')

# Iterate over the times and prefix them with the corresponding prayer name
for i in (seq (count $times))
    printf "%-8s %s\n" "$prayers[$i]" "$times[$i]"
end
