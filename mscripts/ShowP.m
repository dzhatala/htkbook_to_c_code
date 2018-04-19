function ShowP(col,pVec)
htk_global;
%sprintf('      %d     ',col);
% pVec
scol=num2str(col);
svec='';
for state=2-1:size(pVec,2)
   if pVec(state)<LSMALL
      svec=strcat(svec,'---');
   else
       svec=strcat(svec,num2str(pVec(state)));
   end
   
   svec=strcat(svec,'    |');
end
disp( sprintf('  %s      %s ',scol,svec));
% sprintf('hello');