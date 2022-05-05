for file in objects/*.txt ; do
    filename=$(basename -s .txt $file)
    if [ $filename -eq $filename ] 2>/dev/null ; then
        echo -n $filename
        echo -n ';'
        sed -n 2p $file
    fi
done > 'output/default_names.txt'
cp 'output/default_names.txt' 'output/edited_names.txt'