%****************** Compute new V from old V and transition matrices ******
function vNew = getVnew(v,profitVec,investmentCost,beta,transMatInvest,transMatNoInvest)

vNew = profitVec+log(exp(-investmentCost+beta*transMatInvest*v)+exp(beta*transMatNoInvest*v));