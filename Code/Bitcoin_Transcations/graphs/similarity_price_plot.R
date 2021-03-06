# Setting working dir
getwd()
setwd("/home/pankaj/MasterThesis")

#remove all the variables from the workspace
rm(list = ls())

library(ggplot2)
library(reshape)


# read data
P=read.csv(file="./data/btc_usd/daily_price_march_april.csv",head=TRUE,sep=",")

P=read.csv(file="./data/btc_usd/daily_price_2009_2016.csv",head=TRUE,sep=",")

colnames(P) <- tolower(colnames(P))

P$time <- as.Date( as.character( P$time ) )
names(P)
P

cor(P$log_close,P$sim_index)

# Scatterplot between two varibales
plot(P$sim_index,P$close, main="Scatterplot", xlab="Sim_Index ", ylab="Close", col=c("red","blue"),pch=19)

# Scatterplot between two varibales
plot(P$sim_index,P$log_close, main="Scatterplot", xlab="Sim_Index ", ylab="Close", col=c("red","blue"),pch=19)
#
ccf(P$sim_index,P$log_close)



# Get into dataframe for ggplot
DF = data.frame(P)

str(DF)

# Plot the time series of market price

with(DF, plot(time, close, type="l", col="red3", 
              ylab="Price(USD))",
              ylim=c(0,1200)))

# Plot daily transcations

with(DF, plot(time, daily_transcations, type="l", col="red3", 
              ylab="Transcations",
              ylim=c(0,250000)))



#Plot tow graphs in same plot.

g<- ggplot(DF, aes(time))
g<- g1 + geom_line(aes(y=close), colour="red")
g<- g + geom_line(aes(y=sim_index), colour="green")
g

par(mar = c(5,5,2,5))

with(DF, plot(time, log_close, type="l", col="red3", 
             ylab="log (Price)",
             ylim=c(0,3)))

par(new = T)
with(DF, plot(time, sim_index, type="l", col= "blue", ylim=c(0, 0.1),axes=F, xlab=NA, ylab=NA, cex=1.2))
axis(side = 4)
mtext(side = 4, line = 3, 'Similarity Index')
legend("topleft",
       legend=c("Log Price (USD)", "Similarity Metric"),
       lty=c(2,1), col=c("red3", "blue"))


