Module 5 Project 1
==================


The first is to load the personal movement data from the 'activity.csv' file. 


```r
pdata<-read.csv("activity.csv")
```

I am using the 'dplyr' library to help me in some of the analyses. 

```r
library (dplyr)
```

```
## 
## Attaching package: 'dplyr'
## 
## The following object is masked from 'package:stats':
## 
##     filter
## 
## The following objects are masked from 'package:base':
## 
##     intersect, setdiff, setequal, union
```


### What is mean total number of steps taken per day?

1. Calculate the total number of steps taken per day

To answer this, I need to group pdata by date and then sum up the steps.

```r
pdata1<-group_by (pdata, date)

sum_pdata<-summarise(pdata1, total=sum(steps))
```

2. If you do not understand the difference between a histogram and a barplot, research the difference between them. Make a histogram of the total number of steps taken each day


```r
hist(sum_pdata$total, main="Histogram of the total number of steps taken per day", xlab="Total number of steps taken per day")
```

![plot of chunk unnamed-chunk-4](figure/unnamed-chunk-4-1.png) 

3. Calculate and report the mean and median of the total number of steps taken per day


```r
mean(sum_pdata$total, na.rm=TRUE)
```

```
## [1] 10766.19
```

```r
median (sum_pdata$total, na.rm=TRUE)
```

```
## [1] 10765
```

The mean total number of steps taken per day is about 10766 steps.
The median total number of steps taken per day is about 10765 steps.

### What is the average daily activity pattern?

1. Make a time series plot (i.e. type = "l") of the 5-minute interval (x-axis) and the average number of steps taken, averaged across all days (y-axis)

To answer this, I need to group pdata by interval and then compute the average steps.

```r
pdata1<-group_by (pdata, interval)

ave_pdata<-summarise(pdata1, ave=mean(steps, na.rm=TRUE))
```

The chart below show a time series plot (i.e. type = "l") of the 5-minute interval (x-axis) and the average number of steps taken, averaged across all days (y-axis)


```r
plot(ave_pdata$interval, ave_pdata$ave, type="l", xlab="Interval", ylab="Average steps", main ="Average steps taken across all days")
```

![plot of chunk unnamed-chunk-7](figure/unnamed-chunk-7-1.png) 

2. Which 5-minute interval, on average across all the days in the dataset, contains the maximum number of steps?

```r
ave_pdata[which.max(ave_pdata$ave),]$interval
```

```
## [1] 835
```

The 835th interval.

### Imputing missing values

1. Calculate and report the total number of missing values in the dataset (i.e. the total number of rows with NAs)


```r
sum (is.na(pdata))
```

```
## [1] 2304
```

2. Devise a strategy for filling in all of the missing values in the dataset. The strategy does not need to be sophisticated. For example, you could use the mean/median for that day, or the mean for that 5-minute interval, etc.

The strategy I used was to use the average steps for that interval computed in the earlier step. To fill the NAs, I cycled through the original pdata to replace them with the average steps.

3. Create a new dataset that is equal to the original dataset but with the missing data filled in


```r
filled_pdata<-pdata
filled_counter<-0

for (indx in 1:nrow(filled_pdata)) {
  if (is.na(filled_pdata[indx,]$steps)) {
    which_interval<-filled_pdata[indx,]$interval
    filled_pdata[indx,]$steps<-ave_pdata[ave_pdata$interval==which_interval,]$ave
    filled_counter=filled_counter+1
  }
  indx<-indx+1
}

print (paste("No of NAs filled", filled_counter, sep=" " ))
```

```
## [1] "No of NAs filled 2304"
```

4. Make a histogram of the total number of steps taken each day and Calculate and report the mean and median total number of steps taken per day. 


```r
pdata1<-group_by (filled_pdata, date)

sum_filled_pdata<-summarise(pdata1, total=sum(steps))

hist(sum_filled_pdata$total, main="Histogram of the total number of steps taken per day (using missing values imputed)", xlab="Total number of steps taken per day")
```

![plot of chunk unnamed-chunk-11](figure/unnamed-chunk-11-1.png) 

```r
mean(sum_filled_pdata$total, na.rm=TRUE)
```

```
## [1] 10766.19
```

```r
median (sum_filled_pdata$total, na.rm=TRUE)
```

```
## [1] 10766.19
```

Do these values differ from the estimates from the first part of the assignment? What is the impact of imputing missing data on the estimates of the total daily number of steps?

The mean did not change; the median changed and was the same as the mean after imputing the missing values.The impact is considered marginal (i.e. a difference of 1 step out of 10000 plus steps per day)


### Are there differences in activity patterns between weekdays and weekends?

1. Create a new factor variable in the dataset with two levels - "weekday" and "weekend" indicating whether a given date is a weekday or weekend day.


```r
for (indx in 1:nrow(filled_pdata)) {
  which_day<-weekdays(as.Date(filled_pdata[indx,]$date, "%Y-%m-%d"))
  
  if (which_day %in% c("Saturday", "Sunday")) {
    filled_pdata[indx,"day"]="weekend"
  } else {
    filled_pdata[indx,"day"]="weekday"
  }
  indx<-indx+1
}

filled_pdata$day = factor(filled_pdata$day, levels = c("weekday", "weekend"))
```

2. Make a panel plot containing a time series plot (i.e. type = "l") of the 5-minute interval (x-axis) and the average number of steps taken, averaged across all weekday days or weekend days (y-axis). 


```r
ave_pdata2 = aggregate(steps ~ interval + day, filled_pdata, mean)

library (ggplot2)
output_plot <- qplot (y=steps, x=interval, data=ave_pdata2, color=day)
output_plot + geom_line() + labs (x = "Interval") + labs (y = "Average Steps") + labs (title = "Comparison between average steps taken on weekend and weekday")
```

![plot of chunk unnamed-chunk-13](figure/unnamed-chunk-13-1.png) 


