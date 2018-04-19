% calculate log probability of diag covariance mix/obs
%currstate : true state, will be decrease by one index
function logp=DiagP(obs,hmms,currState)
htk_global;
logp=LZERO;
%   obs(1:4)
sum_1 = hmms.gconst(currState-1);
means=hmms.means(:,currState-1);
% means(1:4)
cov_var=hmms.covars(:,currState-1);
%  cov_var(1:4);
upper_1=obs-means;
upper_1=upper_1.*upper_1;
upper_1=upper_1./cov_var;
sum_1=sum_1+sum(upper_1);
logp =-0.5*sum_1;



  
%   static LogFloat DOutP(Vector x, int vecSize, MixPDF *mp)
% {
%    int i;
%    float sum,xmm;su

% 
%    sum = mp->gConst;
%    for (i=1;i<=vecSize;i++) {
%       xmm=x[i] - mp->mean[i];
%       sum += xmm*xmm/mp->cov.var[i];
%    }
%    return -0.5*sum;
% }
