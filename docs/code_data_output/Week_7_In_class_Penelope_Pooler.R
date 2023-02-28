# Penelope Pooler
# Week 7 In-class Exercise

# import clean labor 
labor_new <- read_csv("labor_tidy.csv") |>
  mutate(date = ym(paste(Year,month)),                 # create a date variable
         lfM = (lf/1000) |> round(2),                  # format labor force data  
         empM = (emp/1000) |> round(2))|>              # format employed data
  select(date, lfM, empM)                              # select variables needed
