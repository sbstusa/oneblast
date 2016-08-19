# Function to make tables
table.maker<-function(x){
    # Difference of Proportions
    test<-stats::prop.test(table(x,wrkdat$subscribe01)[,c(2,1)])
    diff<- sprintf("%.4f",round(test$estimate[1]-test$estimate[2],5))
    pval<- sprintf("%.4f",round(test$p.value,5))
    # MH Test using Batch
    mhtest<-mantelhaen.test(table(x,wrkdat$subscribe,wrkdat$Batch))
    mhtest.pval<-sprintf("%.3f",round(mhtest$p.value,3))
    mhtest.stat<-sprintf("%.3f",round(mhtest$statistic,3))
    tab<-rbind(table(x),
               table(wrkdat$subscribe,x),
               paste("**",round(unlist(lapply(split(wrkdat$subscribe01,f=x),mean)),4),"**",sep=""),c(" "," "),
               c("*Statistic*","*p-value*"),
               c(diff,pval),
               c( mhtest.stat,mhtest.pval))
    rownames(tab)<-c("**Sample**","Subscribed","Not Subscribed","Proportion Subscribing","___","**Test**","Difference in Proportions"," CMH $\\chi^2$ Test")
    colnames(tab)<-paste("**",colnames(tab),"**",sep="")
    return(tab)
    
    
}