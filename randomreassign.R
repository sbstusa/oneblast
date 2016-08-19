
The code below generates a simulated dataset, in which, for each batch, are randomly assigned as being subscribers.

```{r sensitivity}
#
# Function to randomly reassign unmatched cases by batch day
data_fn<-function(x="treatmentF"){
	# Split data in subscribers and non subscribers
	newdat<-wrkdat[,c("subscribedF","batchday2F",x)]
	newdat<-newdat[order(newdat$batchday2F),]
	newdat_1<-newdat[newdat$subscribed==1,]
	newdat_1$subscribed_bnd<-newdat_1$subscribed
	newdat_0<-newdat[newdat$subscribed==0,]
	batch_assign_fn<-function(batch,size){
		x<-newdat_0$subscribed[newdat_0$batchday2F==batch]
		x<-replace(newdat_0$subscribed[newdat_0$batchday2F==batch],sample(1:length(newdat_0$subscribed[newdat_0$batchday2F==batch]),size),1)
		return(x)
	}
	newdat_0$subscribed_bnd<-unlist(mapply(batch_assign_fn,batch=unmatchables[,1],size=unmatchables[,2]))
	stopifnot(table(newdat_0$subscribed_bnd,newdat_0$batchday2F)[2,]==unmatchables[,2])
	# Recombine
	newdat<-rbind(newdat_1,newdat_0)
	return(newdat)
}
```

So for example, we know that in the first batch, 24 cases in the subscribe list are unmatchable. In the each simulated dataset 24 cases in batch 1 are randomly assigned to be treated. In the code below, we see one simulation where for batch 1, treatment groups A and B receive three extra subscribers, C recieves five, D four, E seven, and F two.

```{r examp}
set.seed(123)
example.df<-data_fn()
with(wrkdat,table(subscribedF,batchday2F))
with(example.df[example.df$batchday2F==1,],table(subscribed_bnd,treatmentF))-
	with(wrkdat[wrkdat$batchday2F==1,],table(subscribedF,treatmentF))

```

Next we generate 1000 simulated datasets. Each time the unmatched cases in each batch are randomly assigned to be subscribers. For each simulated dataselt, we re-run the tests above (namely the generalized CMH tests and the Tukey HSD test pairwise comparisons) and save the results.


```{r cmhSim,results="asis"}

# Set seed
set.seed(123)
# Number of simulations
nsim<-1000

# Function to Simulate CMH Tests

sim_cmh_fn<-function(treat){
	# Generate data
	df<-data_fn(x=treat)
	# Write formula
	f <- reformulate(paste(treat,"|batchday2F"),response="subscribed_bnd")
	# CMH Test, use asymptotic results for now for now
	cmh<-cmh_test(f,data=df)
	# Collect test stat and pvalue
	stat<-statistic(cmh)
	pval<-pvalue(cmh)
	return(cbind(stat,pval))
}



# Use mosaic's do wrapper
## library(mosaic)

sim_cmh_all<-do(nsim)*sim_cmh_fn(treat="treatmentF")
sim_cmh_all$Comparison<-"All Treatments"
sim_cmh_bdf<-do(nsim)*sim_cmh_fn(treat="treat_bdf")
sim_cmh_bdf$Comparison<-"BDF vs ACE"
sim_cmh_abcd<-do(nsim)*sim_cmh_fn(treat="treat_abcd")
sim_cmh_abcd$Comparison<-"ABCD vs EF"
sim_cmh_ab<-do(nsim)*sim_cmh_fn(treat="treat_ab")
sim_cmh_ab$Comparison<-"AB vs CD"

# Combine results for plotting and summary
sim_cmh<-rbind(
	       sim_cmh_all,
	       sim_cmh_bdf,
	       sim_cmh_abcd,
	       sim_cmh_ab

	       )
sim_cmh$Comparison<-factor(sim_cmh$Comparison,levels=c("All Treatments",
						       "BDF vs ACE",
						       "ABCD vs EF",
						       "AB vs CD"
						       ))
# Percent of tests yielding significant differnces
library(plyr)
tab_sim_cmh<-ddply(sim_cmh,.(Comparison),summarize,
		   Percent=mean(pval<0.05)*100

		   )
kable(tab_sim_cmh[,c("Comparison","Percent")],
      caption ="Percent of Simulations Yielding Significant Difference" )
```


```{r figCMHsim}
p_sim_cmh_all<-ggplot(sim_cmh,aes(pval))+geom_density(bw=1/2000)+geom_rug()+facet_wrap(~Comparison)+labs(title="Distribution of p-values from CMH simulations")
p_sim_cmh_all


```


```{r tukeySim}
# Simulate Tukey Comparisons

sim_tukey_fn<-function(treat="treatmentF"){
	df<-data_fn(x=treat)
	df$subscribed_bnd<-as.numeric(df$subscribed_bnd)
	df$sBatchAve<-ave(df$subscribed_bnd,df$batchday2F)
	a1<-aov(I(subscribed_bnd-sBatchAve)~treatmentF,df)
	tukey<-data.frame(TukeyHSD(a1)$treatmentF)
	tukey$Comparison<-factor(rownames(tukey),levels=rev(rownames(tukey)))
	return(tukey)
}
sim_tukey<-do(nsim)*sim_tukey_fn()
library(plyr)
```

```{r tukeytab,results="asis"}
sim_tukey_df<-ddply(sim_tukey,.(Comparison),summarize,
		    diff=mean(diff),
		    lwr=mean(lwr),
		    upr=mean(upr),
		    Percent=mean(p.adj<.05)*100
		    )

kable(sim_tukey_df[,c("Comparison","Percent")],
      caption ="Percent of Simulations Yielding Significant Difference" )

```

```{r figTukeypval}
p_pw_pval_sim<-ggplot(sim_tukey,aes(p.adj,col=Comparison))+geom_density(bw=1/100)+facet_wrap(~ Comparison)+geom_rug()+labs(x=paste(nsim,"simulated p-values from pairwise comparison"),title="Distribution of p-values from Tukey HSD simulations")
p_pw_pval_sim
```

```{r figTukeycoef}
p_tukey_sim<-ggplot(sim_tukey_df,aes(y=Comparison,x=diff))+
	geom_vline(xintercept=0,linetype = 2,col="red")+
	geom_errorbarh(aes(xmin=lwr,xmax=upr),height=.25,col="grey")+
	geom_point()+ labs(x="Difference in proportions",title="95% family-wise confidence level from Tukey HSD Simulations")

p_tukey_sim
```
