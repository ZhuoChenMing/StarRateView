//
//  StarRateView.h
//  boleketang
//
//  Created by boleketang on 16/1/26.
//  Copyright © 2016年 boleketang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class StarRateView;

@protocol StarRateViewDelegate <NSObject>

@optional
- (void)starRateView:(StarRateView *)starRateView scroePercentDidChange:(CGFloat)newScorePercent;

@end

@interface StarRateView : UIView

//得分比例，默认为1
@property (nonatomic, assign) CGFloat scorePercent;

//是否允许动画，默认为NO
@property (nonatomic, assign) BOOL hasAnimation;

//评分时是否允许不是整星，默认为NO
@property (nonatomic, assign) BOOL allowIncompleteStar;

@property (nonatomic, weak) id<StarRateViewDelegate>delegate;

- (instancetype)initWithFrame:(CGRect)frame numberOfStars:(NSInteger)numberOfStars;

@end
