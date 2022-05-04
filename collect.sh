#!/bin/bash
echo "Hello from $SHELL"
#cd context2
#place="context2"
find . -name pom.xml > pomfiles.txt
#cat pomfiles.txt

while read line
do
pomfiles+=("$line")
done < pomfiles.txt

count=$(cat  pomfiles.txt | wc -l)
pomlistc=$((count - 1))
echo $pomlistc
#sed -n '/dependencies/, /dependencies/{ /dependencies/! { /dependencies/! p } }'
for (( c=0;c<=$pomlistc;c++ ))
do
  # echo "Welcome $c times"
if [ $c -gt 0 -a $c -lt 1001  ]; then
sed -n '/<dependencies>/, /<\/dependencies>/{ /<dependencies>/! { /<\/dependencies>/! p } }' ${pomfiles[$c]} >> commonpom1.xml
fi

if [ $c -gt 1000 -a $c -lt 2001 ]; then
sed -n '/<dependencies>/, /<\/dependencies>/{ /<dependencies>/! { /<\/dependencies>/! p } }' ${pomfiles[$c]} >> commonpom2.xml
fi 

if [ $c -gt 2000 -a $c -lt 3001 ]; then
sed -n '/<dependencies>/, /<\/dependencies>/{ /<dependencies>/! { /<\/dependencies>/! p } }' ${pomfiles[$c]} >> commonpom3.xml
fi 

if [ $c -gt 3000 -a $c -lt 4001 ]; then
sed -n '/<dependencies>/, /<\/dependencies>/{ /<dependencies>/! { /<\/dependencies>/! p } }' ${pomfiles[$c]} >> commonpom4.xml
fi 
done

for (( j=1;j<=4;j++ ))
do
count=$(cat commonpom$j.xml | grep \<dependency\> | wc -l)
echo "this the count on commonpom$j.xml $count"
#dcount=$((count1 - 1))

for (( i=1;i<=$count;i++ ))
do
echo "forloop $i out of $count1 "

sed '/<dependency>/!d;x;s/^/x/;/x\{'$i'\}/!{x;d};x;:a;n;/<\/dependency>/!ba;q' commonpom$j.xml | grep "<version>"

if [ $? -eq 0 ]; then
sed '/<dependency>/!d;x;s/^/x/;/x\{'$i'\}/!{x;d};x;:a;n;/<\/dependency>/!ba;q' commonpom$j.xml | grep "version" | grep \$\{
if [ $? -ne 0 ]; then
sed '/<dependency>/!d;x;s/^/x/;/x\{'$i'\}/!{x;d};x;:a;n;/<\/dependency>/!ba;q' commonpom$j.xml | grep "version" | grep -i SNAPSHOT
if [ $? -ne 0 ]; then
sed '/<dependency>/!d;x;s/^/x/;/x\{'$i'\}/!{x;d};x;:a;n;/<\/dependency>/!ba;q' commonpom$j.xml >> newpom.xml
fi
fi
fi
done

done
echo "collect script completed"
echo "</dependencies>" >> newpom.xml
echo "</project>" >> newpom.xml
