//
//  StarRateView.m
//  boleketang
//
//  Created by boleketang on 16/1/26.
//  Copyright © 2016年 boleketang. All rights reserved.
//

#import "StarRateView.h"

#define InactiveImageName @"light_off"
#define ActiveImageName @"light_on"

#define StarNum 5
#define ANIMATION_TIME_INTERVAL 0.2

@interface StarRateView ()

@property (nonatomic, strong) UIView *activeStarView;

@property (nonatomic, strong) UIView *inactiveStarView;

@property (nonatomic, assign) NSInteger numberOfStars;

@end

@implementation StarRateView
#pragma mark - Init Methods
- (instancetype)init {
    NSAssert(NO, @"You should never call this method in this class. Use initWithFrame: instead!");
    return nil;
}

- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame numberOfStars:StarNum];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        _numberOfStars = StarNum;
        [self initProperties];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame numberOfStars:(NSInteger)numberOfStars {
    if (self = [super initWithFrame:frame]) {
        _numberOfStars = numberOfStars;
        [self initProperties];
    }
    return self;
}

#pragma mark - Private Methods
- (void)initProperties {
    self.scorePercent = 1;
    self.hasAnimation = NO;
    self.allowIncompleteStar = NO;
    
    self.inactiveStarView = [self createStarViewWithImageName:InactiveImageName];
    self.inactiveStarView.frame = self.bounds;
    [self addSubview:self.inactiveStarView];
    
    self.activeStarView = [self createStarViewWithImageName:ActiveImageName];
    [self addSubview:self.activeStarView];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    tapGesture.numberOfTapsRequired = 1;
    [self addGestureRecognizer:tapGesture];
}

- (UIView *)createStarViewWithImageName:(NSString *)imageName {
    UIView *view = [[UIView alloc] init];
    view.clipsToBounds = YES;
    view.backgroundColor = [UIColor clearColor];
    for (NSInteger i = 0; i < self.numberOfStars; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        imageView.frame = CGRectMake(i * self.bounds.size.width / self.numberOfStars, 0, self.bounds.size.width / self.numberOfStars, self.bounds.size.height);
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [view addSubview:imageView];
    }
    return view;
}

- (void)tap:(UITapGestureRecognizer *)gesture {
    CGPoint tapPoint = [gesture locationInView:self];
    CGFloat offset = tapPoint.x;
    CGFloat realStarScore = offset / (self.bounds.size.width / self.numberOfStars);
    CGFloat starScore = self.allowIncompleteStar ? realStarScore : ceilf(realStarScore);
    self.scorePercent = starScore / self.numberOfStars;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    __weak StarRateView *weakSelf = self;
    CGFloat animationTimeInterval = self.hasAnimation ? ANIMATION_TIME_INTERVAL : 0;
    [UIView animateWithDuration:animationTimeInterval animations:^{
        weakSelf.activeStarView.frame = CGRectMake(0, 0, weakSelf.bounds.size.width * weakSelf.scorePercent, weakSelf.bounds.size.height);
    }];
}

#pragma mark - Get and Set Methods
- (void)setScorePercent:(CGFloat)scroePercent {
    if (_scorePercent == scroePercent) {
        return;
    }
    
    if (scroePercent < 0) {
        _scorePercent = 0;
    } else if (scroePercent > 1) {
        _scorePercent = 1;
    } else {
        _scorePercent = scroePercent;
    }
    
    if ([self.delegate respondsToSelector:@selector(starRateView:scroePercentDidChange:)]) {
        [self.delegate starRateView:self scroePercentDidChange:scroePercent];
    }
    
    [self setNeedsLayout];
}

@end
