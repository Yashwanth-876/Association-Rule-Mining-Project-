# R Script: Association Rule Mining on Grocery Purchase Data

# Date: July 08, 2025

# Author: Mamidala Yashwanth

# Purpose: Apply the Apriori algorithm to discover meaningful product associations and
#visualize common buying patterns in grocery transactions. The data, 
#sourced from Kaggle (9835 , 32), captures real world customer purchases and helps to 
#uncover which items are frequently bought together.

# STEP 1 : Setup and Package Installation

# Set working directory

getwd()
setwd("C:/Users/Mamidala Yashwanth/Documents/R/R Projects")
list.files()

# Install required packages 
install.packages("arules")
install.packages("arulesViz") 

# Load packages
library(arules)
library(arulesViz)

# STEP 2 : Data Loading 


# Load the CSV file with proper handling of empty strings and quotes
data = read.csv("Grocery Products Purchase.csv", 
                 stringsAsFactors = FALSE, 
                 na.strings = "", 
                 quote = "\"")

# Displaying first 10 rows 
head(data, 10)

# Checking dimensions (rows, columns)
dim(data)

# Checking structure of the data frame
str(data)

# Extracting unique items from the dataset
unique(unlist(data))

# STEP 3: Data Preprocessing


# Converting data to a list of transactions and excluding empty strings and NAs
transactions = apply(data, 1, function(row) {
  items = row[row != "" & !is.na(row)]
  return(items)
})

# Converting in to transactions object 
trans = as(transactions, "transactions")

summary(trans)

# STEP 4: Association Rule Mining

# Generating frequent itemsets with minimum support
frequent_itemsets = apriori(trans, 
                            parameter = list(support = 0.01, 
                                            target = "frequent itemsets"))

# Generating association rules with specified parameters
rules = apriori(trans, 
                 parameter = list(support = 0.01, 
                                 confidence = 0.5, 
                                 minlen = 2))

summary(rules)

# Display all rules sorted by lift

inspect(sort(rules, by = "lift"))


# STEP 5: Output  AND Exporting in CSV file USING write.table 

write(rules, file = "association_rules.csv", 
      sep = ",", 
      quote = TRUE, 
      row.names = FALSE)


# STEP 6: Visualization


# Scatter plot of rules
plot(rules, 
     method = "scatterplot", 
     measure = c("support", "confidence"), 
     shading = "lift")


# Interactive graph plot for rules 

plot(
  head(sort(rules, by = "lift")), 
  method = "graph", 
  engine = "htmlwidget", 
  shading = "lift",
  main = "Shopping Friends Adventure!",
  control = list(
    type = "items",
    col = "yellow",           
    edge.col = "red",         
    node.size = 15,           
    label.cex = 1.5,          
    layout = igraph::layout_in_circle  
  )
)

# Grouped matrix plot of rules
plot(rules, 
     method = "grouped")


#STEP 7: Generating more rules by lowering thresholds

rule1 = apriori(trans, parameter = list(support = 0.005, confidence = 0.4, minlen = 2)) ;rule1

rule2 <- apriori(trans, parameter = list(support = 0.02, confidence = 0.6, minlen = 2)) ;rule2


write(rule1, file = "rule1_association_rules.csv", sep = ",", quote = TRUE, row.names = FALSE)


write(rule2, file = "rule2_association_rules.csv", sep = ",", quote = TRUE, row.names = FALSE)
