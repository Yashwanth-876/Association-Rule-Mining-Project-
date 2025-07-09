# Association Rule Mining on Grocery Purchase Data

This R project applies the **Apriori algorithm** to a real world grocery dataset to uncover meaningful product associations. The aim is to analyze which items are frequently purchased together and visualize common buying patterns.

---

## Dataset

- Sourced from Kaggle
- File: `Grocery Products Purchase.csv`
- Contains **9835 transactions** with up to 32 items each
- Each row represents one customer's transaction

---

## Methodology

- Converted the dataset into a `transactions` object using the `arules` package
- Applied the **Apriori algorithm** with varying support and confidence thresholds
- Generated association rules and visualized them using `arulesViz`
- Exported rules and plots to external files for analysis and sharing

---

## Output Summary

### `rules`  
- **Support**: 0.01  
- **Confidence**: 0.5  
- **Generated Rules**: **15**

> Focused on discovering strong item relationships with moderate thresholds.

---

### `rule1`  
- **Support**: 0.005  
- **Confidence**: 0.4  
- **Generated Rules**: **270**

> A more relaxed rule generation, identifying many lower-support associations that could be interesting.

---

### `rule2`  
- **Support**: 0.02  
- **Confidence**: 0.6  
- **Generated Rules**: **0**

> A stricter threshold resulted in **no valid rules**, suggesting that very strong associations with this support/confidence level don’t exist in the dataset.


## R Package Requirements

Install required packages 

```r
install.packages("arules")
install.packages("arulesViz")
source("Association Analysis.R")
