library(stringr)

# 1. Strings with stringr ----

x <- c("apple", "banana", "pair")

str_detect(x, "e")

str_extract(x, "a")

str_extract_all(x, "a")

str_replace_all(x, c("a" = "A", "b" = "B", "p" = "P"))

x

str_locate_all(x, 'a')

str_view(x, "a")

# Exercise 1:
# Can you find all words in that contain the sequence “ing” in the list below,
# and change them to be “er” instead?

words <- c("running", "jumps", "swimming", "biking", "skates", "hiking", "fishing", "reading")

words_ing <- words[str_detect(words, "ing")]
words_ing

words_er <- str_replace_all(words, c("ing" = "er"))
words_er

#Exercise 2: Can you find how many words in the inbuilt `stringr::words` 
# vector contain the sequence "ise"?

# You can access the words vector with: stringr::words

str_detect(stringr::words, "ise") |> sum() # TRUE=1, FALSE=0 -> Use Sum()

# 2. Regular expressions ----

example.obj <- "1. A small sentence. - 2. Another tiny sentence."

phone_vec <- 
  "555-1239Moe Szyslak(636) 555-0113Burns, C. Montgomery
555-6542Rev. Timothy Lovejoy555 8904Ned Flanders636-555-3226
Simpson,Homer5553642Dr. Julius Hibbert"

# Excercise: Can you describe in words a pattern to use which could extract only 
# names and only phone numbers from the string above?
names_vec <- str_extract_all(phone_vec, "[[:alpha:]., ]{2,}")
names_vec

str_extract_all(phone_vec, "[[:digit:]-()]+")

# Exercise 1: Can you find all the words in stringr::words that end in “ing” 
# or “ise”?
str_view(stringr::words, "ing$|ise$")

# Exercise 2: Can you find every character followed by a dot in example.obj?
str_extract_all(example.obj, ".\\.")

# Exercise 3: Can you make a regex that matches only numbers followed by a dot
# in example.obj? How about letters followed by a dot?
str_extract_all(example.obj, "[:digit:]\\.")
str_extract_all(example.obj, "[:alpha:]\\.")

# Exercise 4: Can you find all words in stringr::words that end with “ed” but 
# not with “eed”?
str_view(stringr::words, "[^e]ed$")

# Exercise 5:How many words are there in stringr::words that end with a “y” and 
# are exactly 3 characters long?
str_view(stringr::words, "^[:alpha:]{2}y$")

# Exercise 6: In example.obj can you find all the words that are less than 6 
# characters long?
str_view(example.obj, "\\b[:alpha:]{1,5}\\b")


