# Sydney Brake
# Assignment 1 Introduction to R

### Your assignment is not commented!
### -2

# #1 ----------------------------------------------------------------------
x <- c(1:5)+1 
### c() is unnecessary here; 1:5 works
x

# #2 ----------------------------------------------------------------------
set.seed(42)
exp <- rnorm(100, 1.1, .1) # experimental
set.seed(42)
con <- rnorm(100, 1, .1) # control

d <- (mean(exp)-mean(con))/(sqrt((sd(exp)^2+sd(con)^2)/2))
d

# #3 ----------------------------------------------------------------------
data<-seq(0,200,by=0.5)
data
set.seed(42)
dat.sample <- sample(data,50,replace = FALSE)
summary(dat.sample)


# #4 ----------------------------------------------------------------------
set.seed(42)
test<-rnorm(200, mean=80, sd=20)
test[test > 100] <- 100
test
sorted.test<-sort(test)
a<-length(test)-(length(test)/3)
top3rd<-sorted.test[a:length(test)]
mean(top3rd)
sd(top3rd)

A<-test[test>=90]
length(A)
B.1<-test[test>=80]
B<-B.1[B.1<90]
length(B)
C.1<-test[test>=70]
C<-C.1[C.1<80]
length(C)
D.1<-test[test>=60]
D<-D.1[D.1<70]
length(D)
F.1<-test[test>=0]
F<-F.1[F.1<60]
length(F)
length(A)+length(B)+length(C)+length(D)+length(F)

