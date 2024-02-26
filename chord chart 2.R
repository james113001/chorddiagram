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


studentsraw <- read.xlsx("clean_studentdata.xlsx") %>% data.table()
studentsraw[studentsraw == "NA"] <- "0"
boroughs <- colnames(studentsraw)


m <- unname(data.matrix(studentsraw, rownames.force = NA))

dimnames(m) <- list(home = boroughs, 
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





