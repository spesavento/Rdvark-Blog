
head(iris)
head(mtcars)
#install.packages(dplyr)
library(dplyr)  #remember to put libraries at the top

#mean() takes the column mean
#n() takes the number of rows 
sep <- iris %>% 
  summarise(avg_sep = mean(Sepal.Length), rows_sep = n())
sep

#n_distinct() counts the number of unique values in a variable. There are 3 species:
#setosa, versicolor, and virginica
species <- iris %>% 
  summarise(spec_count = n_distinct(Species))
species

#here I am adding an NA in Petal.Width and still calculating the mean 
iris[3,4] <- NA
test_NA <- iris %>% 
  summarise(mean_w_NA = mean(Petal.Width, na.rm = TRUE))
test_NA

#summarise_all() - Apply funs to every column
#notice not all variable types are numeric and Petal.Width had an NA.
avgs <- iris %>% 
  summarise_all(mean)
avgs

#summarise_at() - Apply funs to specific columns
avg_at <- iris %>% 
  summarise_at(c(1,2,3), mean)
avg_at

#summarise_if() - Apply funs to all cols of one type
avg_if <- iris %>% 
  summarise_if(is.numeric, mean, na.rm = TRUE)
avg_if

###### FILTER

#filter() - extract rows that meet logical criteria
iris %>%
  filter(Sepal.Length > 7.4 & Sepal.Width <= 3.0)

#distinct() - remove rows with duplicate values
#to remove duplicates across all rows, put no arguments distinct()
#to keep the first obs of each Species add .keep_all = TRUE
iris %>% 
  distinct(Species)

#sample_frac() - randomly select fraction of rows
iris %>%
  sample_frac(0.05, replace = TRUE)

#sample_n() - randomly select a number of rows
iris %>%
  sample_n(5, replace = FALSE)

#slice() - select rows by position
iris %>% 
  slice(10:12)

#select() - select columns by position
sel <- iris %>% 
  select(c(1,3))
sel[1:2,]

#pull() - get the values in a column as a vector
pull <- iris %>% 
  pull(2)
pull[1:5]

#top_n() - select and order top n entries (by group if grouped data)
#Note if there are same values it will list all of them
#use negative numbers to get bottom n
iris %>% 
  top_n(1, Sepal.Length)
iris %>% 
  top_n(-1, Sepal.Length)

#### GROUP_BY

#note: you can group by multiple variables group(var1, var2)
group <- iris %>% 
  group_by(Species) %>% 
  summarize(mean_width = mean(Petal.Width, na.rm = TRUE), 
            min_len = min(Petal.Length), count = n())
group

#mutate() - creates a new col based on other col(s) and returns all
head(mutate(mtcars, gpm = 1/mpg))[,c(1,12)]
#transmute() - creates a new col based on other col(s) and only 
#returns new col
head(transmute(mtcars, gpm = 1/mpg))
#mutate_all() - apply funs to every column
#notice new variable wasn't created, and it replaces every value, 
#unlike summarise_all(iris, mean)
head(mutate_all(iris, funs(mean(., na.rm=TRUE))))
#mutate_if() - apply funs to every column that passes a condition
head(mutate_if(iris, is.numeric, funs(log(.))))
#mutate_at() - apply funs to certain columns (returns all)
head(mutate_at(iris, vars(-Species), funs(log(.))))
#add_column() - adds column - works for tibbles only
library(tibble)
tail(add_column(iris, new = 1:nrow(iris)))
#add_row() - adds row 
#.before = TRUE or .after = TRUE
new_iris <- add_row(iris, Sepal.Length = 5, Sepal.Width = 3, 
                    Petal.Length = 1.5, Petal.Width = .2, Species = "setosa")   
tail(new_iris)

#rename() - renames columns
rename(iris, Length = Sepal.Length)[1:2,]

##### ARRANGE

head(arrange(iris, Petal.Width))
head(arrange(iris, desc(Petal.Width)))

##### Joins

x <- data.frame("First_Initial" = c("a","s","c","e"), 
                "Second Initial" = c("t","u","v","p"),       
                "ID" = 1:4)
y <- data.frame("Address" = c("Davis","LA","NYC","SF"), 
                "Code" = c("t","u","r","q"), 
                "ID" = c(1:3, 5))
x 
y

#keeps ALL rows of x and matches y with key where possible, else NA
left_join(x,y,by="ID")

#keeps ALL rows of y and matches x with key where possible, else NA
right_join(x,y,by="ID")


#retain only rows with perfect matches across 
inner_join(x,y,by="ID")

#keep all data (all rows from each table)
full_join(x,y,by="ID")


#return rows of x that have a match in y
semi_join(x, y, by="ID")

#return rows of x that DO NOT have a match in y
anti_join(x, y, by="ID")

x <- data.frame("A" = c("a","b","c","e"), 
                "B" = c("t","u","v","x"), 
                "C" = 1:4)
y <- data.frame("A" = c("a","b","c","d"), 
                "B" = c("t","u","v","x"), 
                "C" = c(4,3,3,1))
x
y

#intersect() - rows that appear in both x and y 
intersect(x, y)

#setdiff(x, y) - rows that appear in x, but not in y
setdiff(x,y)

#union(x, y) - rows that appear in x OR y (duplicates removed)
union(x,y)