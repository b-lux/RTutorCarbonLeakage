# Extra Code file, that can be reached within the whole problem set

risk = function(data, b, damage){
  batchsize = 15000
  return(data[,damage]/(1+exp(data[,"beta0"]+data[,"beta1"]*batchsize*b)))
}

risk.sec = function(data, b, damage){
  batchsize = 15000
  return(data[,damage]/(1+exp(data[,"beta0"]+data[,"beta1"]*batchsize*b*data[,"sh_grandf_sec"])))
}

permits = function(data, pieces, damage){
  piecesize = ifelse(damage == "co2",2000,5)
  return(ifelse(piecesize*pieces<data[,damage]/(1+exp(data[,"beta0"])),
                1/data[,"beta1"]*(log(data[,damage]/(piecesize*pieces)-1)-data[,"beta0"]),
                0))
}

cbPalette = c("#999999", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")

# cake = function(Firm.risk){
#   # Initialization 
#   no.firms = length(Firm.risk[1,])
#   no.batches = length(Firm.risk[,1])-1
#   Allocation = matrix(0, nrow = no.batches+1, ncol = no.firms)
#   policy = vector("numeric", no.firms)
#   value = vector("numeric", no.firms)
#   
#   # Last firm in the sequence
#   b.prime = 0:no.batches
#   v.prime = Firm.risk[,no.firms]
#   Allocation[,no.firms] = b.prime
#   
#   # Next to last firm till first firm
#   for (firm in 1:(no.firms-1)){
#     V.old = Toeplitz(v.prime, rep(1E20, times=no.batches+1))         
#     r = Firm.risk[,no.firms - firm]            
#     R = t(matrix(1, nrow = no.batches+1, ncol = no.batches+1)*r)
#     R[upper.tri(R)]=0
#     V = V.old + R
#     
#     v.prime = apply(V,1,min)
#     b.prime = apply(V,1, which.min)-1
#     Allocation[,no.firms-firm] = b.prime
#   }
#   
#   # Work out optimal allocation
#   rest = no.batches
#   vopt = v.prime[no.batches+1]
#   
#   for (i in 1:no.firms){
#     policy[i] = Allocation[rest+1,i]
#     value[i] = Firm.risk[policy[i]+1,i]
#     rest = rest - policy[i]
#   }
#   
#   # Return Solution
#   return (list(policy=policy, value=value, vopt=vopt))
#   
# }
# 
# data.prep.firm = function(opt,ref,damage,data){
#   # Calculate total number of free permits in the reference scenario
#   total.permits.ref = sum(data[,ref])
#   # Calculate total risk in the reference scenario
#   total.risk.ref = sum(data$risk.ref)
#   # Calculate maximum total risk (zero allocation)
#   max.risk = sum(data$risk.zero*(data$beta1==0))
#   # Define batch-/piecesize depending on the optimization type 
#   # and damage weight. Calcualte the amount
#   # of batches/pieces available for allocation.
#   if(opt == "risk"){
#     piecesize = 15000
#     pieceamount = as.integer(total.permits.ref/piecesize)
#   }else{
#     piecesize = 5
#     if(damage == "co2"){
#       piecesize = piecesize*400
#     }
#     pieceamount = as.integer((total.risk.ref-max.risk)/piecesize)
#   }
#   # For the optimization only consider firms that 
#   # respond to changes in allocated permits
#   dat = filter(data,
#                beta1!=0)
#   nofirms = length(dat$beta0)
#   
#   # Create a vector containing all possible batch/piece 
#   # allocations (including 0 allocation). In the 'cost' type optimization 
#   # the piece-argument to the 'permits()' function is not allowed to be 0.
#   pieces = 0:(pieceamount)
#   pieces[1] = 1E-15            
#   
#   # For each firm calculate the objective function contribution 
#   # for each possible batch/permit allocation. Contributions are 
#   # calculated either with the function 'risk()' or 'pieces()' depending 
#   # on the optimization type.
#   M = matrix(0, nrow=pieceamount+1 , ncol=nofirms)
#   if(opt == "risk"){
#     M = t(sapply(pieces, risk, data = dat, damage = damage))
#   }else{
#     M = t(sapply(pieces, permits, data = dat, damage = damage))
#   }
#   # Return M  
#   return(M)
# } 
# 
# 
# 
# data.prep.sector = function(ref,damage,data){
#   opt = "risk"
#   # Calculate total number of free permits in the reference scenario
#   total.permits.ref = sum(data[,ref])
#   # Calculate total risk in the reference scenario
#   total.risk.ref = sum(data$risk.ref)
#   # Calculate maximum total risk (zero allocation)
#   max.risk = sum(data$risk.zero*(data$beta1==0))
#   # Define batchsize 
#   # Calcualte the amount of batchesavailable for allocation.
#   piecesize = 15000
#   pieceamount = as.integer(total.permits.ref/piecesize)
#   # For the optimization only consider sectors in which firms 
#   # respond to changes in allocated permits
#   dat = filter(data,
#                sec_beta1!=0)
#   nofirms = length(dat$beta0)
#   # Create a vector containing all possible batch 
#   pieces = 0:(pieceamount)
#   # For each firm calculate the objective function contribution 
#   # for each possible batch allocation. Contributions are 
#   # calculated with the function 'risk.sec()'. This function 
#   # is similar to 'risk()' but takes a firms permit amount
#   # as a share of the sectors permit amount.  
#   M = sapply(pieces, risk.sec, data = dat, damage = damage)
#   # Aggregate risk figures on the sector level.
#   S = t(rowsum(M, dat$sec4dig))
#   # Return S  
#   return(S)
# } 



