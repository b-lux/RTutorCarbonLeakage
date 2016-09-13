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




