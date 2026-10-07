library(tidyverse)
library(rvest)

# overview ----

## Functions ----
html_elements() # Use to identify elements that will become observations
html_element()  # Use to find elements that will become variables

html_text2()    # Extracts the plain text contents of an HTML element
html_attr()     # Extracts data from attributes

html_table()    # Returns a list containing one tibble for each table found on
                # the page

## CSS selectors ----
html_elements("p")      # selects all <p> elements

html_elements(".title") # selects all elements with class “title”

html_elements("#title") # selects the element with the id attribute 
                        # that equals “title”. 
                        # Id attributes must be unique within a document, 
                        # so this will only ever select a single element.


# 24.4 Extracting data ----

html <- read_html("https://rvest.tidyverse.org/articles/starwars.html")
html


## 24.4.1 Find elements ----

html_min <- minimal_html("
  <h1>This is a heading</h1>
  <p id='first'>This is a paragraph</p>
  <p class='important'>This is an important paragraph</p>
")

html_min |> 
  html_elements("p")

html_min |> 
  html_elements(".important")

html_min |> 
  html_elements("#first")

html_min |> html_elements("b") # Returns 0
html_min |> html_element("b") # Returns NA


## 24.4.2 Nesting selections ----

html_star_wars <- minimal_html("
  <ul>
    <li><b>C-3PO</b> is a <i>droid</i> that weighs <span class='weight'>167 kg</span></li>
    <li><b>R4-P17</b> is a <i>droid</i></li>
    <li><b>R2-D2</b> is a <i>droid</i> that weighs <span class='weight'>96 kg</span></li>
    <li><b>Yoda</b> weighs <span class='weight'>66 kg</span></li>
  </ul>
  ")

# Get characters from list
characters <- html_star_wars |> 
  html_elements("li")
characters

# Get character names
characters |> 
  html_element("b")

# Get character weights
characters |> 
  html_element("span")


## 24.4.3 Text and attributes ----

# Get character names as text
characters |> 
  html_element("b") |> 
  html_text()

# Get character weights as text
characters |> 
  html_element(".weight") |> 
  html_text()

# Extract data from attributes
html_min2 <- minimal_html("
  <p><a href='https://en.wikipedia.org/wiki/Cat'>cats</a></p>
  <p><a href='https://en.wikipedia.org/wiki/Dog'>dogs</a></p>
")

html_min2 |> 
  html_elements("p") |> 
  html_element("a") |> 
  html_attr("href")


## 24.4.4 Tables ----

html_tbl <- minimal_html("
  <table class='mytable'>
    <tr><th>x</th>   <th>y</th></tr>
    <tr><td>1.5</td> <td>2.7</td></tr>
    <tr><td>4.9</td> <td>1.3</td></tr>
    <tr><td>7.2</td> <td>8.1</td></tr>
  </table>
  ")

html_tbl |> 
  html_element(".mytable") |> 
  html_table()

# 24.6 Putting it all together ----

html

# Goal: to turn this data into a 7 row data frame with variables
# title, year, director, and intro

section <- html |> 
  html_elements("section")
  
title <- sections |> 
  html_element("h2") |> 
  html_text2()

year <- sections |> 
  html_element("p") |> 
  html_text2() |> 
  str_remove("Released: ")

director <- section |> 
  html_element(".director") |> 
  html_text2()

intro <- section |> 
  html_elements(".crawl") |> 
  html_text2()

star_wars_movies <- tibble(title, year, director, intro)
star_wars_movies
