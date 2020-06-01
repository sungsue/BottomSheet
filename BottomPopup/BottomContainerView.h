//
//  BottomContainerView.h
//  BottomPopup
//
//  Created by 08liter on 2020/04/09.
//  Copyright © 2020 08liter. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BottomContainerView : UIView
@property (weak, nonatomic) IBOutlet UIView *contentContainer;
- (void)addContentView:(UIView*)contentView;
@end

NS_ASSUME_NONNULL_END
