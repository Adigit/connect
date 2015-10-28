count=1
while IFS='' read -r line || [[ -n "$line" ]]; do
	if [ `echo "$count % 2" | bc` -eq 0 ]
	then
   		echo "$line" | cut -d"/"  -f3 | cut -d">" -f2| cut -d "<" -f1
   	fi
   	count=$((count+1))
done < "$1"