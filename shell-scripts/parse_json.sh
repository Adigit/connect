while IFS='' read -r line || [[ -n "$line" ]]; do
	echo "$line" | jq '.results[0]'
done < "$1"