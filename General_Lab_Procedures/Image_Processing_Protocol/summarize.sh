#!/bin/bash
# summarize.sh

echo 'generating summary information for' $1/

start_dir=`pwd`;
cd $1
scan_list=`ls -d *`;

outfileM=$1/summaryMethod.csv;
outfileR=$1/summaryReco.csv;

#echo $1/summary.csv
echo 'scan directory, method, TE, TR, flip angle, phase advance, segments, NEX, Reps, spatial, orientation, FOVRO, FOVPE, FOVSL, MTXRO, MTXPE, MTXSL,blip' > $outfileM
echo 'scan directory, FOVRO, FOVPE, FOVSL, MTXRO, MTXPE, MTXSL' > $outfileR

for scan_dir in $scan_list
do

if [ -e $scan_dir/pdata/1/2dseq ] && (( $scan_dir <= 9 ))
then
echo $1/$scan_dir
methfile=$scan_dir/method;
recofile=$scan_dir/pdata/1/reco;

method=$(grep Method= $methfile | cut -d'=' -f 2);
TE=$(grep EchoTime= $methfile | cut -d'=' -f 2);
TR=$(grep PVM_RepetitionTime= $methfile | cut -d'=' -f 2);
flipangle=$(grep ExcPulse1Ampl= $methfile | cut -d'=' -f 2);

if grep -q PhaseAdvance= $methfile
then
phaseadvance=$(grep PhaseAdvance= $methfile | cut -d'=(' -f 2 | cut -d' ' -f 2);
else
phaseadvance='';
fi

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

if grep -q PVM_SpatDimEnum='<'3D'>' $methfile
then 
RxFOV=$(grep -A 1 PVM_FovCm= $methfile | sed -n '2p' | cut -d' ' -f 1-3);
recoFOV=$(grep -A 1 RECO_fov= $recofile | sed -n '2p' | cut -d' ' -f 1-3);
RxMTX=$(grep -A 1 PVM_Matrix= $methfile | sed -n '2p' | cut -d' ' -f 1-3);
recoMTX=$(grep -A 1 RECO_size= $recofile | sed -n '2p' | cut -d' ' -f 1-3);

echo $scan_dir , $method , $(echo $TE | cut -d' ' -f 1) , $TR , $flipangle, $phaseadvance, $segments, $nex, $reps, $spatial, $orientation, $(echo $RxFOV | cut -d' ' -f 1) , $(echo $RxFOV | cut -d' ' -f 2) , $(echo $RxFOV | cut -d' ' -f 3) , $(echo $RxMTX | cut -d' ' -f 1) , $(echo $RxMTX | cut -d' ' -f 2) , $(echo $RxMTX | cut -d' ' -f 3)  >> $outfileM
echo $scan_dir , $(echo $recoFOV | cut -d' ' -f 1) , $(echo $recoFOV | cut -d' ' -f 2) , $(echo $recoFOV | cut -d' ' -f 3), $(echo $recoMTX | cut -d' ' -f 1) , $(echo $recoMTX | cut -d' ' -f 2) , $(echo $recoMTX | cut -d' ' -f 3) >> $outfileR

elif grep -q PVM_SpatDimEnum='<'2D'>' $methfile
then 
RxFOV=$(grep -A 1 PVM_FovCm= $methfile | sed -n '2p' | cut -d' ' -f 1-2);
recoFOV=$(grep -A 1 RECO_fov= $recofile | sed -n '2p' | cut -d' ' -f 1-2);
RxMTX=$(grep -A 1 PVM_Matrix= $methfile | sed -n '2p' | cut -d' ' -f 1-2);
recoMTX=$(grep -A 1 RECO_size= $recofile | sed -n '2p' | cut -d' ' -f 1-2);
RxSlices=$(grep -A 1 PVM_SPackArrNSlices= $methfile | sed -n '2p' | cut -d' ' -f 1);
RxThickness=$(grep PVM_SliceThick= $methfile | cut -d'=' -f 2);
#FOVSL=

echo $scan_dir , $method , $(echo $TE | cut -d' ' -f 1), $TR , $flipangle, $phaseadvance, $segments , $nex, $reps, $spatial, $orientation, $(echo $RxFOV | cut -d' ' -f 1) , $(echo $RxFOV | cut -d' ' -f 2) , $RxThickness , $(echo $RxMTX | cut -d' ' -f 1) , $(echo $RxMTX | cut -d' ' -f 2) , $RxSlices >> $outfileM
echo $scan_dir , $(echo $recoFOV | cut -d' ' -f 1) , $(echo $recoFOV | cut -d' ' -f 2), $RxThickness, $(echo $recoMTX | cut -d' ' -f 1) , $(echo $recoMTX | cut -d' ' -f 2) , $RxSlices >> $outfileR

fi

fi
done


for scan_dir in $scan_list
do
if [ -e $scan_dir/pdata/1/2dseq ] &&  (($scan_dir >= 10))
then
echo $1/$scan_dir
methfile=$scan_dir/method;
recofile=$scan_dir/pdata/1/reco;
acqpfile=$scan_dir/acqp;

method=$(grep Method= $methfile | cut -d'=' -f 2);
TE=$(grep EchoTime= $methfile | cut -d'=' -f 2);
TR=$(grep PVM_RepetitionTime= $methfile | cut -d'=' -f 2);
flipangle=$(grep PVM_ExcPulseAngle= $methfile | cut -d'=' -f 2);

if grep -q PVM_EPI_BlipDir= $methfile
then
blip=$(grep PVM_EPI_BlipDir= $methfile | cut -d'=' -f 2);
echo blip
else 
blip='';
fi

if grep -q PhaseAdvance= $methfile
then
phaseadvance=$(grep PhaseAdvance= $methfile | cut -d'=' -f 2);
else
phaseadvance='';
fi

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

if grep -q PVM_SpatDimEnum='<'3D'>' $methfile
then 
RxFOV=$(grep -A 1 PVM_FovCm= $methfile | sed -n '2p' | cut -d' ' -f 1-3);
recoFOV=$(grep -A 1 RECO_fov= $recofile | sed -n '2p' | cut -d' ' -f 1-3);
RxMTX=$(grep -A 1 PVM_Matrix= $methfile | sed -n '2p' | cut -d' ' -f 1-3);
recoMTX=$(grep -A 1 RECO_size= $recofile | sed -n '2p' | cut -d' ' -f 1-3);

echo $scan_dir , $method , $(echo $TE | cut -d' ' -f 1) , $TR , $flipangle, $phaseadvance, $segments, $nex, $reps, $spatial, $orientation, $(echo $RxFOV | cut -d' ' -f 1) , $(echo $RxFOV | cut -d' ' -f 2) , $(echo $RxFOV | cut -d' ' -f 3) , $(echo $RxMTX | cut -d' ' -f 1) , $(echo $RxMTX | cut -d' ' -f 2) , $(echo $RxMTX | cut -d' ' -f 3)  >> $outfileM
echo $scan_dir , $(echo $recoFOV | cut -d' ' -f 1) , $(echo $recoFOV | cut -d' ' -f 2) , $(echo $recoFOV | cut -d' ' -f 3) , $(echo $recoMTX | cut -d' ' -f 1) , $(echo $recoMTX | cut -d' ' -f 2) , $(echo $recoMTX | cut -d' ' -f 3), $blip >> $outfileR

elif grep -q PVM_SpatDimEnum='<'2D'>' $methfile
then 
RxFOV=$(grep -A 1 PVM_FovCm= $methfile | sed -n '2p' | cut -d' ' -f 1-2);
recoFOV=$(grep -A 1 RECO_fov= $recofile | sed -n '2p' | cut -d' ' -f 1-2);
RxMTX=$(grep -A 1 PVM_Matrix= $methfile | sed -n '2p' | cut -d' ' -f 1-2);
recoMTX=$(grep -A 1 RECO_size= $recofile | sed -n '2p' | cut -d' ' -f 1-2);
RxSlices=$(grep -A 1 PVM_SPackArrNSlices= $methfile | sed -n '2p' | cut -d' ' -f 1);
RxThickness=$(grep PVM_SliceThick= $methfile |  cut -d'=' -f 2);

echo $scan_dir , $method , $(echo $TE | cut -d' ' -f 1) , $TR, $flipangle, $phaseadvance, $segments, $nex, $reps, $spatial, $orientation, $(echo $RxFOV | cut -d' ' -f 1) , $(echo $RxFOV | cut -d' ' -f 2) , $RxThickness , $(echo $RxMTX | cut -d' ' -f 1) , $(echo $RxMTX | cut -d' ' -f 2) , $RxSlices  >> $outfileM
echo $scan_dir , $(echo $recoFOV | cut -d' ' -f 1) , $(echo $recoFOV | cut -d' ' -f 2) , $RxThickness , $(echo $recoMTX | cut -d' ' -f 1) , $(echo $recoMTX | cut -d' ' -f 2) , $RxSlices, $blip >> $outfileR

fi

fi

done

cd $start_dir
