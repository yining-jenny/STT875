## Exercise: 6
## Author: Yining(Jenny) Chen
## Date: 7/23/2019

   
# Setup --------------------------------------------------------------------------------------------
knitr::opts_chunk$set(comment = NA)
gapminder <- read.delim("http://blue.for.msu.edu/FOR875/data/gapminder.tsv", header = TRUE)
str(gapminder)
library(ggplot2)
ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp)) + geom_point()

# TODO 6.1: plot 1 ----------------------------------------------------------------------------------
## Question: Using p as a starting point, produce a scatter plot similar to the ones we have created, 
##           but with the countries from each of the five continents colored differently 
## Code: 
ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp)) +
  scale_x_log10() + 
  labs(title = "TODO 6.1: plot 1", x = "per capita GDP (log10 scaled)", y = "life expectancy") + 
  geom_point(aes(color=continent))


# TODO 6.2: plot 2 ----------------------------------------------------------------------------------
## Question: Add a least squares line to the scatter plot.
## Code:
ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp)) +
  scale_x_log10() + 
  labs(title = "TODO 6.2: plot 2", x = "per capita GDP (log10 scaled)", y = "life expectancy") + 
  geom_point(aes(color=continent)) + 
  stat_smooth(method = lm, se=FALSE)


# TODO 6.3: plot 3 ----------------------------------------------------------------------------------
## Question: The least squares line is not very visible. Make it wider. Also change its color to green.
## Code:   
ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp)) +
  scale_x_log10() + 
  labs(title = "TODO 6.3: plot 3", x = "per capita GDP (log10 scaled)", y = "life expectancy") + 
  geom_point(aes(color=continent)) + 
  stat_smooth(method = lm, se=FALSE, size = 2, color = "green")


# TODO 6.4: plot 4 ----------------------------------------------------------------------------------
## Question: Instead of one least squares line summarizing all the countries, 
##           include separate least squares lines for each continent.
## Code:
ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp, color = continent)) +
  scale_x_log10() + 
  labs(title = "TODO 6.4: plot 4", x = "per capita GDP (log10 scaled)", y = "life expectancy") + 
  geom_point() + 
  stat_smooth(method = lm, se=FALSE, size = 1.5)


# TODO 6.5: plot 5 ----------------------------------------------------------------------------------
## Question: Rather than least squares LINES, include a separate smoother for each continent. 
##           (Hint: You’ve been using `method = lm`. Change this to `method = loess`.) 
## Code:
ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp, color = continent)) +
  scale_x_log10() + 
  labs(title = "TODO 6.5: plot 5", x = "per capita GDP (log10 scaled)", y = "life expectancy") + 
  geom_point() + 
  stat_smooth(method = loess, se=FALSE, size = 1.5)


# TODO 6.6: plot 6 ----------------------------------------------------------------------------------
## Question: So far the focus has been on life expectancy versus per capita GDP. Next we investigate 
##           how life expectancy changes over time, and limit our attention to one or a few countries. 
##           First, here is the graphic for Rwanda (do you recall what happened in Rwanda in the early to mid 1990s).
## Code:
ggplot(data = subset(gapminder, country %in% "Rwanda"), aes(x = year, y = lifeExp)) +
  labs(title = "TODO 6.6: plot 6") + 
  geom_line() 
## Or: 
library(dplyr)
library(magrittr)
gapminder %>%
  filter(country == "Rwanda") %>%
  ggplot(aes(x=year, y=lifeExp)) + 
  labs(title="TODO 6.6: plot 6") + 
  geom_line()


# TODO 6.7: plot 7 ----------------------------------------------------------------------------------
## Question: Probably adding the actual points being connected by the line segments would add clarity.
## Code: 
ggplot(data = subset(gapminder, country %in% "Rwanda"), aes(x = year, y = lifeExp)) +
  labs(title = "TODO 6.7: plot 7") + 
  geom_line() + 
  geom_point()
## Or:
gapminder %>%
  filter(country == "Rwanda") %>%
  ggplot(aes(x=year, y=lifeExp)) + 
  labs(title="TODO 6.7: plot 7") + 
  geom_line() +
  geom_point()


# TODO 6.8: plot 8 ----------------------------------------------------------------------------------
## Question: Choose five countries that you find interesting. Create a graphic including the five countries of interest. 
## Code: 
five_countries <- c("China", "United States", "Finland", "Germany", "Norway")
ggplot(data = subset(gapminder, country %in% five_countries), aes(x = year, y = lifeExp, color = country)) +
  labs(title = "TODO 6.8: plot 8") + 
  geom_line() +
  geom_point()



###Questions?

##*None*

###Give us your feedback!

##1.*I like how the materials connecut to the previous exercise and each question can be resulved in multiple ways.*
##2.*None. Good enought!*







