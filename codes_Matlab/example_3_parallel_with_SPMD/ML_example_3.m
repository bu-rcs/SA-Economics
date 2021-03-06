beta           = 0.9; 
investmentCost = 3;
kMin    = 1;                            % minimum value of capitial allowed
kMax    = 40;                           % maximum value of the capital allowed
kStates = kMax-kMin+1;                  % number of possible values of state variables(capital) 
kVec    = linspace(kMin,kMax,kStates)';  % a kStates vector with the value of capital at each statements

%****************** Transition Matrices **********************************

% create transition matrix for capital if the firm does not invest, which % depends on depreciation transMatNoInvest = zeros(kStates,kStates); % transition matrix from one capital level to another. It is mostly zero.
depreciationRate = [0.15;0.35;0.5]; % capital stays the same with probability3, decreases by 1 with prob2, and by 2 states with prob1 for i = 3:kStates
for i = 3:kStates
    transMatNoInvest(i,(i-2):i)=depreciationRate'; 
end
transMatNoInvest(1,1)   = 1; % In state1, captial cannot go down.
transMatNoInvest(2,1:2) = [sum(depreciationRate(1:2)) depreciationRate(3)]; %In state 2, capital cannot go down by 2 states.

% create transition matrix for capital if firm does invest transMatInvest = zeros(kStates,kStates); for i = 3:(kStates-5)
for i = 3:(kStates-5)
    transMatInvest(i,(i+3):(i+5)) = depreciationRate'; 
end
transMatInvest(1,6) = 1; % In state1, capital cannot go down, so you will definitely go to state6
transMatInvest(2,6:7) = [sum(depreciationRate(1:2)) depreciationRate(3)]; % In state2, capital cannot go down by 2 states, you will definitely be in 6 or 7.
transMatInvest(kStates-4,(kStates-1):kStates) = [depreciationRate(1) sum(depreciationRate(2:3))]; %In state 96, capital can go to 99 or 100
transMatInvest((kStates-3):kStates,kStates) = ones(4,1);% Above 96, and investment automatically takes you to 100;

% for parallel processing:
matlabpool open;

%***********Now solve the Bellman equation via a fixed point algorithm***** profitVec = profit(kVec);
profitVec = profit(kVec)
% starting values
vn = distributed(profitVec/(1-beta));
v = vn - 1;

spmd
transMatInvest=codistributed(transMatInvest, codistributor('1d',1)); 
transMatNoInvest=codistributed(transMatNoInvest, codistributor('1d',1)); 
profitVec=codistributed(profitVec, codistributor('1d',1));

% starts Single Program Multiple Data parallel paradigm


% Fixed point algorithm
for i = 1:1000
    if mod(i,20) == 0
       if max(abs(vn-v))< 1e-7
          tol = 0;
          fprintf('converged to 1e-7 at iteration %5d\n',i);
          break;
       else
          tol = 1;
          fprintf('Not converge yet at iteration %5d\n',i);
       end
    end
    v = vn;
    vn = getVnew(v,profitVec,investmentCost,beta,transMatInvest,transMatNoInvest);
end
end  % spmd

matlabpool close;
'Finished with SPMD, ready to plot'

% Now graph the probability of investment at each level of capital probInvestment = exp(profitVec-investmentCost+beta*transMatInvest*v)./exp(v);
probInvestment = exp(profitVec-investmentCost+beta*transMatInvest*v)./exp(v);
plot(kVec,probInvestment);
saveas(gcf,'figure3.png')