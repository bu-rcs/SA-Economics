library(gmm)
library("Ecdat")
data(Benefits)

dat <- data.matrix(cbind(Benefits$ui, 1, Benefits$age, Benefits$dkids, Benefits$dykids, 
                         Benefits$head, Benefits$sex, Benefits$married, Benefits$rr))

logistic <- function(theta, data) {
  return(1/(1 + exp(-data %*% theta)))
}

moments <- function(theta, data) {
  y <- as.numeric(data[, 1])
  x <- data.matrix(data[, 2:9])
  m <- x * as.vector((y - logistic(theta, x)))
  return(cbind(m))
}

init <- c(0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2)
#init <- c(0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8)
#init <- c(-0.5,0.4,0.3,0.2,0.1,0.1,0.1,0.2)

my_gmm <- gmm(moments, x = dat, t0 = init, type = "iterative", 
              crit = 1e-25, wmatrix = "optimal", 
              method = "Nelder-Mead", control = list(reltol = 1e-25, maxit = 20000))

summary(my_gmm)
