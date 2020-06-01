//
//  BottomContainerView.m
//  BottomPopup
//
//  Created by 08liter on 2020/04/09.
//  Copyright © 2020 08liter. All rights reserved.
//

#import "BottomContainerView.h"

@implementation BottomContainerView
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    [self loadXib];
    return self;
}

- (void)loadXib{
    UIView* view = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil].firstObject;
    [view setFrame:self.bounds];
    [self addSubview:view];
}

- (void)addContentView:(UIView *)contentView{
    [contentView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.contentContainer addSubview:contentView];
    [self.contentContainer addConstraint:[NSLayoutConstraint constraintWithItem:contentView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.contentContainer attribute:NSLayoutAttributeLeading multiplier:1.f constant:0.f]];
    [self.contentContainer addConstraint:[NSLayoutConstraint constraintWithItem:contentView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.contentContainer attribute:NSLayoutAttributeTrailing multiplier:1.f constant:0.f]];
    [self.contentContainer addConstraint:[NSLayoutConstraint constraintWithItem:contentView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentContainer attribute:NSLayoutAttributeBottom multiplier:1.f constant:0.f]];
    [self.contentContainer addConstraint:[NSLayoutConstraint constraintWithItem:contentView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentContainer attribute:NSLayoutAttributeTop multiplier:1.f constant:0.f]];
}


@end
