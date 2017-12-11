flattenlist <- function(x){  
  morelists <- sapply(x, function(xprime) class(xprime)[1]=="list")
  out <- c(x[!morelists], unlist(x[morelists], recursive=FALSE))
  if(sum(morelists)){ 
    Recall(out)
  }else{
    return(out)
  }
}
