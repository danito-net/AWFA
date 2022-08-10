#!/usr/bin/env bash

# Danny Ismarianto Ruhiyat
# 2022-08-10 07:00

gps_usb=/dev/ttyUSB0
tmp_file=/tmp/gps.txt

for (( ; ; )) ; do

    cat $gps_usb > $tmp_file &
    sleep 3
    cat_pid=$(ps ax | grep "cat $gps_usb" | grep -v DWC | grep -v grep | head -n1 | awk '{print $1}')
    kill $cat_pid
    signal_ok=$(grep "ANTENNA OK" $tmp_file | wc -l)

    if [ $signal_ok -gt 2 ] ; then

       lat_gps=$(grep GNGGA $tmp_file | tail -1 | awk -F, '{print $3}' | sed 's/^0*//' | sed 's/\.//')
       northern_hemisphere=$(grep GNGGA $tmp_file | tail -1 | awk -F, '{print $4}')
       lat_lenght=$(echo ${#lat_gps})
       lat_prefix_lenght=$(($lat_lenght - 7))
       lat_prefix=$(echo ${lat_gps:0:$lat_prefix_lenght})
       lat_suffix7=$(echo ${lat_gps: -7})
       if [ x$northern_hemisphere == "xS" ] ; then lat_prefix=$(echo \-$lat_prefix) ; fi

       echo -n $lat_prefix\.$lat_suffix7\,

       lon_gps=$(grep GNGGA $tmp_file | tail -1 | awk -F, '{print $5}' | sed 's/^0*//' | sed 's/\.//')
       eastern_hemisphere=$(grep GNGGA $tmp_file | tail -1 | awk -F, '{print $6}')
       lon_lenght=$(echo ${#lon_gps})
       lon_prefix_lenght=$(($lon_lenght - 7))
       lon_prefix=$(echo ${lon_gps:0:$lon_prefix_lenght})
       lon_suffix7=$(echo ${lon_gps: -7})
       if [ x$eastern_hemisphere == "xW" ] ; then lon_prefix=$(echo \-$lon_prefix) ; fi

       echo $lon_prefix\.$lon_suffix7
       
    else

       echo Found $signal_ok line!
       break

    fi

done

echo Exited!
