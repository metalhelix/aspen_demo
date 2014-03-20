#!/bin/bash
TARGET=/n/projects/srm/docs/aspen/
for i in `find ${TARGET} -name "*.gz"`
do
  sleep $[ ( $RANDOM % 10 )  + 1 ]s
  cp $i $PWD &
done
wait
