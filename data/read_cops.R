# <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>  
# AUTHOR:       Philippe Massicotte
#
# DESCRIPTION:  Read COPS files.
# <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

library(tidyverse)

rm(list = ls())

read_cops <- function(file) {
  
  irradiance_pattern <- "edz\\d{3}|luz\\d{3}|euz\\d{3}|ed0\\d{3}"
  depth.pattern <- "EuZDepth\\LuZDepth"
  
  df <- data.table::fread(file) %>%
    setNames(gsub("[^[:alnum:] ]", "", names(.))) %>%
    setNames(gsub("\\s\\w","", names(.))) %>% 
    setNames(gsub("\\s$","", names(.))) %>% 
    setNames(gsub("cmm","", names(.))) %>%
    setNames(gsub("srmm","", names(.))) %>%
    setNames(gsub("Milliseconds","Millisecond", names(.))) %>% 
    #setNames(iconv(names(.), to = "ASCII//TRANSLIT")) %>%
    #setNames(iconv(names(.), "UTF-8", "UTF-8", sub = "")) %>%
    setNames(make.names(names(.), unique = TRUE)) %>% 
    #select(
    #  #date = matches("datetime$"),
    #  DateTime = matches("datetime$", ignore.case = TRUE),
    #   contains("Depth"),
    #  matches(depth.pattern, ignore.case = TRUE),
    #  matches("roll|pitch", ignore.case = TRUE),
    #  matches(irradiance_pattern, ignore.case = TRUE),
    #  millisec = matches("Millisecond", ignore.case = TRUE),
    #  everything()
    #) %>%
    #janitor::clean_names() %>%
    as_tibble()
  
  return(df)
  
}