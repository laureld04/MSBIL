#!/bin/bash
# summarizeDW.sh
# First entry is directory

echo 'generating summary information for' $1/

start_dir=`pwd`;
cd $1
scan_list=`ls -d *`;

outfileM=$1/summaryDW.csv;

echo 'scan directory, scan date, method, TE, TR, segments, NEX, Reps, orientation, FOVRO, FOVPE, FOVSL, MTXRO, MTXPE, MTXSL, d,D,b,dirset,RG' > $outfileM

for scan_dir in $scan_list
do

if [ -e $scan_dir/pdata/1/2dseq ] 
then
echo $1/$scan_dir
methfile=$scan_dir/method;
acqpfile=$scan_dir/acqp;

scan_date=$(sed -n '6p' $methfile);
scan_directory=$(sed -n '7p' $methfile);

method=$(grep Method= $methfile | cut -d'=' -f 2);
method=$(grep Method= $methfile | cut -d'=' -f 2);
TE2=$(grep EchoTime= $methfile | cut -d'=' -f 2);
TE=$(echo $TE2 | cut -d' ' -f 1);
TR=$(grep PVM_RepetitionTime= $methfile | cut -d'=' -f 2);

if grep -q NSegments= $methfile
then
segments=$(grep NSegments= $methfile | cut -d'=' -f 2);
else
segments='';
fi

nex=$(grep NAverages= $methfile | cut -d'=' -f 2);
reps=$(grep NRepetitions= $methfile | cut -d'=' -f 2);
spatial=$(grep PVM_SpatDimEnum= $methfile | cut -d'=' -f 2);
orientation=$(grep -A 1 PVM_SPackArrSliceOrient= $methfile | sed -n '2p');

RxFOV=$(grep -A 1 PVM_FovCm= $methfile | sed -n '2p' | cut -d' ' -f 1-3);
RxMTX=$(grep -A 1 PVM_Matrix= $methfile | sed -n '2p' | cut -d' ' -f 1-3);

delta=$(grep -A 1 PVM_DwGradDur= $methfile | sed -n '2p' | cut -d' ' -f 1);
D=$(grep -A 1 PVM_DwGradSep= $methfile | sed -n '2p' | cut -d' ' -f 1);
b=$(grep -A 1 PVM_DwBvalEach= $methfile | sed -n '2p' | cut -d' ' -f 1);
dirset=$(grep PVM_DwNDiffDir= $methfile | cut -d'=' -f 2 | cut -d' ' -f 1);
RG2=$(grep -A 1 RG= $acqpfile | cut -d'=' -f 2);
RG=$(echo $RG2 | cut -d' ' -f 1);

echo $scan_directory ,$scan_date , $method , $TE , $TR , $segments, $nex, $reps, $orientation, $(echo $RxFOV | cut -d' ' -f 1) , $(echo $RxFOV | cut -d' ' -f 2) , $(echo $RxFOV | cut -d' ' -f 3) , $(echo $RxMTX | cut -d' ' -f 1) , $(echo $RxMTX | cut -d' ' -f 2) , $(echo $RxMTX | cut -d' ' -f 3), $delta, $D, $b, $dirset, $RG  >> $outfileM


fi
done

cd $start_dir