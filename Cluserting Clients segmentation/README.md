# Unsupervised clustering of clients with Retail data with R. 
---
layout: post
title:  "Unsupervised clustering analysis with R"
categories: R Statistics Retail_Data 
---
This analytical report aims to segment clients' data by their annual income. Once clusterd, we can compare the relation between each cluster and each variable in order to conduct a precise customer analysis. <br>

Variables of dataset: <br>
*  Income: annual household income of the client<br>
*  Amount for each product category over the last 2 years<br>
*  Number of purchases made for each channel and with discount<br>


Statistical methods applied in this report: <br>
* Principal component analysis <br>
* K-means <br>
* Test anova<br>
* Test K²<br>

1. Data exploration - Descriptive statistics analysis :<br>
<br>
2 Extracts of graphics: <br>
- Boxplot of annual household income of the client<br>
<img alt="boxplot of annual household income of the client" src="https://raw.githubusercontent.com/Pai-U/pai-u.github.io/main/assets/boxplot_income_.jpg" width="500"/><br>

- histograms of amount for each product category<br>
<img src="https://raw.githubusercontent.com/Pai-U/pai-u.github.io/main/assets/His.jpg" width="500"/><br>

2. Matrix of correlation :<br>
<img src="https://raw.githubusercontent.com/Pai-U/pai-u.github.io/main/assets/corelationmatrix.jpg" width="450"/><br>
3. Principal component analysis :<br>
Variables of PCA<br>
<img src="https://raw.githubusercontent.com/Pai-U/pai-u.github.io/main/assets/variable_pca.jpg" width="450"/><br>
PCA Biplot<br>
<img src="https://raw.githubusercontent.com/Pai-U/pai-u.github.io/main/assets/PCA_biplot.jpg" width="500"/><br>

For CP1 which explains 56.4% of this dataset, the variable MntSweetproducts and the variable MntFruits have a strong correlation. The variable Mntwine and the variable MntSweetproducts have a weak correlation. 
For CP2 which explains 12.4% of this dataset, the variable MntWine and the variable MntFruits have a low correlation. The correlation between ManGold MntGoldproduct and the other variables is less representative in these 2 CPs. 

We have now reduced the dimensions in a simple way on 3 components (thus 3 new variables) that explain 80% of this dataset. 

4. K-means Clustering <br>
<img src="https://raw.githubusercontent.com/Pai-U/pai-u.github.io/main/assets/kmeans1.jpg" width="500"/><br>
This visualize the dispersion of data points from 2 clusters to 4 clusters. It seems 3 clusters would be significant. 
<img src="https://raw.githubusercontent.com/Pai-U/pai-u.github.io/main/assets/gap.jpg" width="500"/><br>
The optimal number of clusters by gap statistic method shows the 3 clusters would be significant. <br>
A 3D visulization of 3 clusters:<br>
<img src="https://raw.githubusercontent.com/Pai-U/pai-u.github.io/main/assets/3D_cluster_viz.jpg" width="500"/><br>

Cluster 1 : 1290 observations <br>
Cluster 2 : 547 observations <br>
Cluster 3 : 379 observations <br>

5. ANOVA for quantitatif and qualitatif <br>
Q: Does annual income has a significant impact to the result of Clusering ? <br>
Here is the Income boxplot by clusters<br>
<img src="https://raw.githubusercontent.com/Pai-U/pai-u.github.io/main/assets/cluster_by_income.jpg" width="500"/><br>
According to the above graph, we can say that there is a possible link between the annual revenue and the clusters. To justify this, we decided to remove the extreme values and then perform an ANOVA test.<br>
<img src="https://raw.githubusercontent.com/Pai-U/pai-u.github.io/main/assets/anova1.jpg" width="500"/><br>
A: YES. <br>Since the p-value of the anova test is below the significance level of 0.05, we do not reject the null hypothesis H0 and can conclude that the annual revenue has an influence on the clusters.<br>
The graphs above indicate that the residuals follow the normal distribution. <br>
Furthermore, the points on the QQ graphs follow approximately the straight line and most of them fall within the confidence bands, which also indicates that the residuals follow approximately a normal distribution. Therefore, we can conclude that the annual revenue has an impact on the clusters.<br>

5. K² for qualitatif and qualitatif <br>
Q: Does the number of purchases made with discount has a significant impact to the result of Clusering ? <br>
In order to confirm the correlation between the identified groups and the number of discounted purchases, we applied the chi-square. <br>
we applied the chi-square method. We visualized the frequency distribution of discounted purchases by cluster and calculated the Cramer's V and calculated the Cramer's V and Bayes Factor values to determine the strength of this correlation.<br>
<img src="https://raw.githubusercontent.com/Pai-U/pai-u.github.io/main/assets/k2.jpg" width="800" /><br>

A: YES. But not that much.<br>
P-value: 0.0000000000000000000000000000000000000265838 < 0.05 <br>
The null hypothesis (H0) is not rejected. The variables of number of discounted purchases and clusters are dependent on each other.Cramer's V at 0.19 explains that the relationship between these 2 variables exists but is weak.
Bayes factor at -60.21 indicates extreme evidence for the H0 hypothesis. <br>
This weak correlation can be explained by the numbers of purchases made with a 0 and 1 discount. They show a tendency to increase from cluster 1 to cluster 3. While the numbers of 2 to 5 or more times do not follow this trend. <br>


<strong>Conclusion<strong> 
<br>
We can identify 3 main clusters in this dataset. We have highlighted the the relationship between annual household income and cluster membership. The annual income tends to increase from cluster 1 to cluster 3. <br>
There is also a relationship between cluster membership and the number of purchases made  with a discount. So there is a relationship between annual income and the number of purchases made with a discounted purchases. The lower the average income, the more likely customers are to make discount purchases<br>




