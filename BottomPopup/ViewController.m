//
//  ViewController.m
//  BottomPopup
//
//  Created by 08liter on 2020/04/08.
//  Copyright © 2020 08liter. All rights reserved.
//

#import "ViewController.h"
#import "CustomView.h"
#import "BottomContainerView.h"
#import "BottomPopupViewer.h"
#import "DatePickerView.h"
@interface ViewController ()
@property (nonatomic, retain) BottomContainerView* targetView;
@property (nonatomic, retain) UIView* dimView;
@property (weak, nonatomic) IBOutlet UILabel *durLabel;
@property (weak, nonatomic) IBOutlet UIStepper *stepper;
@property (nonatomic, retain) BottomPopupViewer* viewer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_durLabel setText:[NSString stringWithFormat:@"%.01lf",_stepper.value]];
}


- (IBAction)actionEaseIn:(id)sender {
    [self showPoupLayerWithEase:PoupEaseIn];
}

- (IBAction)actionEaseOut:(id)sender {
    [self showPoupLayerWithEase:PoupEaseOut];
}
- (IBAction)actionEaseInOut:(id)sender {
    [self showPoupLayerWithEase:PoupEaseInOut];
}

- (IBAction)stepperChanged:(id)sender {
    [_durLabel setText:[NSString stringWithFormat:@"%.01lf",((UIStepper*)sender).value]];
}

- (void)showPoupLayerWithEase:(PoupEase)ease{
    if(!_viewer){
        _viewer = [BottomPopupViewer new];
    }
    
    [_viewer setDuration:_stepper.value];
    [_viewer setEase:ease];
    
    [_viewer showContentView:[[CustomView alloc] initWithFrame:CGRectZero] from:self];
//    [_viewer showContentView:[[DatePickerView alloc] initWithFrame:CGRectZero] from:self];
}

@end
