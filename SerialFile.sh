#!/bin/bash

MODEM="$(ls -1 /dev/cu.* | grep -vi bluetooth | tail -1)"

OS="$(uname -s)"
if [ "$(uname -s)" == "Darwin" ];
  then
    OS="Darwin"
    STTYF="-f"
    MODEM="$(ls -1 /dev/cu.* | grep -vi bluetooth | tail -1)"
  else
    OS="Linux"
    STTYF="-F"
    MODEM="$(ls -1 /dev/* | grep "ttyACM" | tail -1)"
fi

if [ "$1" == "SerialRead" ]; #Write file to serial.
then
  rm SerialDump.txt
echo "r" > $MODEM

  while read line; do

    if echo $line | grep "EOF" ;
    then
      exit
    else
      echo "$line" >> SerialDump.txt
    fi

done < $MODEM
#   awk `
# /EOF/ {exit;}
#  {print;}` < $MODEM > file.txt
#  cat $MODEM | tee console.log
  #  tail $MODEM >> SerialDump.txt
  #  script -a -t 0 dump.txt screen $MODEM 9600
  #  echo "TEST" >> SerialDump.txt
  exit
fi

if [ "$1" == "SerialWrite" ]; #Read file to serial.
then
echo SerialDump.txt >> $MODEM
exit
fi

if [ "$1" == "help" ];
then
echo $OS
echo "
                            Welcome to serialFile
An open source Bash script for writing and reading to serial from files
Commands:
SerialRead: A simple command for reading from serial and writing to files.

SerialWrite: A simple command for Writing to seral from a file."


fi
