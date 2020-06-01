//
//  CustomView.h
//  BottomPopup
//
//  Created by 08liter on 2020/04/08.
//  Copyright © 2020 08liter. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface CustomView : UIView <WKNavigationDelegate>
@property (weak, nonatomic) IBOutlet UIView *contentView;
- (void)loadHtml;
@end

NS_ASSUME_NONNULL_END
