while IFS='' read -r line || [[ -n "$line" ]]; do
	data=$(curl http://www.tripadvisor.in/TypeAheadJson\?query\=$line\&action\=API\&startTime\=1445996855417\&uiOrigin\=GEOSCOPE\&source\=GEOSCOPE\&interleaved\=true\&types\=geo%2Ctheme_park\&neighborhood_geos\=false\&link_type\=geo%2Chotel%2Cvr%2Cattr%2Ceat%2Cflights_to%2Cnbrhd\&details\=true\&max\=12)
	echo "$data"
done < "$1"