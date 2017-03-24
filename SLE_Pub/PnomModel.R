#We clear the memory
rm(list=ls(all=TRUE))

#Then we load some libraries
library(MASS)
library(aod); library(car); library(effects);
library(gvlma); library(multcomp); library(rgl); library(rms)

#As recommended by Gries, we define the logit, ilogit and error.bar functions:
logit <- function(x) { # logit: maps the range (0,1) to the range (-∞,∞)
  log(x/(1-x)) # Gelman & Hill (2007:80)
}
ilogit <- function(x) { # inverse logit: maps the range (-∞,∞) to the range (0,1)
  1/(1+exp(-x)) # Gelman & Hill (2007:80)
}
error.bar <- function (x.coordinate, middle, interval, ...) {
  if (is.vector(interval)) { # if only one vector is provided (because the interval is symmetric)
    arrows(x.coordinate, middle - interval, x.coordinate, middle + interval, angle=90, code=3, ...)
  } else {                   # if a data frame or matrix is provided (because the interval is not symmetric)
    arrows(x.coordinate, interval[,1], x.coordinate, interval[,2], angle=90, code=3, ...)
  }
}
options(contrasts=c("contr.treatment", "contr.poly"))

#Data:
PnomTab<-read.table("~/Documents/lavoro/github/research-projects/SLE_Pub/VALID_History_Nominal_Obs.tsv", header = TRUE, sep = '\t', comment.char = "")
attach(PnomTab)
summary(PnomTab)

#What happens if I use relevel to remap Predication.Type so that I get the probability for Nominal instead of Copula?
PnomTab$Predication.Type <- relevel(PnomTab$Predication.Type, ref = "εἰμί")

#Let us explore the data briefly
mosaicplot(table(Order, Predication.Type), color = TRUE)
mosaicplot(table(ClauseType, Predication.Type), color = TRUE)
spineplot(table(Sb.pos, Predication.Type), color = TRUE)
mosaicplot(table(Century, Predication.Type), color = TRUE)
#place the boxplot for the subtree length here!

#Now the model!
#We begin with a maximum model that takes everything into account
model.max<-glm(
  Predication.Type~ (ClauseType + Sb.pos + Order + Century)^3,
  data = PnomTab, family = binomial)
summary(model.max)

#It really seems like shit!
#Let's play around and see what stepwise logistic does
#We start with the full model going backward
model.back <- step(model.max)

model.01 <- glm(relevel(Predication.Type,"#Reconstructed")~Order*Sb.pos, data = PnomTab, family=binomial)
summary(model.01)
confint(model.01)

#Predict
# compute the individual predictions of the model 
#and determine the classification accuracy
predictions.num <- fitted(model.max) # predict(model.01, type="response") # ilogit(predict(model.01))
predictions.cat <- ifelse(predictions.num>=0.5, "εἰμί", "#Reconstructed")
table(Predication.Type, predictions.cat)
(55+283)/length(predictions.cat)

#Graphics
plot(allEffects(model.max), ask=FALSE, ci.style = "lines", grid=TRUE, rescale.axis=FALSE, ylim=c(0, 1), xlab="Subordinate conjunction", ylab="Predicted probability of 'Copula'")
# also try: plot(allEffects(model.01), ask=FALSE, grid=TRUE)
# also try: plot(allEffects(model.01), ask=FALSE, grid=TRUE, multiline=TRUE, rescale.axis=FALSE, ylim=c(0, 1))

# excursus: using lrm for additional useful summary statistics
dd <- datadist(PnomTab); options(datadist="dd")
model.lrm <- lrm(formula(model.max), data=PnomTab,
                 x=TRUE, y=TRUE, linear.predictors=TRUE, se.fit=TRUE); model.lrm

#A model using lrm:
model.01 <- lrm(Predication.Type~Order,data=PnomTab)
model.01
model.02 <- lrm(Predication.Type~ (ClauseType + Sb.pos + Order + Century)^2,
                data=PnomTab)
model.max <- lrm(Predication.Type~ (ClauseType + Sb.pos + Order + Century)^3,
                 data=PnomTab)
model.max
