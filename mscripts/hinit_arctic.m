clc ;
clear all;

addpath /home/joesmart/RESEARCHS/htkbook_to_c_code/matlab/voicebox
addpath /home/joesmart/RESEARCHS/htkbook_to_c_code/matlab/matlab_htk-master
[d,fp,dt,tc,t]=readhtk('arctic_a0001.mfc');
% dt,tc
% dwr=d(1:4,1:7)
% dlmwrite('arctic_a0001.txt',dwr,'\t');

% hmms=read_htk_hmm('VOI');
% 
% nobs=size(d,1) 
N_FEATURE=size(d,2);
% 
% %for x=1:nobs
% for x=1:1
% 	obs=(d(x,:))';
% 		
% 	%for i_s=2:4
% 	for i_s=2:2
% 		
% 	covars=hmms.covars(:,i_s-1);
% 	means=hmms.means(:,i_s-1);	
% 	%so=size( obs)
% 	%sc=size (covars)
% 	%gconst=N_FEATURE*log(2*pi)+sum(covars)
% 	%obs_part= ((obs-means).^2)./covars;
% 	%sop=size(obs_part)
% 	%obs_part=sum(obs_part)
% 	end
% end

cluster.nobs=108;
cluster.obs=d(1:cluster.nobs,:);
cluster.means=mean(cluster.obs);
e_X2=cluster.obs.^2;
e_X2=sum(e_X2)/cluster.nobs;
eX_2=cluster.means.^2;
cluster.cVar=e_X2-eX_2;
clusterset(1)=cluster;


cluster.nobs=107;
cluster.obs=d(2+cluster.nobs:1+2*cluster.nobs,:);
cluster.means=mean(cluster.obs);
e_X2=cluster.obs.^2;
e_X2=sum(e_X2)/cluster.nobs;
eX_2=cluster.means.^2;
cluster.cVar=e_X2-eX_2;
clusterset(2)=cluster;

start=216;
cluster.nobs=107;
cluster.obs=d(start:start-1+cluster.nobs,:);
cluster.means=mean(cluster.obs);
e_X2=cluster.obs.^2;
e_X2=sum(e_X2)/cluster.nobs;
eX_2=cluster.means.^2;
cluster.cVar=e_X2-eX_2;
clusterset(3)=cluster;

%clusterset(1).cVar
%clusterset(2).cVar
%clusterset(3).cVar






