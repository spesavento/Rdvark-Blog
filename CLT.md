# Central Limit Theorem (CLT)
<p>
A sample of n random variables ($X_{1},X_{2}.... X_{n}$) is taken from the population. If the population distribution is not normally distributed, then the sample size should be greater or equal to 30 (n>=30). Consider each r.v. to be independent and identically distributed. The sample average and sum are as follows.
<p>
$\bar{X}$ = $\sum_{i=1}^n \frac{X_{i}}{n}$
<p>
T = $\sum_{i=1}^n X_{i}$
<br><br>
The **Central Limit Theorem** states that the sampling distribution of the average (or sum) of a large number of samples will follow a normal distribution regardless of the original population distribution.
<br>
Say the population distribution has mean $\mu$ and standard deviation $\sigma$. Then, <p>
$\bar{X}$ ~ N($\mu, \frac{\sigma}{\sqrt{n}}$) <p>
T ~ N($n\mu, \sqrt{n}{\sigma}$)
<p>
<br>
This concept is best visualized. Let's begin with a population that has a normal distribution. 

#<span style="color:orange">Population: Normal</span>

```r
pop_norm <- rnorm(10000, mean=10, sd=1) 
hist(pop_norm, main = "Normal Distribution with mu=10", border="darkorange2")
```

![](CLT_files/figure-html/unnamed-chunk-1-1.png)<!-- -->
<p>
The population mean is $\mu$ = 10, and standard deviation $\sigma$ = 1. According to the CLT, if we take sample sizes of 100, then the sampling distribution for averages should become $\bar{X}$ ~ N($\mu,\frac{\sigma}{\sqrt{n}}$) = N(10,0.1). The sampling distribution for the sum should become T ~ N($n\mu, \sqrt{n}{\sigma}$) ~ N(1000, 10) <p>


```r
n_sam_vec <- c()               #create empty vector for the sampling distribution 
for (i in 1:10000){               #10000 simulations
n_mean<-mean(rnorm(100,10,1))     #take the AVERAGE of sample of 100 r.v.
n_sam_vec<-c(n_sam_vec,n_mean)}   #add this to the sampling distribution vector
hist(n_sam_vec,freq=F,            #graph the sampling distribution
     col="orange",
     main="Histogram of Sample Means")         
```

![](CLT_files/figure-html/unnamed-chunk-2-1.png)<!-- -->

```r
mean(n_sam_vec)                 #mean should be approx. 10 by CLT
```

```
## [1] 10.00108
```

```r
sd(n_sam_vec)                   #SD should be approx. 0.1 by CLT
```

```
## [1] 0.1004594
```

```r
n_sum_vec <- c()                 
for (i in 1:10000){           
n_sum<-sum(rnorm(100,10,1))      #take the TOTAL of sample of 100 r.v.
n_sum_vec<-c(n_sum_vec,n_sum)}       
hist(n_sum_vec,freq=F,
     main="Histogram of Sample Totals")
line_fit<-seq(950,1050,by=0.001) 
lines(line_fit,dnorm(line_fit,1000,10),col="orange")
```

![](CLT_files/figure-html/unnamed-chunk-3-1.png)<!-- -->

```r
mean(n_sum_vec)                 #mean should be approx. 1000 by CLT
```

```
## [1] 1000.272
```

```r
sd(n_sum_vec)                   #SD should be approx. 10 by CLT
```

```
## [1] 9.888469
```

#<span style="color:blue">Population: Exponential</span>

```r
exp_seq <-seq(0,5,0.001)  #sequence from 0 to 5 by .001 
plot(exp_seq, dgamma(exp_seq,1,2), col="steelblue2", main="Exponential Distribution with λ = 2") 
```

![](CLT_files/figure-html/unnamed-chunk-4-1.png)<!-- -->
<p>
The population mean is 1/$\lambda$ = 0.5, and standard deviation 1/$\lambda^2$ = 0.25. According to the CLT, if we take sample sizes of 100, then the sampling distribution for averages should become $\bar{X}$ ~ N($\mu,\frac{\sigma}{\sqrt{n}}$) = N(0.5,.05). The sampling distribution for the sum should become T ~ N($n\mu, \sqrt{n}{\sigma}$) ~ N(50, 5) <p>


```r
e_sam_vec <- c()               #create empty vector for the sampling distribution 
for (i in 1:10000){               #10000 simulations
s_mean<-mean(rgamma(100,1,2))     #take the AVERAGE of sample of 100 r.v.
e_sam_vec<-c(e_sam_vec,s_mean)}   #add this to the sampling distribution vector
hist(e_sam_vec,freq=F,            #graph the sampling distribution
     col="steelblue2",
     main="Histogram of Sample Means")         
```

![](CLT_files/figure-html/unnamed-chunk-5-1.png)<!-- -->

```r
mean(e_sam_vec)                 #mean should be approx. .5 by CLT
```

```
## [1] 0.5000182
```

```r
sd(e_sam_vec)                   #SD should be approx. .05 by CLT
```

```
## [1] 0.050481
```

```r
e_sum_vec <- c()                 
for (i in 1:10000){           
e_sum<-sum(rgamma(100,1,2))      #take the TOTAL of sample of 100 r.v.
e_sum_vec<-c(e_sum_vec,e_sum)}       
hist(e_sum_vec,freq=F,
     main="Histogram of Sample Totals")
line_fit<-seq(30,75,by=0.001) 
lines(line_fit,dnorm(line_fit,50,5),col="blue")
```

![](CLT_files/figure-html/unnamed-chunk-6-1.png)<!-- -->

```r
mean(e_sum_vec)                 #mean should be approx. 50 by CLT
```

```
## [1] 50.01402
```

```r
sd(e_sum_vec)                   #SD should be approx. 5 by CLT
```

```
## [1] 5.036916
```
#<span style="color:green">Population: Uniform</span>

```r
pop_unif <- runif(10000, min=0, max=6) 
hist(pop_unif, main = "Uniform Distribution with a=0, b=6", border="darkgreen")
```

![](CLT_files/figure-html/unnamed-chunk-7-1.png)<!-- -->
<p>
The population mean is $\frac{a + b}{2}$ = 3 and standard deviation $\sqrt(\frac{(b-a)^2}{12})$ = 1.732. According to the CLT, if we take sample sizes of 100, then the sampling distribution for averages should become $\bar{X}$ ~ N($\mu,\frac{\sigma}{\sqrt{n}}$) = N(3,0.1732). The sampling distribution for the sum should become T ~ N($n\mu, \sqrt{n}{\sigma}$) ~ N(300, 17.32) <p>

```r
u_sam_vec <- c()                #create empty vector for the sampling distribution
for (i in 1:10000){                 #10000 simulations
  u_mean<-mean(runif(100,0,6))      #take the AVERAGE of sample of 100 r.v.
  u_sam_vec<-c(u_sam_vec,u_mean)}   #add this to the sampling distribution vector
hist(u_sam_vec,freq=F,              #graph the sampling distribution
     col="green",
     main="Histogram of Sample Means")         
```

![](CLT_files/figure-html/unnamed-chunk-8-1.png)<!-- -->

```r
mean(u_sam_vec)                 #mean should be approx. 3 by CLT
```

```
## [1] 2.998223
```

```r
sd(u_sam_vec)                   #mean should be approx. 0.1732 by CLT
```

```
## [1] 0.174411
```

```r
u_sam_vec <- c()                #create empty vector for the sampling distribution
for (i in 1:10000){                 #10000 simulations
  u_mean<-sum(runif(100,0,6))      #take the AVERAGE of sample of 100 r.v.
  u_sam_vec<-c(u_sam_vec,u_mean)}   #add this to the sampling distribution vector
hist(u_sam_vec,freq=F,              #graph the sampling distribution
     main="Histogram of Sample Means")   
line_fit<-seq(220,400,by=0.001) 
lines(line_fit,dnorm(line_fit,300,17.32),col="green")
```

![](CLT_files/figure-html/unnamed-chunk-9-1.png)<!-- -->

```r
mean(u_sam_vec)                 #mean should be approx. 300 by CLT
```

```
## [1] 299.8912
```

```r
sd(u_sam_vec)                   #mean should be approx. 17.32 by CLT
```

```
## [1] 17.22754
```
