
# Reverse the order of characters a string.
# "Hey" --> "yeH" and "Reverse me" --> "em esreveR"

reverse_me <- function(string) { 
  chars <- strsplit(string, "") 
  reved_str <- c() 
  
  for (i in 1:nchar(string)) { 
    reved_str[nchar(string) - i + 1] <- chars[[1]][i] 
    
  } 
  print(paste(reved_str, collapse = "")) 
  return(0) 
  
} 
s <- "Hey" 
reverse_me(s)

# 2. Reverse the order of words a string.
# "This is a test." --> "test. a is This"

rev_words <- function(string) { 
  split_s <- strsplit(string, " ")  
  reved_s <- c() 
  
  for(i in 1:(str_count(string, " ") + 1)) { 
    reved_s[(str_count(string, " ") + 1) - i + 1] <- split_s[[1]][i] 
  } 
  print(paste(reved_s, collapse = " ")) 
  return(0) 
} 

s <- "This is a test." 
rev_words(s)


# Return indexes of numbers adding to 9. 
#Given nums = [2, 7, 11, 15]. nums[1] + nums[2] = 2 + 7 = 9, so return [1, 2].

index_nine <- function(vec) { 
  
  for (i in 1:(length(v)-1)) { 
    first_in = vec[i] 
    sec_in = vec[i+1] 
    if (first_in + sec_in == 9) { 
      print(paste0("[",i, ",", i+1, "]")) 
    } 
  } 
  return(0) 
} 

v <- c(2,7,11,15,3,6) 
index_nine(v)

# Given a string, find the length of the longest substring without repeating characters.

long_substr <- function(string) {
  
  split_s <- strsplit(string, "")  ##list
  long <- c()
  max <- 0 
  
  for(i in 1:nchar(string)) {
    curr_char <- split_s[[1]][i]
    
    #make sure that current letter isn???t in long yet
    if(!(curr_char %in% long)) {
      long[i] <- curr_char
    } else {
      if (length(which(!is.na(long))) > max) {
        max = length(which(!is.na(long)))
        
        comp_str = long
      }
      #start vector over
      long[i] <- curr_char
      long[1:(i-1)] <- NA
    }
  }
  
  if (length(which(is.na(comp_str))) >=1 ) {
    comp_str <- comp_str[-c(1:length(which(is.na(comp_str))))]
  }
  print(paste(comp_str, collapse = ""))
  return(0)
  
}

s <- "abcabcbb"
long_substr(s)

