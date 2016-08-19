table.maker<-function(x,xnm=NULL,ynm,asymp=TRUE, reflevel=NULL){
	# Input:
	# x = treatment indicator
	# xnm = character name of treatment indicator in wrkdat
	# asymp = logical scale indicating whether asymptotic results should be used

	# Output:
	# table of descriptive statistics and tests

	if(!is.null(reflevel)){
		wrkdat[[xnm]]<-relevel(wrkdat[[xnm]],ref=reflevel)
	}

	# Difference of Proportions
	## The asymp version is almost same as the HC2 version below
	oneway_approx <- oneway_test(as.formula(paste(ynm,"~",xnm,"|batchday2F",collapse="")),data=wrkdat,distribution=approximate(B=1000))
	#oneway_asymp <- oneway_test(as.formula(paste(ynm,"~",xnm,"|batchday2F",collapse="")),data=wrkdat,distribution=asymptotic())
	oneway_approx.stat<-sprintf("%.4f",statistic(oneway_approx))
	oneway_approx.pval<-sprintf("%.4f",pvalue(oneway_approx))
	#oneway_asymp.stat<-sprintf("%.4f",statistic(oneway_asymp))
	#oneway_asymp.pval<-sprintf("%.4f",pvalue(oneway_asymp))

	## Diff of proportions
	thefmla<-as.formula(paste(ynm,"~",xnm,"*(",paste(colnames(Bmd)[-1],collapse="+"),")"))
	thelm<-lm(thefmla,data=wrkdat)
	thediff<-coef(thelm)[grep(":",grep(xnm,names(coef(thelm)),value=TRUE),invert=TRUE,value=TRUE)]
	theCI<-confint.HC(thelm,parm=names(thediff),thevcov=vcovHC(thelm,type="HC2"))
	thepval <- coeftest(thelm,vcov=vcovHC(thelm,type="HC2"))[names(thediff),"Pr(>|t|)"]
	theprops <- c(coef(thelm)[1],coef(thelm)[1] + coef(thelm)[names(thediff)])
	names(theprops)<-levels(wrkdat[[xnm]])
	names(thediff)<-paste(names(theprops)[-1],"vs",names(theprops)[1],sep="") ## the diffs are differences from one chosen level
	names(thepval)<-names(thediff)
	rownames(theCI)<-names(thediff)

	# MH Test using BatchDay
	mhtest<-my.mantelhaen.test(table(x,wrkdat[[paste(ynm,"F",sep="")]],wrkdat$batchday2F))
	mhtest.pval<-sprintf("%.4f",round(mhtest$p.value,4))
	mhtest.stat<-sprintf("%.4f",round(mhtest$statistic,4))
	mhtest.or<-try(sprintf("%.4f",round(mhtest$estimate,4)),silent=TRUE)
	if(inherits(mhtest.or,"try-error")){
		mhtest.or<-NA
		mhtest.or.ci<-paste("[",paste(c(NA,NA),collapse = "; "),"]",sep="")
	} else {
		mhtest.or.ci<-paste("[",paste(round(mhtest$conf.int,3),collapse = "; "),"]",sep="")
	}

	# Cochran-Mantel-Haenszel Test approximative (i.e. doesn't rely on large sample assumptions)
	cmh_approx<-cmh_test(formula(paste(ynm,"F","~",xnm,"|batchday2F",sep="")),data=wrkdat,distribution=approximate(B=1000))
	cmh_approx.stat<-sprintf("%.4f",statistic(cmh_approx))
	cmh_approx.pval<-sprintf("%.4f",pvalue(cmh_approx))

	tabcols<-length(theprops)
	diffandp<-rbind(sprintf("%.4f",thediff[names(thepval)]),sprintf("%.4f",thepval))
	colnames(diffandp)<-names(thepval)

	tab<-rbind(table(wrkdat[[xnm]]),
		   table(wrkdat[[ynm]],wrkdat[[xnm]]),
		   sprintf("%.4f",theprops),
		   rep(c(" "),tabcols),
		   cbind(matrix("",nrow=nrow(diffandp),ncol=tabcols-ncol(diffandp)),diffandp),
		   cbind(matrix("",nrow=nrow(diffandp),ncol=tabcols-ncol(diffandp)),t(round(theCI,4))),
		   rep(c(" "),tabcols),
		   c(mhtest.stat,mhtest.pval,rep(c(" "),tabcols-2)),
		   c(cmh_approx.stat,cmh_approx.pval,rep(c(" "),tabcols-2)),
		   c(mhtest.or,mhtest.or.ci,rep(c(" "),tabcols-2))
		   )

	rownames(tab)<-c("**Sample**","Not Subscribed","Subscribed","Proportion Subscribing",
			 "___",
			 paste("Difference in Proportions from",levels(wrkdat[[xnm]])[1]),
			 "pval for H0: No Diff",
			 "95% CI for Diff",
			 "95% CI for Diff",
			 "___",
			 "Asymp CMH Test",
			 "Approx CMH Test  ",
			 "Common Odds Ratio")

	colnames(tab)<-paste("**",colnames(tab),"**",sep="")
	return(tab)
}
