#defining the data
made_7<-44
miss_7<-90
made_6<-61
miss_6<-64

#calculating OR
OR<-(made_7/miss_7)/(made_6/miss_6)
OR

#Taking the log(OR) for computing the CI
ln_OR<-log(OR)

#Calculating the SE for log(OR)
SE_lnOR<-sqrt((1/made_7)+(1/miss_7)+(1/made_6)+(1/miss_6))

# Calculating CI on log scale
lci_lnOR<-ln_OR-(1.96*SE_lnOR)
uci_lnOR<-ln_OR+(1.96*SE_lnOR)

#checking that this seems right on the log scale
c(ln_OR,lci_lnOR,uci_lnOR)

#anti-logging the CI
lci_OR<-exp(lci_lnOR)
uci_OR<-exp(uci_lnOR)

#Final Results - OR and the 95% CI
c(OR,lci_OR,uci_OR)