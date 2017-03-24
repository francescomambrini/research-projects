#Color palette
pal<-brewer.pal(12, "Set3")
#Load the table
PnomTab<-read.table("~/Documents/lavoro/github/research-projects/SLE_Pub/VALID_History_Nominal_Obs.tsv", header = TRUE, sep = '\t', comment.char = "")
attach(PnomTab)
#Plot the data as spineplot:
spineplot(Predication.Type ~ Century)
spineplot(Predication.Type ~ ClauseType)

###CLAUSE TYPE
#We inspect how the type of predication varies according to the type of clause (main/subordinate) 
#get the frequency table:
freq.tab <- table(ClauseType,Predication.Type)
View(freq.tab)
#Chi-sq test
eval.ClauseType<-chisq.test(freq.tab, correct = F)
eval.ClauseType$expected
eval.ClauseType$residuals^2
#plot the results
assocplot(t(freq.tab), col = c("black", "darkgrey"))
#phi correlation score
#sqrt(eval.ClauseType$statistic/sum(freq.tab)*(min(dim(freq.tab)) -1 ))
sqrt(eval.ClauseType$statistic/sum(freq.tab))
eval.ClauseType

###Sbj POS
sbj.tab<-table(Sb.pos,Predication.Type)
View(sbj.tab)
#Chi-sq test
eval.SbPOS<-chisq.test(sbj.tab, correct = F)
eval.SbPOS
#Cramer's V correlation test
sqrt(eval.SbPOS$statistic/sum(sbj.tab)*(min(dim(sbj.tab)) -1 ))
assocplot(t(sbj.tab), col = c("black", "darkgrey"))

###Pnom POS
freq.tab<-table(Pnom.pos,Predication.Type)
View(freq.tab)
#Chi-sq test
eval.PnomPOS<-chisq.test(freq.tab, correct = F)
eval.PnomPOS
#Cramer's V correlation test
sqrt(eval.PnomPOS$statistic/sum(freq.tab)*(min(dim(freq.tab)) -1 ))
assocplot(t(freq.tab), col = c("black", "darkgrey"))

###Order Sb-Pnom vs Pnom-Sb
freq.tab<-table(Order,Predication.Type)
View(freq.tab)
#Chi-sq test
eval.Order<-chisq.test(freq.tab, correct = F)
eval.Order
#Cramer's V correlation test
sqrt(eval.Order$statistic/sum(freq.tab)*(min(dim(freq.tab)) -1 ))
assocplot(t(freq.tab), col = c("black", "darkgrey"))

###Chronology
chron.tab<- table(Century,Predication.Type)
View(chron.tab)
eval.Chron <-chisq.test(chron.tab, correct = F)
eval.Chron
sqrt(eval.Chron$statistic/sum(chron.tab))
assocplot(t(chron.tab), col = c("black", "darkgrey"))
