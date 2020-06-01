//
//  DatePickerView.m
//  BottomPopup
//
//  Created by 08liter on 2020/04/29.
//  Copyright © 2020 08liter. All rights reserved.
//

#import "DatePickerView.h"

@implementation DatePickerView
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

@end
