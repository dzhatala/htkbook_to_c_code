clc ;
clear all;

addpath /home/joesmart/RESEARCHS/htkbook_to_c_code/matlab/voicebox
addpath /home/joesmart/RESEARCHS/htkbook_to_c_code/matlab/matlab_htk-master
format long;
%HTK small numbers
LZERO=-1E-10;
LSMALL=-0.5E-10;

[d,fp,dt,tc,t]=readhtk('arctic_a0001.mfc');
N_OBS=size(d,1);
N_FEATURE=size(d,2);
% dt,tc

% dwr=d(1:4,1:7);
%dlmwrite('arctic_a0001.txt',dwr,'\t');

[o2,o3,o4]=uniform_segment(d,108,107,107);
%segments=uniform_segment(d,2,3,4);
%segments=uniform_segment(d,4,3,2);

state2.obs=o2;  state2.nobs=size(state2.obs,1);
state3.obs=o3;  state3.nobs=size(state3.obs,1);
state4.obs=o4;  state4.nobs=size(state4.obs,1);
state2.means=mean(state2.obs);
state3.means=mean(state3.obs);
state4.means=mean(state4.obs);

cluster=state2;
e_X2=cluster.obs.^2;
e_X2=sum(e_X2)/cluster.nobs;
eX_2=cluster.means.^2;
cluster.cVar=e_X2-eX_2;
clusterset(1)=cluster;

cluster=state3;
e_X2=cluster.obs.^2;
e_X2=sum(e_X2)/cluster.nobs;
eX_2=cluster.means.^2;
cluster.cVar=e_X2-eX_2;
clusterset(2)=cluster;

cluster=state4;
e_X2=cluster.obs.^2;
e_X2=sum(e_X2)/cluster.nobs;
eX_2=cluster.means.^2;
cluster.cVar=e_X2-eX_2;
clusterset(3)=cluster;


hmms=zread_htk_hmm('VOI');   %@TODO hmms.transmat NOT MATCH HTK % ...
%htk low number normalization

for i_s=2:4
    
    hmms.gconst(i_s-1)=N_FEATURE*log(2*pi)+sum(log(clusterset(i_s-1).cVar)); %@TODO not match HTK
    hmms.means(:,i_s-1)=clusterset(i_s-1).means';
    hmms.covars(:,i_s-1)=clusterset(i_s-1).cVar';
    
end
vainfo=ViterbiAlign(hmms,d);

%vainfo.lastP
