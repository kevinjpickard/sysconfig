function get_events $argv
	if test (count $argv) -eq 0
		echo "Please specify the time period to query (day|week)."
		return 1
 	end 
	if test (count $argv) -eq 2
		set apikey $argv[2]
	else
		set apikey $JUMPCLOUD_API_STG
	end
	echo "Getting events with API Key: $apikey"
	switch $argv[1] 
		case day
			echo "Collecting event data from today..."
			curl --silent -G -H "x-api-key: $apikey" -H "Content-Type:application/json" --data-urlencode "startDate="(date --rfc-3339=seconds --date="today 00:00:00" | sed 's/ /T/') https://events.jumpcloud.com/events | python -mjson.tool
			return 0
		case week
			echo "Collecting event data from this week..."
			curl --silent -G -H "x-api-key: $apikey" -H "Content-Type:application/json" --data-urlencode "startDate="(date --rfc-3339=seconds --date="1 week ago" | sed 's/ /T/') https://events.jumpcloud.com/events | python -mjson.tool
			return 0
	end
end

