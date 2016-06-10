#!bin/bash

for schedule in static dynamic guided
do
export OMP_SCHEDULE="$schedule"
for nthreads in 1 2 4 8 16 32 64
do
for seq in 1 2 3 4 5 6 7 8 9 10
do
echo "schedulling setted to $OMP_SCHEDULE"
echo   "./ex2_v2 $nthreads"
dtrace -s threaded.d -c "./ex2_v2 $nthreads" >> "DTRACE_"$schedule"_"$nthreads"_"$seq".csv"
done
done
done

mkdir __csv
mv DTRACE*.csv __csv
