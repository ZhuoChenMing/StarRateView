# StarRateView

样式

 ![image](https://github.com/ZhuoChenMing/StarRateView/blob/master/sc.png)

使用：引入头文件后

        StarRateView *starRateView = [[StarRateView alloc] initWithFrame:CGRectMake(lableWidth, 0, width - lableWidth, height) numberOfStars:5];
        starRateView.scorePercent =  3 / 5.0;
        starRateView.allowIncompleteStar = YES;
        starRateView.hasAnimation = YES;
        [self.view addSubview:starRateView];
