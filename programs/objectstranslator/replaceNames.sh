filename='output/edited_names.txt'
while read line; do 
    id=$(echo $line | cut -d';' -f1)
    value=$(echo $line | cut -d';' -f2)
    
    txtfile="objects/$id.txt"
    sed -i "2s/.*/${value}/" $txtfile
done < "$filename"