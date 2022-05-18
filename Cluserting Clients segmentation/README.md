# Unsupervised clustering of clients with Retail data with R. 
Income: annual household income of the client<br>
Amount for each product category over the last 2 years<br>
Number of purchases made for each channel and with discount<br>

1. Descriptive statistics analysis :
<br> - boxplot of annual household income of the client
<br> - histograms of amount for each product category 
<br>- Pie chart for nbr of channel of purchase
<br>- Nbr of purchase with discount coupons

![Alt text](https://raw.githubusercontent.com/Pai-U/Projet_PAI/main/Project%20-%20Clients%20segmentation%20(Retail%20dataset)/Graphics/boxplot_income_.jpg "boxplot of annual household income of the client")


2. PCA analyse : Its purpose is to transform correlated variables into correlated variables into new variables that are decorrelated from each other. We wish to reduce the dimensions of the variables while keeping as much information as possible. 
<br>
3. K-means clustering <br>
Cluster 3D <br>

![Alt text](https://raw.githubusercontent.com/Pai-U/Projet_PAI/main/Project%20-%20Clients%20segmentation%20(Retail%20dataset)/Graphics/3D_cluster_viz.jpg "Clusers 3D")

<br>Cluster income boxplot 

![Alt text](https://raw.githubusercontent.com/Pai-U/Projet_PAI/main/Project%20-%20Clients%20segmentation%20(Retail%20dataset)/Graphics/cluster_by_income.jpg "Cluster income boxplot")

4. Test Anova: To compare a qualitative and quantitative variable, the ANOVA allows us to check whether the distribution of the
quantitative variables, the ANOVA allows us to verify if the distribution of the targeted variables follows the
normal distribution. <br>
5. Test Khi-deux:<br> The objective is to test the initial hypothesis by looking at whether the observed frequencies
observed in two categorical variables correspond to the expected frequencies (testing the correlation between
correlation between two categorical variables). This makes it possible to visualize the distribution of
frequency of discounted purchases by cluster, specifying the percentages in order to have a global view.
to have a global view. 


