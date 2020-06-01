//
//  BottomPopupViewer.h
//  BottomPopup
//
//  Created by 08liter on 2020/04/09.
//  Copyright © 2020 08liter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BottomContainerView.h"
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, PoupEase) {
    PoupEaseIn,
    PoupEaseOut,
    PoupEaseInOut,
};

@interface BottomPopupViewer : NSObject
@property (nonatomic, retain) UIViewController* _Nullable  parentViewController;
@property (nonatomic, retain) UIView* _Nullable dimView;
@property (nonatomic, retain) UIView* _Nullable contentView;
@property (nonatomic, retain) BottomContainerView* _Nullable bottomContainer;
@property (assign) CGFloat duration;
@property (assign) PoupEase ease;
- (void)showContentView:(UIView*)contentView from:(UIViewController*)from;
- (void)hideContentView;
@end

NS_ASSUME_NONNULL_END
