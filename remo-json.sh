#!/bin/bash
rm /tmp/remo*
LF=$(printf '\\\012_')
LF=${LF%_}
DS="  "
curl -s -X GET "https://api.nature.global/1/devices" -H "accept: application/json" -H "Authorization: Bearer $1" |sed 's/{\"name\"/'"$LF{\"name\""'/g' > /tmp/remo
ROWS=$(cat /tmp/remo | wc -l)
REMONUM=$ROWS
loop=`expr $ROWS - 1`;#繰り返し回数
i=0;


echo -e -n '{\n\t"data":[\n'

while true
do
REMONUM=`expr $REMONUM + 1`
##name
eval NAME${REMONUM}=$(sed -n ${REMONUM}p /tmp/remo |awk '{print substr($0, index($0, "\"name\""))}'|awk '{sub("id.*", "");print $0;}'|sed -e 's/"//g'|sed -e 's/,//g'|sed -e 's/name://g')
eval TEMP${REMONUM}=$(sed -n ${REMONUM}p /tmp/remo |awk '{print substr($0, index($0, "\"te\""))}'|awk '{sub("created.*", "");print $0;}'|sed -e 's/"//g'|sed -e 's/,//g'|sed -e 's/{//g'|sed -e 's/te:val://g'|awk '{printf("%d",$1 + 0.5)}')
eval HUMI${REMONUM}=$(sed -n ${REMONUM}p /tmp/remo |awk '{print substr($0, index($0, "\"hu\""))}'|awk '{sub("created.*", "");print $0;}'|sed -e 's/"//g'|sed -e 's/,//g'|sed -e 's/{//g'|sed -e 's/hu:val://g'|awk '{printf("%d",$1 + 0.5)}')
eval ILLUMI${REMONUM}=$(sed -n ${REMONUM}p /tmp/remo |awk '{print substr($0, index($0, "\"il\""))}'|awk '{sub("created.*", "");print $0;}'|sed -e 's/"//g'|sed -e 's/,//g'|sed -e 's/{//g'|sed -e 's/il:val://g'|awk '{printf("%d",$1 + 0.5)}')
		echo -e -n "\t\t"
		eval echo '{ \"{#REMONAME}\":\"''$NAME'$REMONUM'\",\"{#REMOTEMP}\":\"''$TEMP'$REMONUM'\",\"{#REMOHUMI}\":\"''$HUMI'$REMONUM'\",\"{#REMOILLUMI}\":\"''$ILLUMI'$REMONUM'\" }'
REMONUM=`expr $REMONUM - 2`;
i=`expr $i + 1`
if [ $i -le $loop ]; then
echo -e -n ","
elif [ $i -gt $loop ]; then
break
fi
done

echo -e -n '\t]\n'
echo "}"


#cat /tmp/remo2


#input

#chmod 777 /tmp/remo*
#rm /tmp/remo*
exit 0
