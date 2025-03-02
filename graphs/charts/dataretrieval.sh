#!/usr/bin/env bash

RAW_DATA=/tmp/raw_data.txt
JSON_DATA=/tmp/data.json
CSV_DATA=/tmp/data.csv

echo ""
echo "------------------"

if [ ! -f ${RAW_DATA} ]; then
	echo "Data not on disk.  Retrieving data."
	# Get data as the web browser would
	curl 'https://striketracker.ilr.cornell.edu/geodata.js' \
		--compressed \
		-H 'User-Agent: Mozilla/5.0 (wayland; Ubuntu; Linux x86_64; rv:124.0) Gecko/20100101 Firefox/124.0' \
		-H 'Accept: */*' \
		-H 'Accept-Language: en-US,en;q=0.5' \
		-H 'Accept-Encoding: gzip, deflate, br' \
		-H 'Sec-Fetch-Dest: script' \
		-H 'Sec-Fetch-Mode: no-cors' \
		-H 'Sec-Fetch-Site: same-origin' \
		-H 'Pragma: no-cache' \
		-H 'Cache-Control: no-cache' \
		-H 'TE: trailers' >${RAW_DATA}
else
	echo "Using copy of data on disk."
fi

# Examine leading and trailing 100 bytes
echo ""
echo "------------------"
echo "Leading 50 bytes:"
head -c 50 ${RAW_DATA}
echo "Trailing 50 bytes:"
tail -c 50 ${RAW_DATA}

# Remove the variable declaration to make valid json
cat ${RAW_DATA} |
	sed 's/^window.geodata=//' >${JSON_DATA}

# Count number of items in top level array
echo ""
echo "------------------"
echo "Number of records:"
jq length ${JSON_DATA}

# Convert JSON to CSV using jq with specific fields and overwrite CSV file if it exists
echo "CSV_DATA: ${CSV_DATA}" # Debugging output
jq -r '["Timestamp", "Employer", "LaborOrganization", "Local", "Industry", "BargainingUnitSize", "NumberOfLocations", "Address", "City", "State", "ZipCode", "LatitudeLongitude", "ApproximateNumberOfParticipants", "StartDate", "EndDate", "DurationAmount", "DurationUnit", "StrikeOrProtest", "Authorized", "WorkerDemands", "Source", "Notes"], (.[] | [.Timestamp, .Employer, .LaborOrganization, .Local, .Industry, .BargainingUnitSize, .NumberOfLocations, .Address, .City, .State, .ZipCode, .LatitudeLongitude, .ApproximateNumberOfParticipants, .StartDate, .EndDate, .DurationAmount, .DurationUnit, .StrikeOrProtest, .Authorized, .WorkerDemands, .Source, .Notes]) | @csv' "${JSON_DATA}" >"${CSV_DATA}"

# Display the content of the CSV file
echo "CSV File Content:"
cat "${CSV_DATA}"
