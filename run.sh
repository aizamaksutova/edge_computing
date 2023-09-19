#! /bin/bash
TransferSize=32000000
SpeedTestTime=100
array=(0 5 10 15 20 25 30)
./ModifyArg.sh $TransferSize
for i in "${array[@]}"; do
  echo "$i "
  sleep 1
  ./killStressor.sh
  for ((j = 1; j <= i; ++j)); do
    echo "$j Time"
    ./StressorScript.sh >/dev/null &
  done
  sleep 5
  ./gpu_operations
  mv inference_timings.txt $i.txt
  ./killStressor.sh
done
mkdir data
mv *.txt data/
