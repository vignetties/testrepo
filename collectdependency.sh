#set -x
place="/home/joker"
find $place -name pom.xml > $place/pomfiles.txt
IFS=$'\n' read -d '' -r -a lines < $place/pomfiles.txt
nooflines=$(cat  $place/pomfiles.txt | wc -l)
#echo $nooflines
#sed -n '/dependencies/, /dependencies/{ /dependencies/! { /dependencies/! p } }'
for (( c=0; c<$nooflines; c++ ))
do
  # echo "Welcome $c times"
   sed -n '/dependencies/, /dependencies/{ /dependencies/! { /dependencies/! p } }' ${lines[$c]} >> commonpom.xml
done
echo "</dependencies>" >> commonpom.xml
echo "</project>" >> commonpom.xml
#printf "line 1: %s\n" "${lines[0]}"
#printf "line 5: %s\n" "${lines[4]}"

# all lines
#echo "${lines[@]}"
