%lastP : row vector , first entry for states 2 
function [vainfo]=ViterbiAlign(hmms,obs)
states=[];
logP=[];
htk_global;
N_FEATURE=size(obs,2);
N_OBS=size(obs,1);
traceback=zeros(3,N_OBS);
lastP=ones(1,hmms.nstates)*LZERO;
thisP=ones(1,hmms.nstates)*LZERO;

%from entry state: column1 
traceback(:,1)=[1 1 1]';
for currState=2:hmms.nstates+1
    disp(sprintf('currState %d',currState));
    tranP=hmms.start_prob(currState-1)  ;
    if tranP<LSMALL 
        
       lastP(currState-1)=LZERO;
    else
        lastP(currState-1)=tranP+DiagP(obs(1,:)',hmms,currState)
    end
    
end
ShowP(1,lastP);


% traceback(:,1)

%Columns[2] -> Columns[segLen] -- this is the general case 
   
for segIdx=2:N_OBS
% for segIdx=2:109
%     disp(sprintf('segIdx %d',segIdx));
    
    %currSate is actually the target state, it's a 'candidate' where we're
    %going to ...
    %prevState all possible state we're leaving fromm ...
    for currState=2:hmms.nstates+1
       
        bestPrevState=2;
       prevP=lastP(1);
       tranP=hmms.transmat(1,currState-1);
       if tranP<LSMALL
           bestP =LZERO ;
       else
           bestP=tranP+prevP;
       end
       
       for prevState=3:hmms.nstates+1
            tranP = hmms.transmat(prevState-1,currState-1);
            
            %@todo eliminating unsurvival path ...
%             if tranP<LSMALL
%                continue;
%             end
%             
            prevP = lastP(prevState-1);
            if (tranP<LSMALL)
               currP=LZERO;
            else
                currP=tranP+prevP;
            end
            
            if currP > bestP
               bestPrevState=prevState; bestP=currP;
            end

       end
       
       if bestP<LSMALL
           currP=thisP(currState-1);       
       else
           vobs=obs(segIdx,:)';
          currP=DiagP(vobs,hmms,currState);
          thisP(currState-1)=bestP+currP;
       end
       traceback(currState-1,segIdx)=bestPrevState;
    end
    lastP=thisP;
    ShowP(segIdx,lastP);


end

    %        /* column[segLen]--> exit state(numStates) */
       bestPrevState=2;
%        tranP = hmms.transmat(2,hmms.nstates+1); 
       tranP=hmms.end_prob(2);
       
       prevP = lastP(1);
       if tranP<LSMALL
          bestP=LZERO; 
       else
           bestP=tranP+prevP;
       end
       for prevState=3:hmms.nstates+1 
          tranP = hmms.transmat(prevState-1); prevP = lastP(prevState-1);
          if currP > bestP 
             bestPrevState=prevState; 
             bestP=currP;
          end
       end
    

%returning
vainfo.states=states;
vainfo.lastP=lastP;
vainfo.traceback=traceback;
