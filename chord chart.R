library(dplyr)
library(openxlsx)
library(data.table)
library(devtools)
library(chorddiag)
library(circlize)
library(hrbrthemes)
library(viridis)
library(tidyverse)
library(patchwork)


studentsraw <- read.xlsx("Free School Meals_borough_flows_matrix 1.xlsx", 'FSM',
                 startRow = 2) %>% data.table()
students <- studentsraw[,-c(1)]
allstudents <- data.frame(students$X2, students$All)
students[students == "-"] <- "0"
boroughs <- students$X2[c(1:33)]
students<-students[c(1:33),c(1:34)]

melted <- melt(students, value.name = 'number', id = 'X2')
melted$X2 <- sub(" ", ".", melted$X2)
melted$X2 <- sub(" ", ".", melted$X2)

melted[melted$X2 == melted$variable,]
melted[melted$X2 == melted$variable, c('number')] <- 0

students2 <- dcast(data = melted, formula = X2~variable, value.var = "number")
home <- students2$X2

students2 <- students2 %>%
  select(-X2) %>% # this removes the alpha column if all your character columns need converted to numeric
  mutate_if(is.character,as.numeric) 
# 
# students <- students %>%
#   select(-X2) %>% # this removes the alpha column if all your character columns need converted to numeric
#   mutate_if(is.character,as.numeric) 

students2

m <- unname(data.matrix(students2, rownames.force = NA))

dimnames(m) <- list(home = home, 
                    school = boroughs)
class(m)
m

# edges <- melt(students[c(1:33),c(1:34)], na.rm = FALSE, value.name = 'no_of_students', id = 'X2')
# edges <- as.data.frame(edges)
# colnames(edges) <- c('home', 'school', 'no_of_students')
# unique(edges$home)
# unique(edges$school)
# edges$home <- sub(" ", ".", edges$home)
# edges$home <- sub(" ", ".", edges$home)

# circos.clear()
# circos.par(start.degree = 90, gap.degree = 4, track.margin = c(-0.1, 0.1), points.overflow.warning = FALSE)
# par(mar = rep(0, 4))
# 
# length(unique(edges$home))

# color palette
mycolor <- viridis(33, alpha = 1, begin = 0, end = 1, option = "D")
mycolor <- mycolor[sample(1:33)]



# Base plot
chorddiag(
  m,
  groupColors = mycolor,
  groupnamePadding = 10, groupnameFontsize = 10,
  showTicks = FALSE)





