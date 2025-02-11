function ramadan
    # Get today's date in seconds since epoch
    set today (date +%s)
    # Get today's date in dd-mm-yyyy format for the API request
    set this_day (date "+%d-%m-%Y")

    # Make a GET request to get current month in Hijri
    set response (curl -s -X GET "https://api.aladhan.com/v1/gToH/$this_day?calendarMethod=UAQ" -H 'accept: application/json')

    # Parse the JSON response and extract the Hijri month and year
    set hijri_month (echo "$response" | jq -r '.data.hijri.month.number')
    set hijri_year (echo "$response" | jq -r '.data.hijri.year')

    # If it's already Ramadan or past Ramadan, go to next year
    if test $hijri_month -gt 8
        set year (math "$hijri_year + 1")
    else
        set year $hijri_year
    end

    # Make a GET request to the API
    set response (curl -s -X GET "https://api.aladhan.com/v1/hToG/01-09-$year?calendarMethod=MATHEMATICAL&adjustment=1" -H 'accept: application/json')

    # Parse JSON response and extract Gregorian date
    set greg_date (echo "$response" | jq -r '.data.gregorian.day')
    set greg_month (echo "$response" | jq -r '.data.gregorian.month.number')
    set greg_year (echo "$response" | jq -r '.data.gregorian.year')

    # Set the date of the first day of Ramadan
    set ramadan_date "$greg_year-$greg_month-$greg_date"

    # Get the Ramadan date in seconds since epoch
    set ramadan_epoch (date -d $ramadan_date +%s)

    # Calculate the difference in seconds and convert to days
    set seconds_left (math "$ramadan_epoch - $today")
    set days_left (math "$seconds_left / (60 * 60 * 24)")

    # Print the result
    echo "Days left until 1 Ramadan $year: $days_left"
    #/home/aminoh/scripts/ramadan.fish
end
