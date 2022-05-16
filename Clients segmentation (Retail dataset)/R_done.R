install.packages('viridis')
install.packages('plotly')
install.packages('viridis')
install.packages("ggstatsplot")
install.packages("vcd")
install.packages("scales")
install.packages("ggstatsplot")
install.packages("vcd")

library(ggstatsplot)
library(ggplot2)
library(vcd)
library(rstatix)
library(viridis)
library(ggplot2)
library(stringr)
library(dplyr)
library(factoextra)
library(cluster)
library(FactoMineR)
library(factoextra)
library(corrplot) 
library(plotly)
library(dplyr)
library(scales)
library(gridExtra)

df <- data.frame(MKT_data_exam)
df <- na.omit(df)
options(scipen = 999)
summary(df)
sd(df$Income)

shapiro.test(df$Income)

#########Q1
#1. Histogram - Nbr d'achats effectués avec réduction 
ggplot(df, aes(x = reorder(NumDealsPurchases,NumDealsPurchases,function(x)-length(x)), fill = NumDealsPurchases)) +  
  geom_bar(aes(y = (..count..)/sum(..count..))) +
  scale_y_continuous(labels = scales::percent_format(accuracy = 1L))+
  labs(title = "Nbr d'achats effectués avec réductions",
       x = "Nbr d'achats effectués",
       y = "Pourcentage",
       fill = "Nbr d'achats effectués")+
  scale_fill_manual(values = c("#DAF7A6", "#FFC300", 
                               "#FF5733", "#C70039",
                               "#900C3F","#581845"))
#2. Pie chart - cannaux d'achat
labels_pei <- c('Web','Catalogue','Magasin')
Web <- sum(df$NumWebPurchases)
cata<- sum(df$NumCatalogPurchases)
sto <- sum(df$NumStorePurchases)
pie_chart_dataframe <- c(Web,cata,sto)
piepercent<- round(100*pie_chart_dataframe/sum(pie_chart_dataframe), 1)
labels <- paste(piepercent,"%",sep="")
pie_chart_dataframe2 <- data.frame(cannaux=labels_pei,value=pie_chart_dataframe)
df11 <- pie_chart_dataframe2 %>% 
  group_by(cannaux) %>% # Variable to be transformed
  count() %>% 
  ungroup() %>% 
  mutate(perc = round(pie_chart_dataframe/sum(pie_chart_dataframe), 2)) %>% 
  arrange(perc) %>%
  mutate(labels = scales::percent(perc))

ggplot(df11, aes(x = "", y = perc, fill = cannaux)) +
  geom_col(color = "black") +
  geom_label(aes(label = labels), color = c(1, 1, 1),
             position = position_stack(vjust = 0.5),
             show.legend = FALSE) +
  guides(fill = guide_legend(title = "Cannaux d'achat"))+
  coord_polar(theta = "y") + 
  theme_void()+ labs(title="Cannaux d'achat") 

#3. Histogram - types de produits

par(mfrow = c(2, 2))  
new<- df[2:7]
loop.vector <- 1:6
loop.factor <- c('MntWines','MntFruits','MntMeatProducts','MntFishProducts','MntSweetProducts','MntGoldProds')

for (i in loop.vector) { 
  x <- new[,i]
  h=hist(x, xlim = c(0, 1500),plot = FALSE)
  h$density = h$counts/sum(h$counts)*100
  plot(h,freq=FALSE,main = paste("Montant dépensé", loop.factor[i]), xlab="Montant $",ylab = "Pourcentage",col='#0099ff')
  print(i)
}

par(mfrow = c(1,1))

#4. Boxplot - Income

ggplot(data = df, aes(x = Income,fill="rose")) +  geom_boxplot() + 
  labs(title = "Income") +stat_boxplot(geom = "errorbar",width = 0.25) + 
  stat_boxplot(geom = "errorbar",                                                                                               width = 0.25) + 
  geom_boxplot(alpha = 0.8,          # Fill transparency
               colour = "#474747",   # Border color
               outlier.colour = "orange", outlier.shape=1,outlier.size=4)
#########Q2
#ACP
corrplot(cor(df[2:7]), method = 'number',type="upper") 
myPCA <- prcomp(df[2:7],scale=TRUE)
summary(myPCA)
plot(df$MntWines,df$MntMeatProducts)
plot(scale(df$MntWines),scale(df$MntMeatProducts))
plot(myPCA,type='l')
fviz_pca_var(myPCA, col.var="contrib",   
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),  
             repel = TRUE)
  
df <- cbind(df,myPCA$x[,1:3])
fviz_pca_ind(myPCA, col.ind = "#00AFBB",repel = TRUE)
fviz_pca_ind(myPCA, label="none", habillage=df$Cluster_Kmeans,
             addEllipses=TRUE, ellipse.level=0.95,
             palette = c("#999999", "#E69F00", "#56B4E9"))

#Kmeans
set.seed(123)
pp<- df[12:14]
str(pp)
distance <- get_dist(pp)

k4.results <- kmeans(pp, 4, nstart = 25)  
print(k4.results)
fviz_cluster(k4.results, data = pp)
fviz_cluster(k4.results, pp)


k2.results <- kmeans(pp, 2, nstart = 25)  
k3.results <- kmeans(pp, 3, nstart = 25)  


sil <- silhouette(k3.results$cluster, dist(pp))
fviz_silhouette(sil)

p1 <- fviz_cluster(k2.results, geom = "point", data = pp,repel = TRUE, ellipse.type = "norm") + ggtitle("k = 2")
p2 <- fviz_cluster(k3.results, geom = "point",  data = pp,repel = TRUE, ellipse.type = "norm") + ggtitle("k = 3")
p3 <- fviz_cluster(k4.results, geom = "point",  data = pp,repel = TRUE, ellipse.type = "norm") + ggtitle("k = 4")

grid.arrange(p1, p2, p3, nrow = 2)
set.seed(123)
fviz_nbclust(pp, kmeans, method = "wss")
fviz_silhouette(pp)

set.seed(123)
fviz_nbclust(pp, kmeans, nstart = 25,  method = "gap_stat", nboot = 50)+
  labs(subtitle = "Gap statistic method")
plot(k3.results, type='b', avg_sil, xlab='Number of clusters', ylab='Average Silhouette Scores', frame=FALSE)
fviz_nbclust(pp, kmeans, method='silhouette')


df$Cluster_Kmeans<- factor(k3.results$cluster)
sil <- silhouette(df$Cluster_Kmeans, dist(distance))
fviz_silhouette(sil)


#plot the 3D cluster
p <- plot_ly(df, x=~PC1, y=~PC2, 
             z=~PC3, color=~Cluster_Kmeans) %>%
  add_markers(size=2.5) %>%
print(p)


summary(df$Income[df$Cluster_Kmeans==1])
summary(df$Income[df$Cluster_Kmeans==2])
summary(df$Income[df$Cluster_Kmeans==3])

count(df, Cluster_Kmeans)
mea <- df %>%
  mutate(Cluster = df$Cluster_Kmeans) %>%
  group_by(Cluster_Kmeans) %>%
  summarise_all("mean")


#######Q3
count(df, Cluster_Kmeans)

fun_mean <- function(x){
  return(data.frame(y=mean(x),label=mean(x,na.rm=T)))}

ggplot(data=df, aes(x = df$Income, y = df$Cluster_Kmeans, fill = df$Cluster_Kmeans)) +                 # Draw ggplot2 boxplot
  geom_boxplot() +
  stat_summary(fun = mean, geom = "point", col = "red") +  # Add points to plot
  stat_summary(fun = mean, geom = "text", col = "red",     # Add text to plot
               vjust = 1.5, hjust=-0.2 , aes(label = paste("Mean:", round(..x.., digits = 1))))
#remove outliers

Q1 <- quantile(df$Income, probs=c(.25, .75), na.rm = FALSE)
iqr1 <- IQR(df$Income)
eliminated_Cluster1<- subset(df, df$Income > (Q1[1] - 1.5*iqr1) & df$Income < (Q1[2]+1.5*iqr1))
summary(eliminated_Cluster1)

Q2 <- quantile(df$Income[df$Cluster_Kmeans==2], probs=c(.25, .75), na.rm = FALSE)
iqr2 <- IQR(df$Income[df$Cluster_Kmeans==2])
eliminated_Cluster2<- subset(df, df$Income[df$Cluster_Kmeans==2] > (Q2[1] - 1.5*iqr2) & df$Income[df$Cluster_Kmeans==2]< (Q2[2]+1.5*iqr2))
summary(eliminated_Cluster2)

Q3 <- quantile(df$Income[df$Cluster_Kmeans==3], probs=c(.25, .75), na.rm = FALSE)
iqr3 <- IQR(df$Income[df$Cluster_Kmeans==3])
eliminated_Cluster3<- subset(df, df$Income[df$Cluster_Kmeans==3] > (Q3[1] - 1.5*iqr3) & df$Income[df$Cluster_Kmeans==3] < (Q3[2]+1.5*iqr3))
summary(eliminated_Cluster3)



#ANOVA
plot(Income~Cluster_Kmeans, data=eliminated_Cluster1,horizontal=TRUE)
fit <- aov(Income~Cluster_Kmeans, data=eliminated_Cluster1)
summary(fit)
library(car)
par(mfrow = c(1, 2))
hist(fit$residuals)
qqPlot(fit$residuals,
       id = FALSE
)
par(mfrow = c(1, 1))
fit$coefficients
fit$fitted.values

shapiro.test(fit$residuals)
# Tukey Honestly Significant Differences
TukeyHSD(fit)  
# Plot Means with Error Bars
library(gplots)
plotmeans(Income~Cluster_Kmeans, data=df,xlab="Cluster",
          ylab="Income",main="Mean Plot")
# boxplot
boxplot(Income~Cluster_Kmeans, data=df)


########Q4
#Khi-deux 
colss <- c("#DAF7A6", "#FFC300", "#FF5733")

#Percentage
ggplot(df) +
  aes(x = Cluster_Kmeans, fill = NumDealsPurchases) +
  geom_bar(position = "dodge")
ggplot(df) +
  aes(x = Cluster_Kmeans, fill = NumDealsPurchases) +
  geom_bar(position = "fill")

M <- table(df$NumDealsPurchases,df$Cluster_Kmeans)
addmargins(M)
prop.table(M,1)
prop.table(M,2)

addmargins(prop.table(M,2))
summary(M)
test.indip <- chisq.test(M)
test.indip 
names(test.indip)

test.indip$expected   # Effectifs théoriques sous l’hypothèse d’indépendance
test.indip$residuals  # Differences entre les effectifs théoriques et les valeurs observées 
test.indip$stdres
test<- chisq.test(df$NumDealsPurchases, df$Cluster_Kmeans)
test$statistic #: la statistique du Chi2.
test$parameter #: le nombre de degrés de libertés.
test$p.value #: la p-value.
test$observed #: la matrice observée de départ.
test$expected #: la matrice attendue sous l'hypothèse nulle d'absence de biais.

ggbarstats(
  data = df,
  x = NumDealsPurchases,
  y = Cluster_Kmeans,
  caption = NULL,
  label = "both",label.text.size=2,
  label.text.size = 0.4, legend.position = "top",
  title = "Nbr d'achat effectué avec réduction par cluster") 
point <- format_format(big.mark = " ", decimal.mark = ",", scientific = FALSE)
