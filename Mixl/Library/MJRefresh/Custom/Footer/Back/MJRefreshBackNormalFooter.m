//
//  MJRefreshBackNormalFooter.m
//  MJRefreshExample
//
//  Created by MJ Lee on 15/4/24.
//  Copyright (c) 2015. All rights reserved.
//

#import "MJRefreshBackNormalFooter.h"

@interface MJRefreshBackNormalFooter()
{
    __weak UIImageView *_arrowView;
}
@property (weak, nonatomic) UIActivityIndicatorView *loadingView;
@end

@implementation MJRefreshBackNormalFooter
#pragma mark -
- (UIImageView *)arrowView
{
    if (!_arrowView) {
        UIImage *image = [UIImage imageNamed:MJRefreshSrcName(@"arrow.png")] ?: [UIImage imageNamed:MJRefreshFrameworkSrcName(@"arrow.png")];
        UIImageView *arrowView = [[UIImageView alloc] initWithImage:image];
        [self addSubview:_arrowView = arrowView];
    }
    return _arrowView;
}


- (UIActivityIndicatorView *)loadingView
{
    if (!_loadingView) {
        UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:self.activityIndicatorViewStyle];
        loadingView.hidesWhenStopped = YES;
        [self addSubview:_loadingView = loadingView];
    }
    return _loadingView;
}

- (void)setActivityIndicatorViewStyle:(UIActivityIndicatorViewStyle)activityIndicatorViewStyle
{
    _activityIndicatorViewStyle = activityIndicatorViewStyle;
    
    self.loadingView = nil;
    [self setNeedsLayout];
}
#pragma makr -
- (void)prepare
{
    [super prepare];
    
    self.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
}

- (void)placeSubviews
{
    [super placeSubviews];
    
    
    self.arrowView.mj_size = self.arrowView.image.size;
    CGFloat arrowCenterX = self.mj_w * 0.5;
    if (!self.stateLabel.hidden) {
        arrowCenterX -= 100;
    }
    CGFloat arrowCenterY = self.mj_h * 0.5;
    self.arrowView.center = CGPointMake(arrowCenterX, arrowCenterY);
    
    
    self.loadingView.frame = self.arrowView.frame;
}

- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState
    
    
    if (state == MJRefreshStateIdle) {
        if (oldState == MJRefreshStateRefreshing) {
            self.arrowView.transform = CGAffineTransformMakeRotation(0.000001 - M_PI);
            [UIView animateWithDuration:MJRefreshSlowAnimationDuration animations:^{
                self.loadingView.alpha = 0.0;
            } completion:^(BOOL finished) {
                self.loadingView.alpha = 1.0;
                [self.loadingView stopAnimating];
                
                self.arrowView.hidden = NO;
            }];
        } else {
            self.arrowView.hidden = NO;
            [self.loadingView stopAnimating];
            [UIView animateWithDuration:MJRefreshFastAnimationDuration animations:^{
                self.arrowView.transform = CGAffineTransformMakeRotation(0.000001 - M_PI);
            }];
        }
    } else if (state == MJRefreshStatePulling) {
        self.arrowView.hidden = NO;
        [self.loadingView stopAnimating];
        [UIView animateWithDuration:MJRefreshFastAnimationDuration animations:^{
            self.arrowView.transform = CGAffineTransformIdentity;
        }];
    } else if (state == MJRefreshStateRefreshing) {
        self.arrowView.hidden = YES;
        [self.loadingView startAnimating];
    } else if (state == MJRefreshStateNoMoreData) {
        self.arrowView.hidden = YES;
        [self.loadingView stopAnimating];
    }
}

@end
