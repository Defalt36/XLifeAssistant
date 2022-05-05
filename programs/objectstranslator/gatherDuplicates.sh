inputfile='output/default_names.txt'
tempfile='output/temp.txt'
outputfile='output/duplicated_terms.txt'

rm $tempfile
rm $outputfile

while read line; do 
    string=$(echo $line | cut -d';' -f2 | sed 's/[^A-Za-z0-9 ].*$//')
    stringarr=($string)
    
    unorderedpage=''
    for numelements in $(seq 1 $(expr ${#stringarr[@]} - 1)) ; do
        counting=0
        while [ $(expr $counting + $numelements) -lt ${#stringarr[@]} ] ; do
            substring=''
            for index in $(seq 0 $numelements) ; do
                substring+=${stringarr[$(expr $index + $counting)]}
                if [ $index -ne $numelements ]; then
                    substring+=' '
                fi
            done
            duplicates_count=$(grep -ic "$substring" $inputfile)
            if [ $duplicates_count -gt 1 ] ; then
                echo "$substring;" >> $tempfile
            fi
            counting=$(expr $counting + 1)
        done
    done
done < $inputfile

sort $tempfile | uniq -u > $outputfile
rm $tempfile
