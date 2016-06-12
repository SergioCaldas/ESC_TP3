#!/bin/bash

mkdir __best_simulation
cd __csv

for schedule in static dynamic guided
do
  for nthreads in 1 2 4 8 16 32 64
  do
    for file in "DTRACE_"$schedule"_"$nthreads"_"*".csv" 
    do
      minimum=$(cat $file | grep "tempo -> " | sed 's/[^0-9.]*//g')
      echo $minimum " , " $file >> "minimum_"$schedule"_"$nthreads".min"
    done
  done
done

echo "going to get best simulation"

for schedule in static dynamic guided
do
  for nthreads in 1 2 4 8 16 32 64
  do
    sort "minimum_"$schedule"_"$nthreads".min" | head -n 1 > "../__best_simulation/best_"$schedule"_"$nthreads".csv"
  done
done

rm *.min
cd ..
cd __best_simulation

gawk -F, '{ print $2 }' *.csv > "../simulation_list.txt"
