#cp /media/joesmart/RESEARCHS/RESEARCHS/htk/datas/cmu/packed/cmu_us_bdl_arctic/wav/arctic_a0001.wav ./
#cp /media/joesmart/RESEARCHS/RESEARCHS/htk/datas/cmu/packed/cmu_us_bdl_arctic/lab/arctic_a0001.lab ./cmulab
#mkdir -p cmulab lab

HTKTOOLSDIR="../../neural_network_shmm/htk_35/HTKTools"
#cmd="$HTKTOOLSDIR/HLEd  -T 2  -G ESPS -P HTK -i labhtk.mlf cmutohtk.ed    ./cmulab/*.lab"
#echo $cmd ; eval $cmd


#cmd="$HTKTOOLSDIR/HLEd  -T 2  -G ESPS -P HTK -l lab cmutohtk.ed    ./cmulab/*.lab"
#echo $cmd ; eval $cmd


#cp proto_MFCC_D_A_0_Z proto

#cp proto VOI ; echo fix VOI first [ENTER!] ; read
#cp proto UNV


#cmd="$HTKTOOLSDIR/HCopy -T 7 -C configcopy.txt arctic_a0001.wav arctic_a0001.mfc "
#echo $cmd ; eval $cmd

mkdir -p hinitoutput
#-m 1, minum segmen 1
cmd="$HTKTOOLSDIR/HInit  -C configtrain.txt -T 3  -m 1 -M hinitoutput VOI arctic_a0001.mfc"
echo $cmd ; eval $cmd
cmd="$HTKTOOLSDIR/HInit  -C configtrain.txt -T 3  -m 1 -M hinitoutput UNV arctic_a0001.mfc"
echo $cmd ; eval $cmd



