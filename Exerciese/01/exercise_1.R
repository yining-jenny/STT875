## Exercise: 1
## Date: July 8, 2019
## Author: Yining(Jenny) Chen

rm(list=ls())

# Setup -------------------------------------------------------------------
con <- url("http://blue.for.msu.edu/FOR875/data/batting.RData")
load(con)
close(con)
rm(con)


# Question 1 --------------------------------------------------------------
## Question: How many seasons did Ted Williams play? (Hint: Use the length function.)
## Code:
length(TedWilliamsBA)
## Answer: 19


# Question 2 --------------------------------------------------------------
## Question: In which season did Ted Williams have his highest batting average?
## Code:
which.max(TedWilliamsBA)
## Answer: 1953


# Question 3 --------------------------------------------------------------
## Question: What was this highest batting average?
## Code:
max(TedWilliamsBA)
## Answer:0.407


# Question 4 --------------------------------------------------------------
## Question: What was Ted Williams’ mean batting average?
## Code:
mean(TedWilliamsBA)
## Answer:0.3475789


# Question 5 --------------------------------------------------------------
## Question: For which pair of the variables representing home runs, RBIs, and batting average, is the correlation the highest? What is this correlation?
## Code:
cor(TedWilliamsBA,TedWilliamsRBI)
cor(TedWilliamsBA,TedWilliamsHR)
cor(TedWilliamsHR,TedWilliamsRBI)
## In 3x3 correlation matrix:
cor(cbind(TedWilliamsBA,TedWilliamsHR,TedWilliamsRBI))
## Answer:The correlation betweem home runs and RBIs is the highest as 0.8422571.


# Question 6 --------------------------------------------------------------
## Question:What was the largest jump in Ted Williams’ RBIs from one season to the next? In which season did this jump occur?
## Code:
TedWilliamsRBIdiffs <- diff(TedWilliamsRBI, lag=1)
TedWilliamsRBIdiffs
max(TedWilliamsRBIdiffs)
which.max(TedWilliamsRBIdiffs)
min(TedWilliamsRBIdiffs)
which.min(TedWilliamsRBIdiffs)
## Or Find absolute value of largest jump.
which.max(abs(diff(TedWilliamsRBI, lab=1)))
## Answer: Largest increase jump in Ted williams' RBIs is 55 occur in 1954; Largest decrease jump in Ted williams' RBIs is -123 occur in 1952. 






