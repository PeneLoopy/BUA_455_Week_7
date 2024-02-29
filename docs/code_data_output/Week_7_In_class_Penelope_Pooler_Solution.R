# Penelope Pooler
# Week 7 In-class Exercise

# To import files from your code_data_output folder:
# Save RScript into that folder AND click 
#  Session > Set Working Directory > To Source File Location

# Setup Code
# suppress scientific notation
options(scipen=100,
        getSymbols.warning4.0 = FALSE)

# install helper package (pacman), if needed
if (!require("pacman")) install.packages("pacman", repos = "http://lib.stat.cmu.edu/R/CRAN/")

# install and load required packages
# pacman should be first package in parentheses and then list others
pacman::p_load(pacman, tidyverse, gridExtra, magrittr, lubridate, 
               knitr, kableExtra, tidyquant, highcharter, dygraphs, 
               htmlwidgets)

# verify packages (comment out in finished documents)
p_loaded()


# date_som = ym(paste(Year, month)),         # create som date var
# date = ceiling_date(date_som, "month")-1   # create eom date var

# import clean labor 
labor_new <- read_csv("labor_tidy.csv", show_col_types = F) |>
  mutate(date = ym(paste(Year,month)),                 # create a date variable
         lfM = (lf/1000) |> round(2),                  # format labor force data  
         empM = (emp/1000) |> round(2))|>              # format employed data
  select(date, lfM, empM)                              # select variables needed


labor_xts <- xts(x=labor_new[,2:3], order.by=labor_new$date)
head(labor_xts)

(labor_hc <- hchart(labor_xts$lfM, name="Tot. Labor Force (mill.)", color="red") |>   
  hc_add_series(labor_xts$empM, name="Employed (mill.)", color="blue"))

(labor_dy <- dygraph(labor_xts, main="Total Labor and Employed") |>
  dySeries("lfM", label="Total Labor", color= "red") |>
  dySeries("empM", label="Employed", color= "blue") |>
  dyRangeSelector() |>
  dyAxis("y", label = "Number of People (Millions)", drawGrid = FALSE) |>
  dyAxis("x", label = "Date", drawGrid = FALSE) |>
  dyEvent("2020-3-12", 
          label = "Pandemic Lockdown Began", 
          labelLoc = "bottom",
          strokePattern = "dashed"))





