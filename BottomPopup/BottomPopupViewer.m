//
//  BottomPopupViewer.m
//  BottomPopup
//
//  Created by 08liter on 2020/04/09.
//  Copyright © 2020 08liter. All rights reserved.
//

#import "BottomPopupViewer.h"

@implementation BottomPopupViewer

- (id)init{
    self = [super init];
    [self initValue];
    return self;
}

- (void)initValue{
    _duration = 0.3f;
    _ease = PoupEaseInOut;
}

- (void)showContentView:(UIView *)contentView from:(UIViewController *)from{
    _parentViewController = from;
    _contentView = contentView;
    _bottomContainer = [[BottomContainerView alloc] initWithFrame:CGRectZero];
    
    [self startAnimation:_bottomContainer];
}

- (void)hideContentView{
    [self handleTap];
}

- (void)startAnimation:(UIView*)target{
    CATransition* transition = [CATransition animation];
    [transition setType:kCATransitionMoveIn];
    [transition setSubtype:kCATransitionFromTop];
    [transition setTimingFunction:[CAMediaTimingFunction functionWithName: _ease == 0 ? kCAMediaTimingFunctionEaseIn : _ease == 1 ? kCAMediaTimingFunctionEaseOut : kCAMediaTimingFunctionEaseInEaseOut]];
    [transition setDuration:_duration];
    
    [[target layer] addAnimation:transition forKey:nil];
    
    [self showDim];
    [self addTargetView];
}

- (void)handleTap{
    [self hideDim];
    [self removeTargetView];
}

- (void)hideDim{
    [UIView animateWithDuration:_duration animations:^{
        [self.dimView setAlpha:0.f];
    } completion:^(BOOL finished) {
        [self.dimView removeFromSuperview];
        self.dimView = nil;
    }];
}

- (void)showDim{
    _dimView = [[UIView alloc] initWithFrame:CGRectZero];
    [_dimView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_dimView setBackgroundColor:[UIColor blackColor]];
    [_dimView setAlpha:0.f];
    [_dimView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap)]];
    [self.parentViewController.view addSubview:_dimView];
    [self.parentViewController.view addConstraint:[NSLayoutConstraint constraintWithItem:_dimView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.parentViewController.view attribute:NSLayoutAttributeLeading multiplier:1.f constant:0.f]];
    [self.parentViewController.view addConstraint:[NSLayoutConstraint constraintWithItem:_dimView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.parentViewController.view attribute:NSLayoutAttributeTrailing multiplier:1.f constant:0.f]];
    [self.parentViewController.view addConstraint:[NSLayoutConstraint constraintWithItem:_dimView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.parentViewController.view attribute:NSLayoutAttributeBottom multiplier:1.f constant:0.f]];
    [self.parentViewController.view addConstraint:[NSLayoutConstraint constraintWithItem:_dimView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.parentViewController.view attribute:NSLayoutAttributeTop multiplier:1.f constant:0.f]];
    
    [UIView animateWithDuration:_duration animations:^{
        [self.dimView setAlpha:0.35];
    }];
}

- (void)addTargetView{
    [self.parentViewController.view addSubview:_bottomContainer];
    [_bottomContainer setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.parentViewController.view addConstraint:[NSLayoutConstraint constraintWithItem:_bottomContainer attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.parentViewController.view attribute:NSLayoutAttributeLeading multiplier:1.f constant:0.f]];
    [self.parentViewController.view addConstraint:[NSLayoutConstraint constraintWithItem:_bottomContainer attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.parentViewController.view attribute:NSLayoutAttributeTrailing multiplier:1.f constant:0.f]];
    [self.parentViewController.view addConstraint:[NSLayoutConstraint constraintWithItem:_bottomContainer attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.parentViewController.view attribute:NSLayoutAttributeBottom multiplier:1.f constant:0.f]];
    
    [_bottomContainer addContentView:_contentView];
    
    
}

- (void)removeTargetView{
    if(_bottomContainer){
        [UIView animateWithDuration:_duration animations:^{
            CGAffineTransform transform = CGAffineTransformMakeTranslation(0, self.bottomContainer.frame.size.height);
            [self.bottomContainer setTransform:transform];
            
        } completion:^(BOOL finished) {
            [self.bottomContainer removeFromSuperview];
            self.bottomContainer = nil;
        }];
        
    }
}

@end
