#Dplyr exercises
library(dplyr)

#create datasets
mydates <- as.Date(c("2019-01-22", "2019-01-22", "2019-01-22", "2019-01-22", "2019-01-22", "2019-01-22", "2019-01-22","2019-01-22", "2019-01-22", "2019-01-22", "2019-01-22"))

session_data <- data.frame(date = mydates, sessionid = c(1010, 1010, 1010, 1010, 1055, 1055, 1079, 1079, 1079, 1099, 1099), userid = c(11, 11, 11, 11, 11, 11, 13, 13, 13, 14, 14), action = c("In", "Click", "Message", "Out", "In", "Out", "In", "Click", "Out", "In", "Out"))
session_data
mydates2 <- as.Date(c("2019-01-22", "2019-01-22", "2019-01-22", "2019-01-22"))
time_sec <- data.frame(date = mydates2, sessionid = c(1010, 1055, 1079, 1099), seconds = c(260, 15, 45, 4))
time_sec

#Question 1: Find the average number of sessions by user for the last 30 days.
avg_30_users <- session_data %>% 
  group_by(userid) %>% 
  filter(date >= date[1] - 30) %>% 
  summarise(sessionperuser = n_distinct(sessionid)) %>% 
  ungroup(userid) %>% 
  summarise(avg_per_user = sum(sessionperuser)/n())

avg_30_users


#Question 2: Find the average session length by userid 
merged <-right_join(time_sec, session_data, by = "sessionid") 

avg_session <- merged %>% 
  group_by(userid, sessionid) %>% 
  summarise(count = sum(seconds)/n()) %>% 
  ungroup(userid, sessionid) %>% 
  group_by(userid) %>% 
  summarise(avg_session = sum(count)/n())

avg_session